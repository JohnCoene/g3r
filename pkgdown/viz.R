setwd("./docs")

library(g3r)
library(aframer)
library(arframer)
library(aenvironment)

scene <- embed_aframe(
  a_scene(
    a_dependency(),
    arframer_dependency(),
    g3r_aframer_dependency(),
    arjs = "sourceType: webcam; detectionMode: mono_and_matrix; matrixCodeType: 3x3; debugUIEnabled: false;",
    a_primitive(
      "marker",
      list(
        a_map(46.53, 7.96, position = aframer::xyz_aframe(0, 0, -1)),
        type = "barcode",
        value = 1
      )
    ),
    a_entity(camera = NA)
  )
)

htmltools::save_html(scene, file = "ar.html")

scene2 <- a_scene(
  a_dependency(),
  g3r_aframer_dependency(),
  aenvironment_dependency(),
  a_environment(
    environment = aframer::opts_aframe(
      preset = "starry"
    )
  ),
  a_map(),
  a_entity(id="camera", camera = NA, `look-controls` = NA, position="0 1.6 0")
)


htmltools::save_html(scene2, file = "vr.html", background = "black")

setwd("../")
