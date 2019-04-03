context("test-sarb_code.R")

test_that("error on no token provided", {
  expect_error(sarb_code())
})

test_that("error on bad (not 200) request", {
  expect_error(sarb_code(token = 2432542))
})

test_that("succesful call returns tibble object", {
  expect_is(sarb_code(code = "KBP1434D", token = "f84d879ce6537dbacd93ac3dc073e364"), c("data.frame", "tbl_df"))
})
