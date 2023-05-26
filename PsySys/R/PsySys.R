#' This package comprises the PsySys app which is implemented as a psychoeducational
#' lesson based on the network approach to psychopathology in which the user iteratively
#' builds their own mental-health map:
#'
#' The package PsySys has three functions, each of which is responsible for updating
#' the mental-health map graph of the user based on the different exercises.
#'
#' @section Create the maps' skeleton:
#' \emph{map_create_skeleton} creates the initial unconnected consisting out of all
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
#' @docType package
#' @name PsySys
NULL