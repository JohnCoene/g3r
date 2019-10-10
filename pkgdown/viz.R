setwd("./docs")

library(g3r)
library(aframer)
library(arframer)

scene <- embed_aframe(
  a_scene(
    a_dependency(),
    arframer_dependency(),
    g3r_aframer_dependency(),
    arjs = "sourceType: webcam; detectionMode: mono_and_matrix; matrixCodeType: 3x3; debugUIEnabled: false;",
    a_primitive(
      "marker",
      list(
        a_map(position = aframer::xyz_aframe(0, 0, 1)),
        type = "barcode",
        value = 1
      )
    ),
    a_entity(camera = NA)
  )
)

htmltools::save_html(scene, file = "ar.html")

scene2 <- embed_aframe(
  a_scene(
    a_dependency(),
    g3r_aframer_dependency(),
    a_map()
  )
)

htmltools::save_html(scene2, file = "vr.html")

setwd("../")