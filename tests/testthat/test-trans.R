context("trans.R")

test_that("translate 3 from en to fr in data", {
  expect_equal(tolower(trans(c("Spawning biomass","Male","Equipment"),
                     to = "french",
                     from = "english")),
               c("biomasse reproductrice", "mâle", "équipement"))
})

test_that("translate 3 from en to fr in data, one missing", {
  expect_equal(tolower(trans(c("Spawning biomass","Male","X"),
                     to = "french",
                     from = "english", allow_missing = TRUE)),
               c("biomasse reproductrice", "mâle", "x"))
})

test_that("translate 3 from en to fr in data in data, all missing", {
  expect_equal(trans(c("X","Y","Z"),
                     to = "french",
                     from = "english", allow_missing = TRUE),
               c("X", "Y", "Z"))
})

test_that("translate 3 from en to fr in data in data, with an NA", {
  expect_equal(tolower(trans(c("Spawning biomass","Male", NA),
                     to = "french",
                     from = "english", allow_missing = TRUE)),
               c("biomasse reproductrice", "mâle", NA))
})

test_that("translate into 2 languages from en", {
  expect_equal(tolower(trans("Male",
                     to = c("english", "french"),
                     from = "english", sep = "; ")),
      "male; mâle")
})

test_that("translate into 2 languages from en, values don't exist in data", {
  expect_equal(trans(x = c("xxx", "yyy"),
                     to = c("english", "french"),
                     from = "english", sep = "; ", allow_missing = TRUE),
               c("xxx; xxx", "yyy; yyy"))
})


test_that("translate into 2 languages from en. French and inuktitut.", {
  expect_equal(tolower(trans(x = "Depth",
                     to = c("french", "inuktitut"),
                     from = "english", sep = "; ")),
               "profondeur; ᐃᑎᔪᖅ")
})

test_that("en2fr and fr2en work as expected", {
  expect_equal(en2fr("Depth", TRUE), "Profondeur")
  expect_equal(en2fr("Depth", FALSE), "Depth")
  expect_equal(fr2en("Profondeur", TRUE), "Depth")
  expect_equal(fr2en("Profondeur", FALSE), "Profondeur")
})
