#' Demo Application
#' 
#' Demo Application that displays the 3D map of your surroundings.
#' 
#' @details Requires the \href{https://github.com/ColinFay/geoloc}{geoloc}
#' package installed.
#' 
#' @examples \dontrun{g3r_demo}
#' 
#' @export
g3r_demo <- function() {
  shiny::shinyAppFile(
    system.file(
      paste0("app/app.R"), 
      package = 'g3r', 
      mustWork = TRUE
    )
  )
}