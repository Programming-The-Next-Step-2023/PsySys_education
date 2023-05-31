#' Includes input of chain exercise into mental-health map
#' @param input_items A vector containing all selected factors.
#' @param input_chain01 A vector containing all drop down text field inputs of chain 1 of the  exercise on PsySys section 2.
#' @param input_chain02 A vector containing all drop down text field inputs of chain 1 of the  exercise on PsySys section 2.
#' @return A qgraph containing all selected factors and the causal chains the user selected.
#' @examples
#' map_include_chains(input$factors,
#'                    c(input$chain01_01, input$chain01_02, input$chain01_03,
#'                    input$chain02_01, input$chain02_02, input$chain02_03))
#' @export

# map_include_chains: takes an adjacency matrix, the input items & input chains and updates the skeleton
map_include_chains <- function(input_items, input_chain01, input_chain02){
  adjacency_matrix <- map_create_skeleton(input_items)
  # create chains
  for(i in 1:(length(input_chain01) - 1)){
    index_01 <- which(input_items == input_chain01[i])
    index_02 <- which(input_items == input_chain01[i+1])
    adjacency_matrix[index_01,index_02] <- 1
  }
  for(j in 1:(length(input_chain02) - 1)){
    index_01 <- which(input_items == input_chain02[j])
    index_02 <- which(input_items == input_chain02[j+1])
    adjacency_matrix[index_01,index_02] <- 1
  }
  return(adjacency_matrix)
}
