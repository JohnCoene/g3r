
# g3r

<!-- badges: start -->
<!-- badges: end -->

3D, Virtual and Augmented Reality Maps.

## Installation

You can install the released version of g3r from [CRAN](https://CRAN.R-project.org) with:

``` r
# install.packages("remotes")
remotes::install_github("JohnCoene/g3r")
```

## Example

Note that all functions require a [mapbox](https://www.mapbox.com/) token, by default the function look for the `MAPBOX_TOKEN` environment variable.

You can use it as an htmlwidget.

```r
library(g3r)

g3r()
```

There is also the [aframer](https://aframer.john-coene.com/) component. Note that we run that as a shiny app as the dependency files require to be served.

``` r
library(g3r)
library(shiny)
library(aframer)

ui <- fluidPage(
  embed_aframe(
    height = "100vh",
    a_scene(
      a_dependency(),
      g3r_aframer_dependency(),
      a_map()
    )
  )
)

server <- function(input, output){}

shinyApp(ui, server)
```

As Augmented Reality with [arframer](https://arframer.john-coene.com/).

```r
library(g3r)
library(aframer)
library(arframer)

browse_aframe(
  a_scene(
    a_dependency(),
    arframer_dependency(),
    g3r_aframer_dependency(),
    arjs = "sourceType: webcam; detectionMode: mono_and_matrix; matrixCodeType: 3x3; debugUIEnabled: false;",
    a_primitive(
      "marker",
      list(
        a_map(),
        type = "barcode",
        value = 1
      )
    ),
    a_entity(camera = NA)
  )
)
```

This will match [artoolkit5 barcode 1](https://github.com/artoolkit/artoolkit5/blob/master/doc/patterns/Matrix%20code%203x3%20(72dpi)/1.png): point your camera at it.