#' @title Find the most influential factors
#' @description Finds the targets with the highest out-degree centrality (most influential).
#' @param current_matrix An unweighted directed matrix.
#' @param qgraph A qgraph object of current_matrix.
#' @return A string output presenting the most influential factors in the map.
#' @examples
#' current_matrix <- matrix(0, nrow = 3, ncol = 3)
#' colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")
#' qgraph <- qgraph(current_matrix)
#' map_find_targets(current_matrix, qgraph)
#' @export

map_find_targets <- function(current_matrix, qgraph){
  # Compute centrality measures of qgraph object
  centrality <- centrality(qgraph)

  # Get index of targets with highest out-degree centrality
  max_value <- max(centrality$OutDegree)
  max_indices <- which(centrality$OutDegree == max_value)

  # Depending if there's only one or multiple factors change the function output
  if(length(max_indices) == 1){
    factor <- colnames(current_matrix)[max_indices]
    return(paste("The most influential factor in your mental-health map is:", factor))
  }else {
    influential_factors <- sapply(max_indices, function(i) colnames(current_matrix)[i])
    return(paste("The most influential factors in your mental-health map are:", paste(influential_factors, collapse = ", ")))
  }
}
