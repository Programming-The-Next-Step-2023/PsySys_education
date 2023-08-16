#' @title Start PsySys
#' @description Runs the PsySys application and opens the user interface.
#' @export

startPsySys <- function() {
  shinyApp(ui = ui, server = server, appName = "psysys")
}
