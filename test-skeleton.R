library("skeleton")

context("Core skeleton functionality")


test_that("create_skeleton returns qgraph of correct dimensions", {
  graph <- create_skeleton(number_items = 3, names_items = c("Loss of interest", "Bored", "Self-blame"))

  expect_equal(dim(graph), c(3,3))
})
