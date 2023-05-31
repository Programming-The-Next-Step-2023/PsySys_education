#' Creates a mental-health map skeleton
#' @param input_items A vector containing all selected factors.
#' @return A qgraph containing all selected factors and no edges between them.
#' @examples
#' map_create_skeleton(c("Loss of interest", "Bored", "Self-blame"))
#' @export

# create_skeleton: creates a qgraph with all the chosen items (no edges)
map_create_skeleton <- function(input_items){
  # extract how many items were selected
  number_items <- length(input_items)
  # create matrix of 0s with as many rows & columns as selected items
  adjacency_matrix <- matrix(0, nrow = number_items, ncol = number_items)
  # set the column and row names of the matrix to the selected items
  colnames(adjacency_matrix) <- rownames(adjacency_matrix) <- input_items
  # create qgraph object (visualization)
  return(adjacency_matrix)
}
