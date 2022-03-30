build_shapes <- function() {

  lookup_areas <- readr::read_csv("inst/extdata/lookup/area_names/PCD_OA_LSOA_MSOA_LAD_MAY21_UK_LU.csv") %>% #not in package because huge
    dplyr::group_by(lsoa11cd, msoa11cd, ladcd, lsoa11nm, msoa11nm, ladnm, ladnmw) %>%
    dplyr::summarise() %>%
    dplyr::ungroup()

  usethis::use_data(lookup_areas, overwrite = TRUE)

  shapes_lsoa <-
    sf::st_read("inst/extdata/shapes/lsoa/lsoa.shp") %>%
    sf::st_transform(crs = 4326) %>%
    dplyr::rename(geo_id = LSOA11CD,
                  geo_name = LSOA11NM) %>%
    dplyr::select(geo_id, geo_name, geometry) %>%
    dplyr::left_join(
      readr::read_rds("inst/extdata/stats/population/stats_population_lsoa.rds"), by = "geo_id"
    )


  shapes_lad <-
    sf::st_read("inst/extdata/shapes/la/LAD_DEC_2021_UK_BGC.shp") %>%
    sf::st_transform(crs = 4326) %>%
    dplyr::rename(geo_id = LAD21CD,
                  geo_name = LAD21NM) %>%
    dplyr::select(geo_id, geo_name, geometry) %>%
    dplyr::left_join(
      readr::read_rds("inst/extdata/stats/population/stats_population_lad.rds"), by = "geo_id"
    )


  shapes_msoa <-
    sf::st_read("inst/extdata/shapes/msoa/msoa.shp") %>%
    sf::st_transform(crs = 4326) %>%
    dplyr::rename(geo_id = MSOA11CD,
                  geo_name = MSOA11NM) %>%
    dplyr::select(geo_id, geo_name, geometry) %>%
    dplyr::left_join(
      readr::read_rds("inst/extdata/stats/population/stats_population_msoa.rds"), by = "geo_id"
    )

  usethis::use_data(shapes_lad,
                    shapes_msoa,
                    shapes_lsoa, overwrite = TRUE)
}
