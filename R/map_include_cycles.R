#' @title Include cycles into mental-health map
#' @description Includes input of the vicious cycle exercise (PsySys section 3) into the mental-health map.
#' @param current_matrix An unweighted directed matrix.
#' @param input_cycle01 A vector containing the user input for the first vicious cycle.
#' @param input_cycle02 A vector containing the user input for the second vicious cycle.
#' @return An updated unweighted directed matrix including the vicious cycles the user selected.
#' @examples
#' current_matrix <- matrix(0, nrow = 3, ncol = 3)
#' colnames(current_matrix) <- rownames(current_matrix) <- c("Stress", "Worrying", "Breakup")
#' input_cycle01 <- c("Stress", "Worrying")
#' input_cycle02 <- c("Worrying", "Breakup", "Stress")
#' map_include_chains(current_matrix, input_cycle01, input_cycle02)
#' @export

map_include_cycles <- function(current_matrix, input_cycle01, input_cycle02){
  # create cycle 1 (input 1 > input 2 > input 1) - find location of elements in matrix
  cycle01_01 <- which(colnames(current_matrix) == input_cycle01[1])
  cycle01_02 <- which(colnames(current_matrix) == input_cycle01[2])
  # include corresponding edges in matrix
  current_matrix[cycle01_01, cycle01_02] <- 1
  current_matrix[cycle01_02, cycle01_01] <- 1
  # create cycle 2 (input 1 > input 2 > input 3 > input 1) - find location of elements in matrix
  cycle02_01 <- which(colnames(current_matrix) == input_cycle02[1])
  cycle02_02 <- which(colnames(current_matrix) == input_cycle02[2])
  cycle02_03 <- which(colnames(current_matrix) == input_cycle02[3])
  # include corresponding edges in matrix
  current_matrix[cycle02_01, cycle02_02] <- 1
  current_matrix[cycle02_02, cycle02_03] <- 1
  current_matrix[cycle02_03, cycle02_01] <- 1

  return(current_matrix)
}
