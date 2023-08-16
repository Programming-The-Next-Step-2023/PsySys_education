#' @title PsySys
#' @description This package comprises the PsySys app which is implemented as a psychoeducational
#' lesson based on the network approach to psychopathology in which the user iteratively
#' builds their own mental-health map. The package PsySys has ten functions. One to start the app
#' and the rest to update the mental-health map graph of the user based on the different exercises.
#'
#' @section Start the app:
#' \emph{startPsySys} starts the app which is then displayed to the user.
#'
#' @section Create the maps' skeleton:
#' \emph{map_create_skeleton} creates the initial unconnected map consisting out of all
#' the factors the user has selected in the exercise of PsySys section 1.
#'
#' @section Include causal chains into the map:
#' \emph{map_include_chains} includes the causal chains the user has selected in the
#' exercise of PsySys section 2 into the map.
#'
#' @section Include vicious cycles into the map:
#' \emph{map_include_cycles} includes the vicious cycles the user has selected in the
#' exercise of PsySys section 3 into the map.
#'
#' @section Add a selected factor (node) to the map:
#' \emph{map_add_node} adds a selected factor to the map.
#'
#' @section Delete a selected factor (node) from the map:
#' \emph{map_delete_node} deleted a selected factor from the map.
#'
#' @section Add a selected connection (edge) to the map:
#' \emph{map_add_edge} adds a selected edge to the map.
#'
#' @section Delete a selected connection (edge) from the map:
#' \emph{map_delete_edge} adds a selected edge to the map.
#'
#' @section Highlight the user's selected target factor in the map:
#' \emph{map_highlight_target} located the selected target factor in the map and highlights it in a different color.
#'
#' @section Find the most influential factors in the map:
#' \emph{map_find_targets} calculates the out-degree centrality and finds the factors with the highest out-degree centrality.
#'
#' @docType package
#' @name PsySys
NULL
