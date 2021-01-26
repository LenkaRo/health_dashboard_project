library(tidyverse)
library(janitor)
library(dplyr)

#Short Warwick-Edinburgh Mental Wellbeing Scale

mental_health <- read_csv("data/mental_health_data/data/mental_health_data.csv") %>% clean_names()

mental_health_clean <- mental_health %>% 
  select(date_code, value, type_of_tenure, household_type, age, gender, limiting_long_term_physical_or_mental_health_condition) %>% 
  rename(limiting_condition = limiting_long_term_physical_or_mental_health_condition) %>% rename(swemwbs_score = value)

mental_health_clean %>% 
  filter(c("2014", "2015", "2016", "2017"))

mental_health %>% 
arrange(date_code) %>% 
  group_by(date_code, age) %>% 
  summarise(value = mean(value)) %>% 
  group_by(age) %>% 
  ggplot() +
  aes(x = date_code, y = value, colour = age) +
  geom_line(aes(group = age)) +
  geom_point() +
  theme_classic() +
  theme(legend.title = element_blank()) +
  labs(
    x = "",
    y = "SWEMWBS",
    title = "SWEMWBS Score over Time"
  )
