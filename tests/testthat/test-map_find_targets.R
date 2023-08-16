library(PsySys)

# context("Find most influential symptom(s) in the current map")

test_that("test that map_find_targets returns a list with the factors with the highest out-degree centrality.", {
  # Define the example current matrix
  current_matrix <- t(matrix(c(0,1,1,
                               0,0,0,
                               1,0,0), nrow = 3, ncol = 3))
  colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")

  # Create the qgraph object (redirect to png to not display the graph automatically)
  png(filename = "test.png")
  graph <- qgraph(current_matrix)
  dev.off()

  # Define expected output
  expected_result <- "The most influential factor in your mental-health map is: Stress"

  # Run the function
  influential_factor <- map_find_targets(current_matrix, graph)

  # Compare actual output to expected output
  expect_equal(influential_factor, expected_result)
})

