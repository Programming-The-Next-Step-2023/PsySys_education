#' @title Highlight target factor in the mental-health map
#' @description Highlights the factor the user has selected as a promising treatment target.
#' @param current_matrix An unweighted directed matrix.
#' @param target A string denoting the target factor.
#' @return A list node_colors of strings corresponding to the colors of each node in the map.
#' @examples
#' current_matrix <- matrix(0, nrow = 3, ncol = 3)
#' colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")
#' target <- "Stress"
#' map_highlight_target(current_matrix, target)
#' @export

map_highlight_target <- function(current_matrix, target){
  # Find target index in the map
  target_index <- which(colnames(current_matrix) == target)
  # Create color vector with the same color for each node
  node_colors <- rep("#c5d5de", length(colnames(current_matrix)))
  # Give the target node another color
  node_colors[target_index] <- "#619bba"

  return(node_colors)
}
