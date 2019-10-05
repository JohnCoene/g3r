#' Initialise
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
g3r <- function(message, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    message = message
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
