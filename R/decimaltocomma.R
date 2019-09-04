#' Change all decimal points to commas in the vector provided
#'
#' @param num a vector of numeric
#'
#' @return a vector of the input with commas replacing the decimal points. This will be a character vector
#' @export
#'
#' @examples
#' d2c(c(1, 2.1, 3, 4.123, 5.01, 6, 7.0, 8))
d2c <- function(num){
  stopifnot(is.numeric(num))
  gsub("\\.", ",", num)
}
