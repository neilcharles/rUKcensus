export_shapes_and_data <- function(){

#Age Structure
raw <- readr::read_csv("inst/extdata/stats/key_statistics/KS102EWDATA.CSV")
meta <- readr::read_csv("inst/extdata/stats/key_statistics/KS102EW_2011STATH_NAT_OA_REL_1.4.4/KS102EWDESC0.CSV")
# area_lookup <- read_csv("inst/extdata/lookup/PCD_OA_LSOA_MSOA_LAD_MAY21_UK_LU/PCD_OA_LSOA_MSOA_LAD_MAY21_UK_LU.csv") %>% #not in package because huge
#   group_by(lsoa11cd, msoa11cd, ladcd, lsoa11nm, msoa11nm, ladnm, ladnmw) %>%
#   summarise()
#
# usethis::use_data(area_lookup)

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

shapes_facts_lad <- shapes_lad %>%
  dplyr::left_join(named_data, by = c("cmlad11cd" = "geography_code"))

usethis::use_data(shapes_facts_lad, overwrite = TRUE)

}
