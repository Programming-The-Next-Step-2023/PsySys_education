library("PsySys")

# context("Exclude the input factor from the current map.")

test_that("test that map_delete_node returns an updated unweighted directed matrix that excludes the input factor.", {
  # Define the example current matrix
  current_matrix <- matrix(0, nrow = 3, ncol = 3)
  colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")

  # Define the example user input
  delete_factor <- "Stress"

  # Define the expected output
  expected_matrix <- matrix(0 ,nrow = 2,ncol = 2)
  colnames(expected_matrix) <- rownames(expected_matrix) <- c("Worrying", "Breakup")

  # Run the function
  updated_matrix <- map_delete_node(current_matrix, delete_factor)

  # Compare actual output to expected output
  expect_equal(updated_matrix, expected_matrix)
})

