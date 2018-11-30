#' English to French
#'
#' @param x text
#' @param translate logical
#'
#' @export
#' @rdname trans
en2fr <- function(x, translate = TRUE) {
  if (!translate) {
    return(x)
  }
  trans(x, to = "french", from = "english")
}

#' French to English
#' 
#' @param x text
#' @param translate logical
#'
#' @export
#' @rdname trans
fr2en <- function(x, translate = TRUE) {
  if (!translate) {
    return(x)
  }
  trans(x, to = "english", from = "french")
}

#' Translate from one language to another
#' 
#' @param x text
#' @param to language to translate to
#' @param from language to translate from
#'
#' @export
#' @rdname trans
trans <- function(x, to = "english", from = "french") {

  to.vec <- rosetta_terms[, to, drop = TRUE]
  from.vec <- rosetta_terms[, from, drop = TRUE]

  j <- match(x, from.vec)
  v <- to.vec[j]
  v[is.na(j)] <- x[is.na(j)]
  v
}
