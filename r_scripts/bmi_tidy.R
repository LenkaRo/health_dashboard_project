# load in libraries
library(tidyverse)
library(here)
library(lubridate)
library(janitor)

overweight <- read_csv(here("data/priority_6/BMI/scottish_health_survey.csv")) %>% clean_names() 

years <- unique(overweight$date_code) %>% sort()

overweight <- overweight %>% 
  select(-feature_code, -units) %>% 
  filter(measurement == "Percent") %>% 
  filter(sex == "Female" | sex == "Male") %>% 
  filter(date_code != "2019") %>% 
  mutate(
    years = as.character(date_code)
  ) %>% 
  filter(scottish_health_survey_indicator == "Overweight: Overweight (including obese)") %>% 
  arrange(date_code) %>% 
  group_by(sex)

write_csv(overweight, path = "data/priority_6/BMI/scottish_health_survey_tidy.csv")

# unique(overweight$scottish_health_survey_indicator)
