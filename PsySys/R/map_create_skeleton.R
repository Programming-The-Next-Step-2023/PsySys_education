#' @title Create the initial mental-health map
#' @description Creates a mental-health map skeleton consisting of the selected factors.
#' @param input_items A vector containing all selected factors.
#' @return A 0 matrix with the number of dimensions corresponding to the number of selected factors.
#' @examples
#' input_items <- c("Loss of interest", "Bored", "Self-blame")
#' map_create_skeleton(input_items)
#' @export

map_create_skeleton <- function(input_items){
  # Extract how many items were selected
  number_items <- length(input_items)
  # Create matrix of 0s with as many rows & columns as selected items
  adjacency_matrix <- matrix(0, nrow = number_items, ncol = number_items)
  # Set the column and row names of the matrix to the selected items
  colnames(adjacency_matrix) <- rownames(adjacency_matrix) <- input_items

  return(adjacency_matrix)
}
