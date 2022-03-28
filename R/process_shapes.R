build_shapes <- function() {
  shapes_lad <-
    sf::st_read("inst/extdata/shapes/la/la.shp") %>%
    dplyr::rename(geo_id = cmlad11cd,
                  geo_name = cmlad11nm) %>%
    dplyr::select(geo_id, geo_name, geometry)

  shapes_msoa <-
    sf::st_read("inst/extdata/shapes/msoa/msoa.shp") %>%
    dplyr::rename(geo_id = MSOA11CD,
                  geo_name = MSOA11NM) %>%
    dplyr::select(geo_id, geo_name, geometry)

  shapes_lsoa <-
    sf::st_read("inst/extdata/shapes/lsoa/lsoa.shp") %>%
    dplyr::rename(geo_id = LSOA11CD,
                  geo_name = LSOA11NM) %>%
    dplyr::select(geo_id, geo_name, geometry)

  usethis::use_data(shapes_lad,
                    shapes_msoa,
                    shapes_lsoa, overwrite = TRUE)
}
