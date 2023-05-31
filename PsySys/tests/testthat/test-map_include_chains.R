library("PsySys")

# context("Include the selected causal chains into the map")

test_that("test that map_include_chains returns an adjacency matrix with all selected causal chains", {
  # Define the example current matrix
  current_matrix <- matrix(0, nrow = 6, ncol = 6)
  colnames(current_matrix) <- rownames(current_matrix) <- c("Loss of interest", "Bored", "Self-blame",
                                                            "Overthinking", "Changes in appetite", "Stress")
  # Define the example user input
  input_chain01 <- c("Loss of interest", "Bored", "Self-blame")
  input_chain02 <- c("Overthinking", "Changes in appetite", "Stress")

  # Define the expected output
  expected_matrix <- t(matrix(c(0,1,0,0,0,0,
                                0,0,1,0,0,0,
                                0,0,0,0,0,0,
                                0,0,0,0,1,0,
                                0,0,0,0,0,1,
                                0,0,0,0,0,0),nrow = 6,ncol = 6))
  rownames(expected_matrix) <- colnames(expected_matrix) <- c("Loss of interest", "Bored", "Self-blame",
                                                              "Overthinking", "Changes in appetite", "Stress")

  # Run the function
  map_chains <- map_include_chains(current_matrix, input_chain01, input_chain02)

  # Compare actual output to expected output
  expect_equal(map_chains, expected_matrix)
})
