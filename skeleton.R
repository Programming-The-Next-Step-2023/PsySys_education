#' Create a qgraph skeleton containing all chosen nodes
#' @param number_items Numeric value. Denotes the number of chosen items that are to be included in the graph.
#' @param names_items Vector of strings. Gives the names of the chosen items that are to be included in the graph.
#' @return A qgraph containing all selected items and no edges between them.
#' @examples
#' create_skeleton(3, c("Loss of interest", "Bored", "Self-blame"))

#' @export
# create_skeleton: creates a qgraph with all the chosen items (no edges)
create_skeleton <- function(number_items, names_items){
  adjacency_matrix <- data.frame(matrix(0, nrow = number_items, ncol = number_items))
  colnames(adjacency_matrix) <- rownames(adjacency_matrix) <- names_items
  qgraph::qgraph(adjacency_matrix, names_items)
}
