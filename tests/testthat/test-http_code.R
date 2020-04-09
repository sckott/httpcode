test_that("http_code works", {
  x <- http_code(400)

  expect_is(x, "http_code")
  expect_is(unclass(x), "list")
  expect_is(x$status_code, "character")
  expect_is(x$message, "character")
  expect_is(x$explanation, "character")
  expect_null(x$verbose_explanation)
  expect_equal(x$status_code, "400")
  expect_equal(x$message, "Bad Request")
  expect_output(print(x), "<Status code")

  w <- http_code(401, verbose = TRUE)

  expect_is(w, "http_code")
  expect_is(unclass(w), "list")
  expect_is(w$status_code, "character")
  expect_is(w$message, "character")
  expect_is(w$explanation, "character")
  expect_is(w$verbose_explanation, "character")
  expect_equal(w$status_code, "401")
  expect_equal(w$message, "Unauthorized")
  expect_output(print(w), "<Status code")
  expect_output(print(w), "Verbose Explanation")
})

test_that("http_code fails well", {
  # no input, code is required
  expect_error(http_code())
  # non-allowed classes
  expect_error(http_code(as.factor("foobar")), "class")
  # code not found
  expect_error(http_code(33333), "No description found")
  # must be length 1
  expect_error(http_code(1:3))
})

