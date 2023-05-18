test_that("cat_for_status", {
  x <- cat_for_status(100)

  expect_is(x, "character")
  expect_match(x, "https://httpcats.com/100")
})

test_that("dog_for_status", {
  w <- dog_for_status(400)

  expect_is(w, "character")
  expect_match(w, "https://http.dog/400.jpg")
})

test_that("cats and dogs fails well", {
  # no input, code is required
  expect_error(cat_for_status())
  expect_error(dog_for_status())
  # non-allowed classes
  expect_error(cat_for_status(as.factor("foobar")), "class")
  expect_error(dog_for_status(as.factor("foobar")), "class")
  # code not found
  expect_error(cat_for_status(33333))
  expect_error(dog_for_status(33333))
  # must be length 1
  expect_error(cat_for_status(1:3))
  expect_error(dog_for_status(1:3))
})

