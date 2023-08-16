#' @title Include causal chains into mental-health map
#' @description Includes input of chain exercise (PsySys section 2) into mental-health map.
#' @param current_matrix An unweighted directed matrix.
#' @param input_chain01 A vector containing all drop down text field inputs of chain 1.
#' @param input_chain02 A vector containing all drop down text field inputs of chain 2.
#' @return An updated unweighted directed matrix including the two causal chains.
#' @examples
#' current_matrix <- matrix(0, nrow = 3, ncol = 3)
#' colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")
#' input_chain01 <- c("Stress", "Worrying", "Breakup")
#' input_chain02 <- c("Worrying", "Stress", "Breakup")
#' map_include_chains(current_matrix, input_chain01, input_chain02)
#' @export

map_include_chains <- function(current_matrix, input_chain01, input_chain02){
  # Get indexes of chain 1 elements and include an edge between element 1 and 2 and element 2 and 3
  for(i in 1:(length(input_chain01) - 1)){
    chain01_01 <- which(colnames(current_matrix) == input_chain01[i])
    chain01_02 <- which(colnames(current_matrix) == input_chain01[i+1])
    current_matrix[chain01_01,chain01_02] <- 1
  }
  # Get indexes of chain 2 elements and include an edge between element 1 and 2 and element 2 and 3
  for(j in 1:(length(input_chain02) - 1)){
    chain02_01 <- which(colnames(current_matrix) == input_chain02[j])
    chain02_02 <- which(colnames(current_matrix) == input_chain02[j+1])
    current_matrix[chain02_01,chain02_02] <- 1
  }

  return(current_matrix)
}
