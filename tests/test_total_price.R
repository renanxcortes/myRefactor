library(testthat)
# You can run these test simply running testthat::test_local() in the root directory.

# Original Data
order <- tibble::tribble(
  ~product, ~price_EUR, ~price_USD,
  "smartwatch", 217, 249,
  "laptop", 517, 591,
  "monitor", 279, 319,
  "headphones", 173, 198,
  "printer", 110, 125)

# Original Data with some NA's
order_with_na <- tibble::tribble(
  ~product, ~price_EUR, ~price_USD,
  "smartwatch", NA, NA,
  "laptop", 517, 591,
  "monitor", 279, 319,
  "headphones", 173, 198,
  "printer", 110, 125)

# Original Data with some column Badly Written columns
order_with_misnamed_column <- tibble::tribble(
  ~product, ~price_EUR2, ~price_USD2,
  "smartwatch", 217, 249,
  "laptop", 517, 591,
  "monitor", 279, 319,
  "headphones", 173, 198,
  "printer", 110, 125)

# Original Data with some non-numeric input
order_non_numeric <- tibble::tribble(
  ~product, ~price_EUR, ~price_USD,
  "smartwatch", '217', '249',
  "laptop", '517', '591',
  "monitor", '279', '319',
  "headphones", '173', '198',
  "printer", '110', '125')

test_that("Test Values - Result Length", {
  expect_length(total_price(.data = order, .currency = 'USD'), 1)
})

test_that("Test Values - Values OK", {
  expect_equal(total_price(.data = order, .currency = 'USD'), 1111.5)
  expect_equal(total_price(.data = order, .currency = 'EUR'), 1036.8)
})

test_that("Test Values - Presence of NA's", {
  expect_equal(total_price(.data = order_with_na, .currency = 'USD'), 924.75)
  expect_equal(total_price(.data = order_with_na, .currency = 'EUR'), 863.2)
})

test_that("Test - Misnamed Columns", {
  expect_error(total_price(.data = order_with_misnamed_column, .currency = 'USD'))
  expect_error(total_price(.data = order_with_misnamed_column, .currency = 'EUR'))
})

test_that("Test - Non-numeric Columns", {
  expect_error(total_price(.data = order_non_numeric, .currency = 'USD'))
  expect_error(total_price(.data = order_non_numeric, .currency = 'EUR'))
})

test_that("Test - Different Currency Input", {
  expect_error(total_price(.data = order, .currency = 'ZLO'))
})
