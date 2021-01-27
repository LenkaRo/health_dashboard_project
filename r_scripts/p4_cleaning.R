library(tidyverse)
library(janitor)

scot_surv <- read_csv("data/priority_4/Scottish_Survey_Core_Questions.csv") %>%
  clean_names()

scot_surv <- scot_surv %>% 
  filter(measurement == "Percent")

scot_surv <- scot_surv %>% 
  select(date_code, value, currently_smokes_cigarettes, age)

scot_surv <- scot_surv %>% 
  filter(date_code == 2012 | date_code == 2013 | date_code == 2014 | date_code == 2015 | date_code == 2016 | date_code == 2017 | date_code == 2018)

smoking_clean <- scot_surv %>% 
rename(smokes_yes_no = currently_smokes_cigarettes)

smoking_clean <- smoking_clean %>% 
  filter(age == "16-34 years" | age == "16-64 years" | age == "35-64 years" | age == "65 years and over")

write_csv(smoking_clean, "priority_4_clean")
