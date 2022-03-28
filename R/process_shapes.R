build_shapes <- function() {
  shapes_lad <-
    sf::st_read("inst/extdata/shapes/la/la.shp")

  shapes_msoa <-
    sf::st_read("inst/extdata/shapes/msoa/msoa.shp")

  shapes_lsoa <-
    sf::st_read("inst/extdata/shapes/lsoa/lsoa.shp")

  usethis::use_data(shapes_lad,
                    shapes_msoa,
                    shapes_lsoa, overwrite = TRUE)
}
