BASE_URL <- "https://api.mapbox.com"
BASE_PATH <- c("v4", "mapbox.mapbox-terrain-v2", "tilequery")

#' Get Elevations of point
#' 
#' Get elevations of given coordinates using the Mapbox tilequery API.
#' 
#' @inheritParams g3r
#' @param limit Maximum number of elevations to return.
#' 
#' @examples 
#' \dontrun{get_elevations(39.75953, -105.01109)}
#' 
#' @return A vector of elevations.
#' 
#' @export
get_mapbox_elevations <- function(lat, lon, limit = 50L, 
  mapbox_token = Sys.getenv("MAPBOX_TOKEN")) {

  if(missing(lat) || missing(lon))
    stop("Missing `lat` or `lon`")
  
  if(mapbox_token == "")
    stop("Invalid `mapbox_token`")

  lonlat <- paste0(lon, ",", lat, ".json")
  uri <- httr::parse_url(BASE_URL)
  uri$path <- c(BASE_PATH, lonlat)
  uri$query <- list(
    layers = "contour",
    limit = limit, 
    access_token = mapbox_token
  )
  uri <- httr::build_url(uri)

  response <- httr::GET(uri)
  httr::stop_for_status(response)
  content <- httr::content(response)

  purrr::map(content$features, "properties") %>% 
    purrr::map("ele") %>% 
    unlist()
}
