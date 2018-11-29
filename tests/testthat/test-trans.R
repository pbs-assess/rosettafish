context("trans.R")

test_that("translate 3 from en to fr in data", {
  expect_equal(trans(c("A","B","C")),
               c("AA", "BB", "CC"))
})

test_that("translate 3 from en to fr in data, one missing", {
  expect_equal(trans(c("A","B","X")),
               c("AA", "BB", "X"))
})

test_that("translate 3 from en to fr in data in data, all missing", {
  expect_equal(trans(c("X","Y","Z")),
               c("X", "Y", "Z"))
})

test_that("translate 3 from en to fr in data in data, with an NA", {
  expect_equal(trans(c("A","B", NA)),
               c("AA", "BB", NA))
})
