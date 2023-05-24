context("test-sarb_code.R")

test_that("error on no token provided", {
  expect_error(sarb_code())
})

test_that("error on bad (not 200) request", {
  expect_error(sarb_code(token = 2432542))
})

test_that("succesful call returns tibble object", {
  expect_is(sarb_code(code = "KBP1434D", token = Sys.getenv("sarb.token")), c("tibble", "tbl_df"))
})
