#' Points
#' 
#' Add points to a map.
#' 
#' @inheritParams g3r_camera
#' @param data A data.frame holding coordinates to plot.
#' @param lat,lon Coordinates and elevation of point.
#' @param elevation Elevation of point in meters.
#' @param color Color of the point. 
#' 
#' @examples 
#' \dontrun{
#' df <- data.frame(
#'   lon =  7.9610, 
#'   lat = 46.5852,
#'   ele = 2100
#' )
#' 
#' g3r(46.5763, 7.9904, width = 900) %>% 
#'   g3r_points(df, lat, lon, ele) 
#' }
#' 
#' @export 
g3r_points <- function(g3r, data, lat, lon, elevation, color) UseMethod("g3r_points")

#' @export 
#' @method g3r_points g3r 
g3r_points.g3r <- function(g3r, data, lat, lon, elevation, color) {

  lat_enquo <- enquo(lat)
  lon_enquo <- enquo(lon)
  ele_enquo <- enquo(elevation)

  df <- select(data, lat = !!lat_enquo, lon = !!lon_enquo, ele = !!ele_enquo)

  df$color <- "red"
  if(!missing(color)) {
    color_enquo <- enquo(color)
    df$color <- pull(data, !!color_enquo)
  }

  points <- purrr::pmap(df, function(lat, lon, ele, color){
    list(
      coordinates = c(lon, lat),
      elevation = ele,
      color = color
    )
  }) 

  g3r$x$points <- append(g3r$x$points, points)

  return(g3r)
}