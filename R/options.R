#' Adjust Camera Position
#' 
#' Adjust the position of the camera.
#' 
#' @param g3r An object of class \code{g3r} as returned by \code{g3r}.
#' @param lat,lon,elevation Position of camera.
#' 
#' @export
#' 
#' @export 
g3r_camera <- function(g3r, lat = 0, lon = 0, elevation = 1.5) {
  g3r$x$camera <- list(lat = lat, lon = lon, elevation = elevation)
  return(g3r)
}