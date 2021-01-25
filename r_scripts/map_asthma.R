library(tidyverse)
library(sf)


#Health Boards (February 2018) Names and Codes in Scotland from GeoPortal.statistics.gov.uk
#https://geoportal.statistics.gov.uk/datasets/727ded23dc8f4defaed3b54a31d4a15f_0
#Get full data set -> go to API Explorer -> APIs -> GeoJSON (copy)
hb <- st_read("https://opendata.arcgis.com/datasets/0a6db24b39ab4dde82f3af50363a6903_0.geojson")

hb_codes <- unique(hb$HB19CD)

shs <- read_csv("data/asthma_data/Scottish_Health_Survey_Local_area_level_data.csv") %>% 
  filter(FeatureCode %in% hb_codes) %>% 
  filter(`Scottish Health Survey Indicator` == "Doctor-diagnosed asthma: Yes") %>% 
  filter(Measurement == "Percent")

#unique(shs$`Scottish Health Survey Indicator`)

# Join the two datasets
hb_shs <- merge(hb, shs, by.x = 'HB19CD', by.y = 'FeatureCode')

# plot using geom_sf
hb_shs %>% 
  ggplot() +
  geom_sf(aes(fill = Value), data = hb_shs["Value"], colour = "white")
