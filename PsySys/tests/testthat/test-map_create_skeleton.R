library("PsySys")

context("Create map skeleton containing selected items")

test_that("test that map_create_skeleton returns a qgraph with correct items and correct dimensions", {
  input_items = c("Loss of interest", "Bored", "Self-blame")
  map_skeleton <- map_create_skeleton(input_items = input_items)

  expect_equal(colnames(map_skeleton), input_items)
  expect_equal(rownames(map_skeleton), input_items)
  expect_equal(dim(map_skeleton), c(length(input_items), length(input_items)))
})
