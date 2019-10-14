nuptse <- tibble::tibble(
  name = c(
    "Nuptse Nup II",
    "Nuptse Nup I",
    "Nuptse I",
    "Nuptse II"
  ),
  lat = c(
    27.96957,
    27.96925,
    27.96794,
    27.96582
  ),
  lon = c(
    86.88203,
    86.88495,
    86.88707,
    86.89033
  ),
  ele = c(
    7742,
    7784,
    7861,
    7827
  )
)

# everest
everest <- tibble::tibble(
  name = c(
    "Everest",
    "Base Camp IV",
    "Base Camp III",
    "Base Camp II",
    "Base Camp I"
  ),
  lat = c(
    27.989219,
    27.974249,
    27.968336,
    27.981890,
    27.989220
  ),
  lon = c(
    86.924632,
    86.930039,
    86.925103,
    86.903184,
    86.876391
  ),
  ele = c(
    8848,
    7990,
    7674,
    6611,
    6133
  )
)

library(g3r)

g3r(27.96775, 86.88593) %>% 
  g3r_points(nuptse, lat, lon, ele)

g3r(27.985655, 86.903697) %>% 
  g3r_points(everest, lat, lon, ele)

usethis::use_data(nuptse, everest, overwrite = TRUE)
