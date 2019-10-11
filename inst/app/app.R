library(g3r)
library(shiny)
library(waiter)
library(geoloc)
library(aframer)
library(arframer)
library(aenvironment)

waiter <- tagList(
  spin_folding_cube(),
  span("Building map of your area...", style = "color:white;")
)

ui <- navbarPage(
  "g3r",
  header = list(
    tags$style("
    nav{display:none;}
    body{background-color:black;color:white;}
    #parent{position: relative;height:100vh;}
    #child{
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
    .centered{text-align:center;}
    #g3D{height:100vh!important;}")
  ),
  id = "nav",
  tabPanel(
    "network",
    use_waiter(),
    div(
      id = "parent",
      div(
        id = "child",
        h1("g3r", class = "centered"),
        br(),
        h2("Generate the map of your area!", class = "centered"),
        br(),
        fluidRow(
          column(4, geoloc::button_geoloc("d3", "3D")),
          column(4, geoloc::button_geoloc("ar", "AR")),
          column(4, geoloc::button_geoloc("vr", "VR"))
        )
      )
    )
  ),
  tabPanel(
    "3DTAB",
    g3rOutput("g3D"),
    hide_waiter_on_drawn("g3D")
  ),
  tabPanel(
    "VRTAB",
    uiOutput("VRmap"),
    hide_waiter_on_drawn("VRmap")
  ),
  tabPanel(
    "ARTAB",
    uiOutput("ARmap"),
    hide_waiter_on_drawn("ARmap")
  )
)

server <- function(input, output, session) {

  observeEvent(input$d3_lon, {
    show_waiter(waiter, color = "#000")
    updateTabsetPanel(session, "nav", selected = "3DTAB")
  })

  observeEvent(input$ar_lon, {
    show_waiter(waiter, color = "#000")
    updateTabsetPanel(session, "nav", selected = "ARTAB")
  })

  observeEvent(input$vr_lon, {
    show_waiter(waiter, color = "#000")
    updateTabsetPanel(session, "nav", selected = "VRTAB")
  })

  output$g3D <- render_g3r({
    req(input$d3_lon)
    req(input$d3_lat)

    g3r(input$d3_lat, input$d3_lon)
  })

  output$ARmap <- renderUI({
    req(input$ar_lon)
    req(input$ar_lat)

    a_scene(
      a_dependency(),
      arframer_dependency(),
      g3r_aframer_dependency(),
      arjs = "sourceType: webcam; detectionMode: mono_and_matrix; matrixCodeType: 3x3; debugUIEnabled: false;",
      a_primitive(
        "marker",
        list(
          a_map(input$ar_lat, input$ar_lon),
          type = "barcode",
          value = 1
        )
      ),
      a_entity(camera = NA)
    )
  })

  output$VRmap <- renderUI({
    req(input$vr_lon)
    req(input$vr_lat)

    a_scene(
      a_dependency(),
      g3r_aframer_dependency(),
      aenvironment_dependency(),
      a_environment(
        environment = aframer::opts_aframe(
          preset = "starry"
        )
      ),
      a_map(input$vr_lat, input$vr_lon)
    )
  })

}

shinyApp(ui, server)