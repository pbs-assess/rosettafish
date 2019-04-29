context("trans.R")

test_that("translate 3 from en to fr in data", {
  expect_equal(trans(c("spawning biomass","male","equipment"),
                     to = "french",
                     from = "english"),
               c("biomasse reproductrice", "mâle", "équipement"))
})

test_that("translate 3 from en to sp in data", {
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

test_that("translate into 2 languages from en", {
  expect_equal(trans("male",
                     to = c("english", "french"),
                     from = "english", sep = "; "),
      "male; mâle")
})

test_that("translate into 2 languages from en, values don't exist in data", {
  expect_equal(trans(x = c("xxx", "yyy"),
                     to = c("english", "french"),
                     from = "english", sep = "; "),
               c("xxx; xxx", "yyy; yyy"))
})


test_that("translate into 2 languages from en. French and inuktitut.", {
  expect_equal(trans(x = "depth",
                     to = c("french", "inuktitut"),
                     from = "english", sep = "; "),
               "profondeur; ᐃᑎᔪᖅ")
})

test_that("give error on a word with no translation", {
  expect_error(trans("missingterm",
                     to = "french",
                     from = "english",
                     allow_missing = FALSE))
})

test_that("give error on multiple words with no translation", {
  expect_error(trans(c("missingterm", "missingterm2"),
                     to = "french",
                     from = "english",
                     allow_missing = FALSE))
})

test_that("give error on a word with no translation when other words have a match", {
  expect_error(trans(c("missingterm", "depth"),
                     to = "french",
                     from = "english",
                     allow_missing = FALSE))
})

test_that("give error on multiple words with no translation when other words have a match", {
  expect_error(trans(c("missingterm", "missingterm2", "depth"),
                     to = "french",
                     from = "english",
                     allow_missing = FALSE))
})

test_that("en2fr, en2sp, fr2en, and sp2en work as expected", {
  expect_equal(en2fr("depth", TRUE), "profondeur")
  expect_equal(en2fr("depth", FALSE), "depth")
  expect_equal(fr2en("profondeur", TRUE), "depth")
  expect_equal(fr2en("profondeur", FALSE), "profondeur")

  expect_equal(en2sp("Acadian Redfish", TRUE), "sébaste acadien")
  expect_equal(en2sp("Acadian Redfish", FALSE), "Acadian Redfish")
  expect_equal(sp2en("tieso pustuloso", TRUE), "Acned Snake Eel")
  expect_equal(sp2en("tieso pustuloso", FALSE), "tieso pustuloso")
})
