library("PsySys")

# context("Create map skeleton containing selected items")

test_that("test that map_create_skeleton returns a matrix with the correct items and correct dimensions", {
  # Define example user input
  input_items = c("Loss of interest", "Bored", "Self-blame")

  # Run function
  map_skeleton <- map_create_skeleton(input_items)

  # Test if the column names of the generated matrix are the same as the input factors
  expect_equal(colnames(map_skeleton), input_items)
  # Test if the row names of the generated matrix are the same as the input factors
  expect_equal(rownames(map_skeleton), input_items)
  # Test if the generated matrix has the right dimensions
  expect_equal(dim(map_skeleton), c(length(input_items), length(input_items)))
})
