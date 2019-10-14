#' Points
#' 
#' Add points to a map.
#' 
#' @inheritParams g3r_camera
#' @param data A data.frame holding coordinates to plot.
#' @param lat,lon Coordinates and elevation of point.
#' @param elevation Elevation of point in meters.
#' @param color Color of the point. 
#' @param size The size of the point.
#' 
#' @examples 
#' \dontrun{ 
#' g3r(46.5763, 7.9904) %>% 
#'   g3r_points(everest, lat, lon, ele) 
#' }
#' 
#' @export 
g3r_points <- function(g3r, data, lat, lon, elevation, size, color) UseMethod("g3r_points")

#' @export 
#' @method g3r_points g3r 
g3r_points.g3r <- function(g3r, data, lat, lon, elevation, size, color) {

  lat_enquo <- enquo(lat)
  lon_enquo <- enquo(lon)
  ele_enquo <- enquo(elevation)

  df <- select(data, lat = !!lat_enquo, lon = !!lon_enquo, ele = !!ele_enquo)

  df$color <- "red"
  if(!missing(color)) {
    color_enquo <- enquo(color)
    df$color <- pull(data, !!color_enquo)
  }

  df$size <- 6
  if(!missing(size)) {
    size_enquo <- enquo(size)
    df$size <- pull(data, !!size_enquo)
  }

  points <- purrr::pmap(df, function(lat, lon, ele, color, size){
    list(
      coordinates = c(lon, lat),
      elevation = ele,
      color = color,
      size = size
    )
  }) 

  g3r$x$points <- append(g3r$x$points, points)

  return(g3r)
}

#' Paths
#' 
#' Add paths to a map.
#' 
#' @inheritParams g3r_camera
#' @inheritParams g3r_points
#' @param width The width of the line.
#' 
#' @examples 
#' \dontrun{ 
#' g3r(27.985655, 86.903697) %>% 
#'   g3r_paths(nuptse, lat, lon, ele) 
#' }
#' 
#' @export 
g3r_paths <- function(g3r, data, lat, lon, elevation, width = 2L, color = "blue") UseMethod("g3r_paths")

#' @export 
#' @method g3r_paths g3r 
g3r_paths.g3r <- function(g3r, data, lat, lon, elevation, width = 2L, color = "blue") {

  lat_enquo <- enquo(lat)
  lon_enquo <- enquo(lon)
  ele_enquo <- enquo(elevation)

  df <- select(data, lat = !!lat_enquo, lon = !!lon_enquo, ele = !!ele_enquo)

  points <- purrr::pmap(df, function(lat, lon, ele){
    list(
      coordinates = c(lon, lat),
      elevation = ele
    )
  }) 

  points <- list(
    coords = points,
    color = color,
    width = width
  )

  g3r$x$paths <- append(g3r$x$paths, list(points))

  return(g3r)
}