# Life Expectancy in Scotland - graph

library(tidyverse)
library(here)
library(lubridate)
library(janitor)

here::here()

life_expectancy <- read_csv(here("data/life_expectancy.csv")) %>% clean_names()

#head(life_expectancy)

#unique(life_expectancy$age) %>%  sort()
#unique(life_expectancy$date_code) %>% sort()

#class(life_expectancy$age)

life_expectancy_years <- life_expectancy %>% 
  separate(
    col = date_code,
    into = c("start_year", "end_year"),
    sep = "-"
  ) %>% 
  mutate(
    start_year = as.numeric(start_year),
    end_year = as.numeric(end_year),
    mid_year = (end_year + start_year)/2)
  ) 

class(life_expectancy_years$mid_year)

life_expectancy_years %>% 
  filter(age == "0 years") %>% 
  group_by(mid_year) %>% 
  summarise(avg_life_expectancy = mean(value)) %>% 
  ggplot() +
  aes(x = mid_year, y = avg_life_expectancy) +
  geom_point() +
  geom_line() +
  expand_limits(y = 65) +
  #scale_x_continuous(lablels = 1992:2017) +
  labs(
    x = "",
    y = "Life Expectancy at Birth (years)",
    title = "Life Expectancy in Scotland"
  )
