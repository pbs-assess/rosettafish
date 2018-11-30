rosetta_terms <- read.csv("inst/extdata/terms.csv", stringsAsFactors = FALSE,
                          strip.white = TRUE, fileEncoding = "utf8",
                          comment.char = "#")

language <- "english"
rosetta_terms <- rosetta_terms[order(rosetta_terms[[language]]), , drop = FALSE]

write.csv(rosetta_terms, "inst/extdata/terms.csv", row.names = FALSE,
  fileEncoding = "utf8")

usethis::use_data(rosetta_terms, overwrite = TRUE, internal = TRUE)

