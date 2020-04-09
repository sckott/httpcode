test_that("http_search works", {
  x <- http_search("request")

  expect_is(x, "list")
  for (i in seq_along(x)) expect_is(x[[i]], "http_code")
  expect_is(unclass(x[[1]]), "list")
  expect_is(x[[1]]$status_code, "character")
  expect_is(x[[1]]$message, "character")
  expect_is(x[[1]]$explanation, "character")
  expect_null(x[[1]]$verbose_explanation)
  expect_equal(x[[1]]$status_code, "100")
  expect_equal(x[[1]]$message, "Continue")
  expect_output(print(x[[1]]), "<Status code")

  w <- http_search("request", verbose = TRUE)

  expect_is(w, "list")
  for (i in seq_along(w)) expect_is(w[[i]], "http_code")
  expect_is(unclass(w[[10]]), "list")
  expect_is(w[[10]]$status_code, "character")
  expect_is(w[[10]]$message, "character")
  expect_is(w[[10]]$explanation, "character")
  expect_is(w[[10]]$verbose_explanation, "character")
  expect_equal(w[[10]]$status_code, "206")
  expect_equal(w[[10]]$message, "Partial Content")
  expect_output(print(w), "<Status code")
  expect_output(print(w), "Verbose Explanation")
})

test_that("http_search fails well", {
  # no input, text is required
  expect_error(http_search())
  # non-allowed classes
  expect_error(http_search(34), "class")
  # string not found
  expect_error(http_search("foobar"), "No status code found")
  # must be length 1
  expect_error(http_search(c("request", "forbidden")))
})

