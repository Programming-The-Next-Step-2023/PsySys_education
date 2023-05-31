library(PsySys)

# context("Exclude the input edge from the current map.")

test_that("test that map_delete_edge returns an updated unweighted directed matrix that excludes the input edge.", {
  # Define the example current matrix
  current_matrix <- t(matrix(c(0,0,1,
                                0,0,0,
                                0,0,0), nrow = 3,ncol = 3))
  colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")

  # Define the example user input
  delete_edge <- c("Stress", "Breakup")

  # Define the expected output
  expected_matrix <- matrix(0, nrow = 3, ncol = 3)
  colnames(expected_matrix) <- rownames(expected_matrix) <- c("Stress", "Worrying", "Breakup")

  # Run the function
  updated_matrix <- map_delete_edge(current_matrix, delete_edge)

  # Compare actual output to expected output
  expect_equal(updated_matrix, expected_matrix)
})
