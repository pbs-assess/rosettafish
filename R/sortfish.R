# Author: Elise Keppel
# Date: November 29, 2018
# Purpose: Sort fishrosetta input .csv file alphabetically for both
# English and French.



#' Title
#'
#' @param language Language column in source terms.csv file to sort by. Either
#' "En" for English or "Fr" for French.
#'
#' @return Tibble ordered by specified language column.
#' @export
#'
#'
#' @examples
#' terms_En <- sortfish("En")
#' terms_Fr <- sortfish("Fr")
sortfish <- function(language) {
  if (language == "En") {
  data <- dplyr::arrange(data, english)
  }
  if (language == "Fr") {
  data <- dplyr::arrange(data, french)
  }
  readr::write_csv(data, "data/terms.csv")
}

