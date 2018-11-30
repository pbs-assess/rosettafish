context("trans.R")

test_that("translate 3 from en to fr in data", {
  expect_equal(trans(c("spawning biomass","male","equipment"),
                     to = "french",
                     from = "english"),
               c("biomasse reproductrice", "mâle", "équipement"))
})

test_that("translate 3 from en to fr in data, one missing", {
  expect_equal(trans(c("spawning biomass","male","X"),
                     to = "french",
                     from = "english"),
               c("biomasse reproductrice", "mâle", "X"))
})

test_that("translate 3 from en to fr in data in data, all missing", {
  expect_equal(trans(c("X","Y","Z"),
                     to = "french",
                     from = "english"),
               c("X", "Y", "Z"))
})

test_that("translate 3 from en to fr in data in data, with an NA", {
  expect_equal(trans(c("spawning biomass","male", NA),
                     to = "french",
                     from = "english"),
               c("biomasse reproductrice", "mâle", NA))
})

# data.test <- data.frame(english = c("A","B","C","D","E","F"),
#                    french = c("AA", "BB", "CC", "DD", "EE", "FF"),
#                    stringsAsFactors = FALSE)
