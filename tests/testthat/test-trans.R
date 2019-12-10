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

test_that("trans returns an error if term is missing", {
  expect_error(en2fr("Not here!", TRUE, allow_missing = FALSE))
  expect_error(en2fr(c("Not here!", "Nor here!"), TRUE, allow_missing = FALSE))
})

test_that("custom term data frames work", {
  df <- data.frame(english = c("Aaa"), french = c("Bbb"))
  expect_equal(trans("Aaa",
    from = "english", to = "french",
    custom_terms = df,
  ), "Bbb")
  expect_equal(en2fr("Aaa", custom_terms = df), "Bbb")
  expect_error(en2fr("Aaa", custom_terms = "not a data frame"))

  df <- data.frame(english = c("Aaa"), not_french = c("Bbb"))
  expect_error(en2fr("Aaa", custom_terms = df))

  df <- data.frame(french = c("Bbb"), english = c("Aaa"))
  expect_equal(en2fr("Aaa", custom_terms = df), "Bbb")

  df <- data.frame(
    english = c("Spawning biomass"),
    french = c("Biomasse reproductrice")
  )
  expect_equal(
    en2fr("Spawning biomass", custom_terms = df),
    "Biomasse reproductrice"
  )

  df <- data.frame(
    english = c("Spawning biomass"),
    french = c("TEST biomasse reproductrice")
  )
  expect_equal(
    en2fr("Spawning biomass", custom_terms = df),
    "TEST biomasse reproductrice"
  )
})

test_that("cases work", {
  df <- data.frame(english = c("aaa aaa"), french = c("bbb bbb"))
  expect_equal(en2fr("aaa aaa", custom_terms = df, case = "none"), "bbb bbb")
  expect_equal(en2fr("aaa aaa", custom_terms = df, case = "sentence"), "Bbb bbb")
  expect_equal(en2fr("aaa aaa", custom_terms = df, case = "lower"), "bbb bbb")
  expect_equal(en2fr("aaa aaa", custom_terms = df, case = "upper"), "BBB BBB")
  expect_equal(en2fr("aaa aaa", custom_terms = df, case = "title"), "Bbb Bbb")
  expect_equal(trans("aaa aaa", to = c("english", "french"),
    custom_terms = df, case = "title"), "Aaa Aaa; Bbb Bbb")
})
