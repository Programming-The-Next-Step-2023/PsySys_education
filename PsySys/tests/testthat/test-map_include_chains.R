library("PsySys")

context("Include the selected causal chains into the map skeleton")

test_that("test that map_include_chains returns a qgraph with all selected causal chains", {
  input_items <- c("Loss of interest", "Bored", "Self-blame", "Overthinking", "Changes in appetite", "Stress")
  input_chain01 <- c("Loss of interest", "Bored", "Self-blame")
  input_chain02 <- c("Overthinking", "Changes in appetite", "Stress")
  expected_matrix <- t(matrix(c(0,1,0,0,0,0,
                                0,0,1,0,0,0,
                                0,0,0,0,0,0,
                                0,0,0,0,1,0,
                                0,0,0,0,0,1,
                                0,0,0,0,0,0),nrow = 6,ncol = 6))
  rownames(expected_matrix) <- c("Loss of interest", "Bored", "Self-blame", "Overthinking", "Changes in appetite", "Stress")
  colnames(expected_matrix) <- c("Loss of interest", "Bored", "Self-blame", "Overthinking", "Changes in appetite", "Stress")

  map_chains <- map_include_chains(input_items = input_items,
                                   input_chain01 = input_chain01,
                                   input_chain02 = input_chain02)


  expect_equal(map_chains, expected_matrix)
})
