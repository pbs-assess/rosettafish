#' Title
#'
#' Sort fishrosetta input .csv file alphabetically for both
#'
#' @param language Language column in source terms.csv file to sort by. Either
#' "En" for English or "Fr" for French.
#'
#' @return Dataframe ordered by specified language column.
#' @export
#'
#' @examples
#' terms_En <- sort_lang("En")
#' terms_Fr <- sort_lang("Fr")
sort_lang <- function(language) {
  if (language == "En") {
  rosetta_terms <- dplyr::arrange(rosetta_terms, english)
  }
  if (language == "Fr") {
  rosetta_terms <- dplyr::arrange(rosetta_terms, french)
  }
  readr::write_csv(rosetta_terms, "inst/extdata/terms.csv")
}
