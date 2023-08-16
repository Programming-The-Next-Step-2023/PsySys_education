library("PsySys")

# context("Highlight the selected treatment target")

test_that("test that map_highlight_target returns a list of colors where the selected factor is highlighted in a differrent color", {
  # Define the example current matrix
  current_matrix <- matrix(0, nrow = 3, ncol = 3)
  colnames(current_matrix) <- rownames(current_matrix) <- c("Loss of interest", "Bored", "Self-blame")

  # Define the example user input
  target <- "Loss of interest"

  # Define the expected output
  expected_node_list <- c("#619bba", "#c5d5de", "#c5d5de")

  # Run the function
  node_list <- map_highlight_target(current_matrix, target)

  # Compare actual output to expected output
  expect_equal(node_list, expected_node_list)
})
