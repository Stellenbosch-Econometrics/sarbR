context("test-search_indicator-r.R")

test_that("If code is provided", {
  expect_is(search_indicator(code = "KBP1000J"), c("data.frame", "tbl_df"))
})

test_that("If code is provided, but numeric", {
  expect_error(search_indicator(code = 1213))
})

test_that("description OR time_series_code must be provided", {
  expect_error(search_indicator())
})

test_that("missing times_series_code works", {
  expect_is(search_indicator(time_series = "KBP1434"), c("data.frame", "tbl_df"))
})

test_that("times_series_code must be character", {
  expect_error(search_indicator(time_series_code = 1234))
})

test_that("missing description works", {
  expect_is(search_indicator(description = "Expenditure"), c("data.frame", "tbl_df"))
})

test_that("description must be character", {
  expect_error(search_indicator(description = 1234))
})
