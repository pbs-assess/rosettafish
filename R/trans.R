#' @export
#' @rdname trans
en2fr <- function(x, translate = TRUE, ...) {
  if (!translate) {
    return(x)
  }
  trans(x, from = "english", to = "french", ...)
}

#' @export
#' @rdname trans
fr2en <- function(x, translate = TRUE, ...) {
  if (!translate) {
    return(x)
  }
  trans(x, from = "french", to = "english", ...)
}

#' Translate a word or phrase from one language to another
#'
#' @param from language to translate from
#' @param to language to translate to
#' @param sep seperator between multiple 'to' languages
#' @param allow_missing Should the function return the input value if the term
#'   is missing from the dictionary? If `FALSE` then the function will issue a
#'   `stop()` statement if anything is missing.
#' @param x word or phrase to translate
#' @param translate Logical. Perform the translation if TRUE.
#' @param ... arguments passed to [trans()]
#'
#' @export
#' @rdname trans
trans <- function(x, from = "french", to = "english", sep = "; ",
                  allow_missing = FALSE) {
  from.vec <- rosetta_terms[, from, drop = TRUE]
  to.df <- rosetta_terms[, to, drop = FALSE]

  j <- match(x, from.vec)

  if (!allow_missing) {
    if (any(is.na(j))) {
      if (sum(is.na(j)) == 1L) {
        stop("The following term is not in the translation database: ", x[is.na(j)],
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
  v <- to.df[j, ]
  v[is.na(j)] <- x[is.na(j)]
  if (class(v) == "data.frame") {
    v <- as.character(apply(v, 1, function(x) {
      paste0(x, collapse = sep)
    }))
  }
  v
}
