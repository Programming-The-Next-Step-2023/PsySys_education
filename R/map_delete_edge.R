#' @title Delete an edge in the mental-health map
#' @description Deletes the input edge from the existing map.
#' @param current_matrix An unweighted directed matrix.
#' @param delete_edge A vector consisting of two elements, the edge from the first to the second element will be deleted.
#' @return An updated unweighted directed matrix excluding the selected edge.
#' @examples
#' current_matrix <- t(matrix(c(0,0,1,0,0,0,0,0,0), nrow = 3, ncol = 3))
#' colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")
#' delete_edge <- c("Stress", "Breakup")
#' map_delete_edge(current_matrix, delete_edge)
#' @export

map_delete_edge <- function(current_matrix, delete_edge){
  # Find the index of the first element (cause)
  cause_factor <- which(colnames(current_matrix) == delete_edge[1])
  # Find the index of the second element (effect)
  effect_factor <- which(colnames(current_matrix) == delete_edge[2])
  # Set the edge to 0 (delete)
  current_matrix[cause_factor, effect_factor] <- 0

  return(current_matrix)
}

