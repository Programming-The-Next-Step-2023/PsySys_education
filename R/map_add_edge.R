#' @title Add an edge to the mental-health map
#' @description Adds a new edge the user has selected to the existing map.
#' @param current_matrix An unweighted directed matrix.
#' @param new_edge A vector consisting of two elements, the edge will be included from the first to the second element.
#' @return An updated unweighted directed matrix including the new edge.
#' @examples
#' current_matrix <- matrix(0, nrow = 3, ncol = 3)
#' colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")
#' new_edge <- c("Stress", "Breakup")
#' map_add_edge(current_matrix, new_edge)
#' @export

map_add_edge <- function(current_matrix, new_edge){
  # Find the index of the first element (cause)
  cause_factor <- which(colnames(current_matrix) == new_edge[1])
  # Find the index of the second element (effect)
  effect_factor <- which(colnames(current_matrix) == new_edge[2])
  # Set the edge to 1 (include)
  current_matrix[cause_factor, effect_factor] <- 1

  return(current_matrix)
}


