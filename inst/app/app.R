library(g3r)
library(shiny)
library(geoloc)

ui <- fluidPage(
  tags$head(
    tags$style("body{background-color:black;}#g3r{height:100vh!important;}")
  ),
  geoloc::onload_geoloc(),
  g3rOutput("g3r")
)

server <- function(input, output) {

  output$g3r <- render_g3r({
    req(input$geoloc_lon)
    req(input$geoloc_lat)

    g3r(input$geoloc_lat, input$geoloc_lon)
  })

}

shinyApp(ui, server)