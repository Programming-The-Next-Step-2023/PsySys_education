library("PsySys")

# context("Include the selected vicious cycles into the map")

test_that("test that map_include_cycles returns an adjacency matrix with all selected vicious cycles", {
  # Define the example current matrix
  current_matrix <- matrix(0, nrow = 3, ncol = 3)
  colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")
  # Define the example user input
  input_cycle01 <- c("Stress", "Worrying")
  input_cycle02 <- c("Worrying", "Breakup", "Stress")

  # Define the expected output
  expected_matrix <- t(matrix(c(0,1,0,
                                1,0,1,
                                1,0,0),nrow = 3,ncol = 3))
  rownames(expected_matrix) <- colnames(expected_matrix) <-  c("Stress", "Worrying", "Breakup")

  # Run the function
  map_cycles <- map_include_cycles(current_matrix, input_cycle01, input_cycle02)

  # Compare actual output to expected output
  expect_equal(map_cycles, expected_matrix)
})
