library("PsySys")

context("Include the selected vicious cycles into the map")

test_that("test that map_include_cycles returns a qgraph with all selected vicious cycles", {
  input_items <- c("Loss of interest", "Bored", "Self-blame", "Overthinking", "Changes in appetite", "Stress")
  input_chain01 <- c("Loss of interest", "Bored", "Self-blame")
  input_chain02 <- c("Overthinking", "Changes in appetite", "Stress")
  input_cycle01 <- c("Self-blame", "Overthinking")
  input_cycle02 <- c("Loss of interest", "Overthinking", "Bored")

  expected_matrix <- t(matrix(c(0,1,0,1,0,0,
                                1,0,1,0,0,0,
                                0,0,0,1,0,0,
                                0,1,1,0,1,0,
                                0,0,0,0,0,1,
                                0,0,0,0,0,0),nrow = 6,ncol = 6))
  rownames(expected_matrix) <- c("Loss of interest", "Bored", "Self-blame", "Overthinking", "Changes in appetite", "Stress")
  colnames(expected_matrix) <- c("Loss of interest", "Bored", "Self-blame", "Overthinking", "Changes in appetite", "Stress")

  map_cycles <- map_include_cycles(input_items = input_items,
                                   input_chain01 = input_chain01,
                                   input_chain02 = input_chain02,
                                   input_cycle01 = input_cycle01,
                                   input_cycle02 = input_cycle02)

  expect_equal(map_cycles, expected_matrix)
})
