library(tidyverse)
library(sf)
library(tmap)
library(rmapshaper)
library(leaflet)
library(shapefiles)
library(rgdal)

# Delivery of frontline healthcare services in Scotland are the responsibility of 14 regional National Health Service (NHS) Boards that report to the Scottish Government.
# We are looking at a choropleth map that is separated by the healthboards.
# Each HB is colored in proportion to a statistical variable that represents an aggregate summary of a geographic characteristic within each area.

# Proportion - indicator the sum of all admissions for each of the healthboards (HB)
# Stays
# Rate

# The map aggregates the statistical variable by year. Either each individual year in a range of 2012 to 2019, or any subrange.


#---------------------------------------------#

# Download NHS Health Boards shape file https://www.spatialdata.gov.scot/geonetwork/srv/api/records/f12c3826-4b4b-40e6-bf4f-77b9ed01dc14
# st_read() read simple features from file (from the SF simple file package), function automatically stores information about the data. We are particularly interested in the geospatial metadata

# read in the HB GeoSpatial metadata (each HB has a list of coordinates) (reads in multiple files (.shp, shx, .dbf, .prj), app.R has to be above it the directory hierarchy!)
# read in the CLEANED shapefile
hb <- st_read("data/asthma_data/SG_NHS_HealthBoards_2019_lower_resolution", "SG_NHS_HealthBoards_2019_simplified")

# display first 6 rows
#head(hb)

# view the geometry type (multipolygon)
#st_geometry_type(hb)

# get a vector of each of the 14 HB codes
hb_codes <- unique(hb$HBCode)

# read in Scottish Health Survey (SHS) dataset - subset for indicator Asthma and our HB data zones
shs_asthma_diagnosed <- read_csv("data/asthma_data/Scottish_Health_Survey_Local_area_level_data.csv") %>% 
  filter(FeatureCode %in% hb_codes) %>% 
  filter(`Scottish Health Survey Indicator` == "Doctor-diagnosed asthma: Yes") %>% 
  filter(Measurement == "Percent") %>% 
  filter(Sex == "All")

#shs_asthma_diagnosed


# create functin that negates %in%
`%notin%` <- Negate(`%in%`)

# read in data
asthma_stays_rate <- read_csv("data/asthma_data/complete_asthma_stays_rate_2012_2019_with_codes.csv")

asthma_stays_rate_summary <- asthma_stays_rate %>%
  mutate(HBName = str_sub(hbresname, 5)) %>% 
  filter(HBName %notin% c("cotland", "r", "Scotland")) %>% 
  filter(sex == "Both Sexes") %>% 
  filter(rate != "-") %>% 
  mutate(rate = as.numeric(rate)) %>% 
  group_by(discharge_fin_yr_end, HBName) %>% 
  summarise(stay = sum(stays),
            avg_rate = mean(rate))


# join all three tables (creates new geospatial object with Asthma data), need to specify keys as they have different names
map_and_data <- merge(hb, shs_asthma_diagnosed, by.x = "HBCode", by.y = "FeatureCode") %>% 
  merge(asthma_stays_rate_summary, by = "HBName") %>% 
  select(-c(DateCode, Measurement, Units))

head(map_and_data)

# # map Asthma indicator by HB
# ## create choropleth map with ggplot geom_sf() (map the simple features object)
# map_and_data %>% 
#   ggplot(aes(fill=Value)) +
#   geom_sf()


# #create choropleth map with tmap - has interactive features (using tmap to turn it into interactive JavaScript map (zoom, click and display the data))
# tm_shape(map_and_data) +
#   #tm_polygons("Value", id = "HBName", fill = "Value", title = "Percentage %") + # add polygons colored by the Value (percentage), display name of HB when hovering mouse over the map
#   #tm_polygons("avg_stay", id = "HBName", fill = "avg_stay", title = "Average length of stay") +
#   tm_polygons("avg_rate", id = "HBName", fill = "avg_rate", title = "Average rate") +
#   tmap_mode("view") # turn it into interactive (clickable) map, set tmap viewing mode to "view" = interactive

#hb_asthma_map

# re-draw the map
#hb_asthma_map <- tmap_last()
#hb_asthma_map

# # save into stand alone file
# tmap_save(hb_asthma_map, "data/asthma_data/hb_asthma_map.html")


#### play with the map design


#--------------------using GeoJSON-----------------------#

# GeoJSON (format for encoding a variety of geographic data structures)

# GeoSpatial file with boundary information for each HB
## Health Boards (February 2018) Names and Codes in Scotland from GeoPortal.statistics.gov.uk
## https://geoportal.statistics.gov.uk/datasets/727ded23dc8f4defaed3b54a31d4a15f_0
## Get full data set -> go to API Explorer -> APIs -> GeoJSON (copy)

# read in the HB GeoSpatial metadata (each HB has a list of coordinates)
# hb <- st_read("data/asthma_data/Local_Health_Boards__December_2016__Boundaries.geojson")


#------------------------extras--------------------------#

# for a list of supported formats - SHP missing??
#st_drivers()

# create choropleth map with ggplot geom_sf(), or better using tmap to turn it into interactive JavaScript map (zoom, click and display the data)
# https://www.youtube.com/watch?v=GMi1ThlGFMo

