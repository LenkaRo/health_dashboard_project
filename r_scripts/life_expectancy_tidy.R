# load in libraries
library(tidyverse)
library(here)
library(janitor)

life_expectancy <- read_csv(here("data/life_expectancy/life_expectancy.csv")) %>% clean_names() %>% 
  arrange(date_code) %>% 
  filter(age == "0 years") %>% 
  group_by(date_code, sex) %>% 
  summarise(avg_life_expectancy = mean(value)) %>% 
  group_by(sex) 

write_csv(life_expectancy, path = "data/life_expectancy/life_expectancy_tidy.csv")

# # calculate the life expectancy statistics
# life_expectancy %>% 
#   group_by(sex) %>% 
#   filter(age == "0 years") %>% 
#   filter(date_code == "2016-2018") %>% 
#   summarise(avg_life_exp = mean(value))
