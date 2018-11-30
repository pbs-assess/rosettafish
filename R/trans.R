#' English to French
#'
#' @param x text
#' @param translate logical
#'
#' @export
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
#' @param sep seperator between multiple 'to' languages
#'
#' @export
trans <- function(x, to = "english", from = "french", sep = ";") {

  from.vec <- rosetta_terms[, from, drop = TRUE]
  browser()
  to.df <- rosetta_terms[, to, drop = FALSE]

  j <- match(x, from.vec)
  v <- to.df[j,]
  v[is.na(j)] <- x[is.na(j)]
  if(class(v) == "data.frame"){
   v <- as.character(apply(v, 1, function(x){ paste0(x, collapse = sep)}))
  }
  v
}
