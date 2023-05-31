#' Includes input of the chain and vicious cycle exercise into mental-health map
#' @param input_items A vector containing all selected factors.
#' @param input_chain01 A vector containing all drop down text field inputs of chain 1 of the  exercise on PsySys section 2.
#' @param input_chain02 A vector containing all drop down text field inputs of chain 1 of the  exercise on PsySys section 2.
#' @param input_cycle01 A vector containing the user input for the first vicious cycle of the exercise on PsySys section 3.
#' @param input_cycle02 A vector containing the user input for the second vicious cycle of the exercise on PsySys section 3.
#' @return A qgraph containing all selected factors, the causal chains, and the vicious cycles the user selected.
#' @examples
#' map_include_chains(input_items = input$factors,
#'                    input_chain = c(input$chain01_01, input$chain01_02, input$chain01_03,
#'                                  input$chain02_01, input$chain02_02, input$chain02_03),
#'                    input_cycle01 = c(input$cycle1[1], input$cycle1[2]),
#'                    input_cycle02 = c(input$cycle2[1], input$cycle2[2], input$cycle2[3]))
#' @export

# map_include_cycles
map_include_cycles <- function(input_items, input_chain01, input_chain02, input_cycle01, input_cycle02){
  adjacency_matrix <- map_include_chains(input_items, input_chain01, input_chain02)
  # create cycle 1 (input 1 > input 2 > input 1) - find location of elements in matrix
  cycle01_01 <- which(input_items == input_cycle01[1])
  cycle01_02 <- which(input_items == input_cycle01[2])
  # include corresponding edges in matrix
  adjacency_matrix[cycle01_01, cycle01_02] <- 1
  adjacency_matrix[cycle01_02, cycle01_01] <- 1
  # create cycle 2 (input 3 > input 4 > input 5 > input 3) - find location of elements in matrix
  cycle02_01 <- which(input_items == input_cycle02[1])
  cycle02_02 <- which(input_items == input_cycle02[2])
  cycle02_03 <- which(input_items == input_cycle02[3])
  # include corresponding edges in matrix
  adjacency_matrix[cycle02_01, cycle02_02] <- 1
  adjacency_matrix[cycle02_02, cycle02_03] <- 1
  adjacency_matrix[cycle02_03, cycle02_01] <- 1

  return(adjacency_matrix)
}
