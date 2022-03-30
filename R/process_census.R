export_facts <- function(){

area_lookup <- read_csv("inst/extdata/lookup/PCD_OA_LSOA_MSOA_LAD_MAY21_UK_LU/PCD_OA_LSOA_MSOA_LAD_MAY21_UK_LU.csv") %>% #not in package because huge
  group_by(lsoa11cd, msoa11cd, ladcd, lsoa11nm, msoa11nm, ladnm, ladnmw) %>%
  summarise()

usethis::use_data(area_lookup)

raw_lookup <- raw %>%
  left_join(area_lookup)

raw_long <- raw %>%
  tidyr::pivot_longer(-GeographyCode)

meta <- meta %>%
  tidyr::unite(variable_name, c("ColumnVariableMeasurementUnit", "ColumnVariableStatisticalUnit", "ColumnVariableDescription")) %>%
  dplyr::rename(name = ColumnVariableCode)

named_data <- raw_long %>%
  dplyr::left_join(meta) %>%
  dplyr::select(-name) %>%
  tidyr::pivot_wider(names_from = variable_name, values_from = value) %>%
  janitor::clean_names()

library(sf) #or the next left join doesn't work

shapes_lad_facts <- shapes_lad %>%
  dplyr::left_join(named_data, by = c("geo_id" = "geography_code"))

usethis::use_data(shapes_lad_facts, overwrite = TRUE)

}
