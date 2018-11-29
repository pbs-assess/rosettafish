context("trans.R")

test_that("translate 3 from en to fr in data", {
  expect_equal(trans(c("spawning biomass","male","equipment")),
               c("biomasse reproductrice", "mâle", "équipement"))
})

test_that("translate 3 from en to fr in data, one missing", {
  expect_equal(trans(c("spawning biomass","male","X")),
               c("biomasse reproductrice", "mâle", "X"))
})

test_that("translate 3 from en to fr in data in data, all missing", {
  expect_equal(trans(c("X","Y","Z")),
               c("X", "Y", "Z"))
})

test_that("translate 3 from en to fr in data in data, with an NA", {
  expect_equal(trans(c("spawning biomass","male", NA)),
               c("biomasse reproductrice", "mâle", NA))
})
