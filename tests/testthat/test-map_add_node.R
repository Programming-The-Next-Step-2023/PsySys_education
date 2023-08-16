library("PsySys")

# context("Include the additional factor into the current map.")

test_that("test that map_add_node returns an updated unweighted directed matrix that includes the new input factor.", {
  # Define the example current matrix
  current_matrix <- matrix(0, nrow = 3, ncol = 3)
  colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")

  # Define the example user input
  new_factor <- "New factor"

  # Define the expected output
  expected_matrix <- matrix(0 ,nrow = 4,ncol = 4)
  colnames(expected_matrix) <- rownames(expected_matrix) <- c("Stress", "Worrying", "Breakup", "New factor")

  # Run the function
  updated_matrix <- map_add_node(current_matrix, new_factor)

  # Compare actual output to expected output
  expect_equal(updated_matrix, expected_matrix)
})
