context("trans.R")

test_that("translate 3 from en to fr in data", {
  expect_equal(
    tolower(trans(c("Spawning biomass", "Male", "Equipment"),
      to = "french",
      from = "english"
    )),
    c("biomasse reproductrice", "mâle", "équipement")
  )
})

test_that("translate 3 from en to fr in data, one missing", {
  expect_equal(
    tolower(trans(c("Spawning biomass", "Male", "X"),
      to = "french",
      from = "english", allow_missing = TRUE
    )),
    c("biomasse reproductrice", "mâle", "x")
  )
})

test_that("translate 3 from en to fr in data in data, all missing", {
  expect_equal(
    trans(c("X", "Y", "Z"),
      to = "french",
      from = "english", allow_missing = TRUE
    ),
    c("X", "Y", "Z")
  )
})

test_that("translate 3 from en to fr in data in data, with an NA", {
  expect_equal(
    tolower(trans(c("Spawning biomass", "Male", NA),
      to = "french",
      from = "english", allow_missing = TRUE
    )),
    c("biomasse reproductrice", "mâle", NA)
  )
})

test_that("translate into 2 languages from en", {
  expect_equal(
    tolower(trans("Male",
      to = c("english", "french"),
      from = "english", sep = "; "
    )),
    "male; mâle"
  )
})

test_that("translate into 2 languages from en, values don't exist in data", {
  expect_equal(
    trans(
      x = c("xxx", "yyy"),
      to = c("english", "french"),
      from = "english", sep = "; ", allow_missing = TRUE
    ),
    c("xxx; xxx", "yyy; yyy")
  )
})

# test_that("translate into 2 languages from en. French and inuktitut.", {
#   expect_equal(
#     tolower(trans(
#       x = "Depth",
#       to = c("french", "inuktitut"),
#       from = "english", sep = "; "
#     )),
#     "profondeur; ᐃᑎᔪᖅ"
#   )
# })

test_that("en2fr and fr2en work as expected", {
  expect_equal(en2fr("Depth", TRUE), "Profondeur")
  expect_equal(en2fr("Depth", FALSE), "Depth")
  expect_equal(fr2en("Profondeur", TRUE), "Depth")
  expect_equal(fr2en("Profondeur", FALSE), "Profondeur")
})

test_that("custom term data frames work", {
  df <- data.frame(english = c("aaa"), french = c("bbb"))
  expect_equal(trans("aaa",
    from = "english", to = "french",
    custom_terms = df
  ), "bbb")
  expect_equal(en2fr("aaa", custom_terms = df), "bbb")
  expect_error(en2fr("aaa", custom_terms = "not a data frame"))

  df <- data.frame(english = c("aaa"), not_french = c("bbb"))
  expect_error(en2fr("aaa", custom_terms = df))

  df <- data.frame(french = c("bbb"), english = c("aaa"))
  expect_equal(en2fr("aaa", custom_terms = df), "bbb")

  df <- data.frame(
    english = c("spawning biomass"),
    french = c("biomasse reproductrice")
  )
  expect_equal(
    en2fr("spawning biomass", custom_terms = df),
    "biomasse reproductrice"
  )

  df <- data.frame(
    english = c("spawning biomass"),
    french = c("TEST biomasse reproductrice")
  )
  expect_equal(
    en2fr("spawning biomass", custom_terms = df),
    "TEST biomasse reproductrice"
  )
})
