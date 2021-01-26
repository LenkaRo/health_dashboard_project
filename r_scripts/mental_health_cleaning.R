library(tidyverse)
library(janitor)
library(dplyr)

#Short Warwick-Edinburgh Mental Wellbeing Scale

mental_health <- read_csv("data/mental_health_data/data/mental_health_data.csv") %>% clean_names()

mental_health_clean <- mental_health %>% 
  select(date_code, value, type_of_tenure, household_type, age, gender, limiting_long_term_physical_or_mental_health_condition) %>% 
  rename(limiting_condition = limiting_long_term_physical_or_mental_health_condition) %>% rename(swemwbs_score = value)

mental_health_clean <- mental_health_clean %>% 
  filter(date_code == 2014 | date_code == 2015| date_code == 2016| date_code == 2017)

mental_health <- mental_health_clean

write_csv(mental_health, "mental_health.csv")
