# load in libraries
library(tidyverse)
library(here)
library(lubridate)

physical_activity <- read_csv(here("data/priority_6/physical_activity/activity_level_2018.csv"), col_names = FALSE)

names(physical_activity) <- c("activity_level", "x16_24", "x25_34", "x35_44", "x45_54", "x55_64", "x65_74", "x75", "total")
row_names <- c("Male", "Male", "Male", "Male",
                                 "Female", "Female", "Female", "Female",
                                 "All adults", "All adults", "All adults", "All adults")

physical_activity$gender <- row_names 

# change the order of factor levels by specifying the order of activity_level explicitly
physical_activity <- physical_activity %>% 
  mutate(
    activity_level = factor(activity_level, levels = c("Meets recommendations", "Some activity", "Low activity", "Very low activity"))
  )

physical_activity <- physical_activity %>% 
  select(activity_level, total, gender) %>% 
  filter(gender == "Male" | gender == "Female")

# check the order of levels
# physical_activity$activity_level
# Levels: Meets recommendations > Some activity > Low activity > Very low activity

write_csv(physical_activity, path = "data/priority_6/physical_activity/activity_level_2018_tidy.csv")
