rosetta_terms <- read.csv("inst/extdata/terms.csv", stringsAsFactors = FALSE, 
  strip.white = TRUE, fileEncoding = "utf8")

language <- "english"
rosetta_terms <- rosetta_terms[order(rosetta_terms[[language]]), , drop = FALSE]

usethis::use_data(rosetta_terms, overwrite = TRUE, internal = TRUE)

