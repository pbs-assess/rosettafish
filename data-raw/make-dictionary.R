rosetta_terms <- as.data.frame(readr::read_csv("data-raw/terms.csv", show_col_types = FALSE))

language <- "english"
rosetta_terms <- rosetta_terms[order(rosetta_terms[[language]]), , drop = FALSE]
row.names(rosetta_terms) <- NULL
readr::write_csv(rosetta_terms, "data-raw/terms.csv")

df <- rosetta_terms
df$english <- tolower(df$english)
df$french <- tolower(df$french)
# df$inuktitut <- tolower(df$inuktitut)

# dups <- union(which(duplicated(df$english)), which(duplicated(df$french)))
dups <- which(duplicated(df$english))

if (length(dups > 0)) {
  stop("The following lines have duplicates: ", paste(sort(dups) + 1, collapse = ", "))
}

usethis::use_data(rosetta_terms, overwrite = TRUE, internal = TRUE)
