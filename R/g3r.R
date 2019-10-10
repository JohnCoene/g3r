#' Create a 3D Map
#'
#' Create a 3D Map.
#' 
#' @param lat,lon Center coordinates of map.
#' @param radius The radius of the circle that fits the terrain.
#' @param zoom Satellite zoom resolution of the tiles in the terrain. 
#' Select from {11, 12, 13, 14, 15, 16, 17}, where 17 is the highest 
#' value supported. For a fixed radius, higher zoom resolution results 
#' in more tileset API calls.
#' @param mapbox_token \href{https://www.mapbox.com/}{Mapbox} API token.
#' @param elementId Id of div containing map.
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#'
#' @import htmlwidgets
#'
#' @export
g3r <- function(lat= 45.9, lon = 6.8, radius = 5, zoom = 12, 
  mapbox_token = Sys.getenv("MAPBOX_TOKEN"), width = "100%", 
  height = NULL, elementId = NULL) {

  if(mapbox_token == "")
    stop("Invalid `mapbox_token`")

  # forward options using x
  x = list(
    threegeo = list(
      tokenMapbox = mapbox_token
    ),
    lat = lat, 
    lon = lon,
    radius = radius,
    zoom = zoom
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'g3r',
    x,
    width = width,
    height = height,
    package = 'g3r',
    elementId = elementId
  )
}

g3r_html <- function(id, style, class, ...){
  canvas_id <- paste0(paste0(id, "-canvas"))
  shiny::div(
    id = id, class = class, ...,
    shiny::tags$canvas(id = canvas_id, ...)
  )
}

#' Shiny bindings for g3r
#'
#' Output and render functions for using g3r within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a g3r
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name g3r-shiny
#'
#' @export
g3rOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'g3r', width, height, package = 'g3r')
}

#' @rdname g3r-shiny
#' @export
renderG3r <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, g3rOutput, env, quoted = TRUE)
}
