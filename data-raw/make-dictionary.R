rosetta_terms <- as.data.frame(readr::read_csv("inst/extdata/terms.csv"))

language <- "english"
rosetta_terms <- rosetta_terms[order(rosetta_terms[[language]]), , drop = FALSE]

readr::write_csv(rosetta_terms, "inst/extdata/terms.csv")

usethis::use_data(rosetta_terms, overwrite = TRUE, internal = TRUE)

