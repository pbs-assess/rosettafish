#' Title here
#'
#' @param x text
#' @param translate logical
#' @param from_french logical
#'
#' @export
#' @rdname trans
en2fr <- function(x, translate = TRUE) {
  if (!translate) {
    return(x)
  }
  trans(x, from_french = FALSE)
}

#' @export
#' @rdname trans
fr2en <- function(x, translate = TRUE) {
  if (!translate) {
    return(x)
  }
  trans(x, from_french = TRUE)
}

#' @export
#' @rdname trans
trans <- function(x, from_french = FALSE) {
  
  if (from_french) {
    col <- "french"
    col2 <- "english"
  } else {
    col <- "english"
    col2 <- "french"
  }

  from <- rosetta_terms[, col, drop = TRUE]
  to <- rosetta_terms[, col2, drop = TRUE]

  j <- match(x, from)
  v <- to[j]
  v[is.na(j)] <- x[is.na(j)]
  v
}
