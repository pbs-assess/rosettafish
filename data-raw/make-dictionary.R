rosetta_terms <- read.csv("inst/extdata/terms.csv", stringsAsFactors = FALSE, 
  strip.white = TRUE, fileEncoding = "utf8")

# https://stackoverflow.com/questions/18837855/making-non-ascii-data-suitable-for-cran
# Encoding(rosetta_terms$english) <- "latin1"
# rosetta_terms$english <- iconv(rosetta_terms$english, "latin1", "UTF-8")
# 
# Encoding(rosetta_terms$french) <- "latin1"
# rosetta_terms$french <- iconv(rosetta_terms$french, "latin1", "UTF-8")

usethis::use_data(rosetta_terms, overwrite = TRUE, internal = TRUE)

