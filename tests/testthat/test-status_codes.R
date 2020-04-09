test_that("status_codes_data", {
  expect_is(status_codes, "list")
  expect_is(status_codes[[1]], "list")

  # each element
  expect_equal(length(status_codes[[1]]), 3)
  expect_is(status_codes[[1]][[1]], "character")
  expect_is(status_codes[[1]][[2]], "character")
  expect_is(status_codes[[1]][[3]], "character")

  # can get elements by status code
  expect_is(status_codes['404'], "list")
  expect_named(status_codes['404'])
  expect_is(status_codes[['404']], "list")
  expect_named(status_codes['404'], "404")
})
