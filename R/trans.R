#' @export
#' @rdname trans
en2fr <- function(x, translate = TRUE,
                  case = c("none", "sentence", "lower", "upper", "title"),
                  ...) {
  if (!translate) {
    return(caseify(x, match.arg(case)))
  }
  trans(x, from = "english", to = "french", case = case, ...)
}

#' @export
#' @rdname trans
fr2en <- function(x, translate = TRUE,
                  case = c("none", "sentence", "lower", "upper", "title"),
                  ...) {
  if (!translate) {
    return(caseify(x, match.arg(case)))
  }
  trans(x, from = "french", to = "english", case = case, ...)
}

#' Translate a word or phrase from one language to another
#'
#' These functions facilitate translation of fish and fisheries related terms
#' between English and French. `trans()` does all the work, but the helper
#' functions `en2fr()` and `fr2en()` are probably the easiest to work with in
#' practice.
#'
#' @param x Word or phrase to translate.
#' @param translate Logical: perform the translation if `TRUE`.
#' @param from Language to translate from.
#' @param to Language to translate to.
#' @param case Text case. `"none"` uses the value in the built-in dictionary
#'   verbatim.
#' @param sep Seperator between multiple `to` languages.
#' @param allow_missing Should the function return the input value if the term
#'   is missing from the dictionary? If `FALSE` then the function will issue a
#'   `stop()` statement if anything is missing.
#' @param custom_terms An optional data frame that contains a temporary or
#'   one-off translation dictionary. Must have the column names `"english"` and
#'   `"french"`. This can be useful if you want to quickly build up a set of
#'   terms to add to the dictionary before submitting them to the official
#'   package dictionary or if you have some one-off translation that you don't
#'   think would be useful to anybody else.
#' @param ... Other arguments to be passed to [trans()] such as
#'   `allow_missing` or `custom_terms`.
#'
#' @export
#' @rdname trans
#' @examples
#' en2fr("Depth", TRUE)
#' en2fr("Depth", FALSE)
#' fr2en("Profondeur", TRUE)
#' fr2en("Profondeur", FALSE)
#' trans("Depth", from = "english", to = c("english", "french"))
#' df <- data.frame(english = c("aaa"), french = c("bbb"))
#' en2fr("aaa", custom_terms = df)
#' en2fr("Depth", TRUE, case = "none")
#' en2fr("Depth", TRUE, case = "upper")
#' en2fr("Depth", TRUE, case = "lower")
#' en2fr("Depth", TRUE, case = "sentence")
trans <- function(x, from = "english", to = "french",
                  case = c("none", "sentence", "lower", "upper", "title"),
                  sep = "; ", allow_missing = FALSE, custom_terms = NULL) {
  if (!is.null(custom_terms)) {
    if (!"data.frame" %in% class(custom_terms)) {
      stop("`custom_terms` must be a data frame.", call. = FALSE)
    }
    if (!identical(sort(colnames(custom_terms)), c("english", "french"))) {
      stop(
        "`custom_terms` must have the column names ",
        '`c("english", "french")`.',
        call. = FALSE
      )
    }
  }

  .rosetta_terms <- rosetta_terms
  dups <- match(custom_terms[[from]], rosetta_terms[[from]])
  dups <- stats::na.omit(dups)
  if (sum(dups) > 0L) {
    .rosetta_terms <- .rosetta_terms[-dups, , drop = FALSE]
  }
  term_terms <- rbind(.rosetta_terms, custom_terms)
  from.vec <- term_terms[, from, drop = TRUE]
  to.df <- term_terms[, to, drop = FALSE]

  j <- match(tolower(x), tolower(from.vec))

  if (!allow_missing) {
    if (any(is.na(j))) {
      if (sum(is.na(j)) == 1L) {
        stop("The following term is not in the translation database: ",
          x[is.na(j)],
          call. = FALSE
        )
      } else {
        stop("The following terms are not in the translation database: ",
          paste(x[is.na(j)], collapse = ", "),
          call. = FALSE
        )
      }
    }
  }
  if (length(to) == 1L) {
    v <- to.df[j, , drop = TRUE]
  } else {
    v <- to.df[j, , drop = FALSE]
  }
  v[is.na(j)] <- x[is.na(j)]

  case <- match.arg(case)

  if (length(to) == 1L) {
    v <- caseify(v, case = case)
  }

  if (length(to) > 1L) {
    v[] <- lapply(v, caseify, case = case)
    v <- as.character(apply(v, 1, function(x) {
      paste0(x, collapse = sep)
    }))
  }
  v
}

caseify <- function(x, case) {
  if (case == "lower") {
    x <- stringr::str_to_lower(x)
  } else if (case == "upper") {
    x <- stringr::str_to_upper(x)
  } else if (case == "sentence") {
    x <- stringr::str_to_sentence(x)
  } else if (case == "title") {
    x <- stringr::str_to_title(x)
  } else if (case == "none") {
    # nothing!
  }
  x
}
