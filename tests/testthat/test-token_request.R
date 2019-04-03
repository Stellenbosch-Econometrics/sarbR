context("test-token_request.R")

test_that("get request worked", {
  expect_length(token_request(), 3)
})

test_that("get request worked", {
  expect_is(token_request(), "list")
})

test_that("get request worked", {
  expect_message(token_request())
})

