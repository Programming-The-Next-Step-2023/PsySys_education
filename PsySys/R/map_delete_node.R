#' @title Delete a node in the mental-health map
#' @description Delete a node the user has selected from their existing map.
#' @param current_matrix An unweighted directed matrix.
#' @param delete_factor String input of the factor the user wants to delete.
#' @return An updated unweighted directed matrix excluding the selected factor.
#' @examples
#' current_matrix <- matrix(0, nrow = 3, ncol = 3)
#' colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")
#' delete_factor <- "Stress"
#' map_delete_node(current_matrix, delete_factor)
#' @export

map_delete_node <- function(current_matrix, delete_factor){
  # Find index of factor in current matrix
  delete_index <- which(colnames(current_matrix) == delete_factor)
  # Delete corresponding row and column
  updated_matrix <- current_matrix[-delete_index, -delete_index]

  return(updated_matrix)
}
