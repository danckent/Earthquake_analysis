#### Tests ####

source(file = "Artificial_assessment.R")

library( testthat)

# Call the function with custom date
get_earthquakes( date = "2023-02-04")

# Call the function with default date (Sys.time())
get_earthquakes()

context("Earthquakes")

test_that("get_earthquakes", code = {
  result <- get_earthquakes(date = "2023-02-04")
  
  # Check the result returns a magnitude of more than 4.5
  expect_true(all(result$mag > 4.5))
  
})

test_that("get_earthquakes", code = {
  result <- get_earthquakes(date = "2023-02-04")
  
  # Check the result does not return Afghanistan
  expect_true(all(!grepl("Afghanistan", result$place)))
  
})
