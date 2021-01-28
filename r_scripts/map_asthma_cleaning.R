library(tidyverse)
library(rmapshaper)

# Choropleth map - areas are colored in proportion to a statistical variable that represents an aggregate summary of a geographic characteristic within each area
# eg indicator the sum of all admissions for each of the healthboards (HB).

# Download NHS Health Boards shape file https://www.spatialdata.gov.scot/geonetwork/srv/api/records/f12c3826-4b4b-40e6-bf4f-77b9ed01dc14
# st_read() read simple features from file (from the SF simple file package), function automatically stores information about the data. We are particularly interested in the geospatial metadata

# read in the HB GeoSpatial metadata (each HB has a list of coordinates)
# read in the shapefile
hb <- st_read("data/asthma_data/SG_NHS_HealthBoards_2019/SG_NHS_HealthBoards_2019.shp")

# lower the resolution of polygons to cut down the execution time
hb <- ms_simplify(hb)

# save a new shapefile
st_write(hb, "data/asthma_data/SG_NHS_HealthBoards_2019_lower_resolution/SG_NHS_HealthBoards_2019_simplified.shp")