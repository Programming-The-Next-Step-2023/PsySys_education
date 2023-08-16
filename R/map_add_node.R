#' @title Add a node to the mental-health map
#' @description Adds a node the user has selected to the existing map.
#' @param current_matrix An unweighted directed matrix.
#' @param new_factor String input of the new factor the user wants to add.
#' @return An updated unweighted directed matrix including the new factor.
#' @examples
#' current_matrix <- matrix(0, nrow = 3, ncol = 3)
#' colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")
#' new_factor <- "Tired"
#' map_add_node(current_matrix, new_factor)
#' @export

map_add_node <- function(current_matrix, new_factor){
  # Add new row with 0s - corresponding to outgoing connections of the new factor
  new_row <- rep(0, length(colnames(current_matrix)))
  new_matrix <- rbind(current_matrix, new_row)

  # Add new column with 0s - corresponding to incoming connections of the new factor
  new_column <- rep(0, length(colnames(current_matrix)) + 1)
  new_matrix <- cbind(new_matrix, new_column)

  # Add new factor to the row and column names
  colnames(new_matrix) <- c(colnames(current_matrix), new_factor)
  rownames(new_matrix) <- c(rownames(current_matrix), new_factor)

  return(new_matrix)
}

