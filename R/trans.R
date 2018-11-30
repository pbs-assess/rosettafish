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
  trans(x, from = "english", to = "french")
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
  trans(x, from = "french", to = "english")
}

#' Translate from one language to another
#' 
#' @param x text
#' @param from language to translate from
#' @param to language to translate to
#' @param sep seperator between multiple 'to' languages
#'
#' @export
trans <- function(x, from = "french", to = "english", sep = ";") {

  from.vec <- rosetta_terms[, from, drop = TRUE]
  to.df <- rosetta_terms[, to, drop = FALSE]

  j <- match(x, from.vec)
  v <- to.df[j,]
  v[is.na(j)] <- x[is.na(j)]
  if(class(v) == "data.frame"){
   v <- as.character(apply(v, 1, function(x){ paste0(x, collapse = sep)}))
  }
  v
}
