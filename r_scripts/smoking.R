library(tidyverse)
library(janitor)

scot_surv <- read_csv("data/priority_4/Scottish_Survey_Core_Questions.csv") %>%
  clean_names()

scot_surv <- scot_surv %>% 
  filter(measurement == "Percent")

scot_surv <- scot_surv %>% 
  select(date_code, value, currently_smokes_cigarettes, age)

scot_surv %>% 
  filter(date_code == 2012 : 2018)
