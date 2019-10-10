#' Dependency
#' 
#' Dependency for g3r aframe component.
#' 
#' @param include_main Whether to include the main three-geo 
#' dependency.
#' 
#' @details Include in your \link[aframer]{a_scene}.
#' 
#' @export
g3r_aframer_dependency <- function(include_main = TRUE){
  
  component <- c(file = system.file("aframe", package = "g3r"))
  dependency <- c(file = system.file("htmlwidgets/lib/three-geo", package = "g3r"))

  compo_dep <- list(
    htmltools::htmlDependency(
      name = "g3r-component",
      version = 109,
      src = component,
      script = "g3r-component.js"
    )
  )

  main_dep <- htmltools::htmlDependency(
    name = "g3r-aframe",
    version = 109,
    src = dependency,
    script = "three-geo.min.js"
  )

  if(!include_main)
    return(compo_dep)

  list(main_dep, compo_dep)
}

#' Aframer Map
#' 
#' Create Virtual Reality Map.
#' 
#' @inheritParams g3r
#' @param axes_on Whether to draw axes.
#' @param rotation Rotation of Map, default should work.
#' @param scale Scale of map.
#' @param position Position of map on scene.
#' @param ... Any other options passed to the aframe entity.
#' 
#' @export
a_map <- function(lat= 45.9, lon = 6.8, radius = 5, zoom = 12, 
  axes_on = FALSE, mapbox_token = Sys.getenv("MAPBOX_TOKEN"),
  rotation = aframer::xyz_aframe(-90, 180, 0),
  position = aframer::xyz_aframe(0, 0.7, -1.5),
  scale = aframer::xyz_aframe(2, 2, 2), ...){

  if(mapbox_token == "")
    stop("Invalid `mapbox_token`")
  
  map <- paste0(
    "token: ", mapbox_token, ";",
    "lat: ", lat, ";",
    "lng: ", lon, ";",
    "zoom: ", zoom, ";",
    "radius: ", radius, ";",
    "axes_on: ", tolower(axes_on), ";"
  )

  opts <- list(
    map = map,
    rotation = rotation,
    scale = scale,
    position = position,
    ...
  )
  htmltools::tag("a-entity", opts)
}