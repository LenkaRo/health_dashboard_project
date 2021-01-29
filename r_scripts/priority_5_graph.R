library(tidyverse)
library(janitor)
library(here)

life_expectancy <- read_csv(here("data/inequality/healthy_life_expectancy.csv")) %>% 
  clean_names()

# filter for one year
one_year_life_expectancy <- life_expectancy %>% 
  filter(date_code == "2016-2018") %>% 
  filter(measurement == "Count") %>% 
  filter(age == "0 years") %>% 
# group by simd and summarise average value
  group_by(simd_quintiles) %>% 
  summarise(le = mean(value))

# visualise

priority_5_graph <- one_year_life_expectancy %>% 
  filter(simd_quintiles != "All") %>% 
  ggplot() +
  aes(x = simd_quintiles, y = le, fill = "coral") +
  geom_col() +
  labs(
    title = "Life expectancy according to deprivation quintile",
    subtitle = "Average life expectancy at age 0 for Scottish residents grouped by Scottish Index of Multiple Deprivation quintile for the years 2016-2018",
    x = "SIMD quintile",
    y = "Life expectancy"
  ) +
  scale_y_continuous(breaks = c(10, 20, 30, 40, 50, 60, 70)) +
  theme_minimal() +
  theme(legend.position = "none") 

# add to app

# chart by gender

# chart of le over time for highest and lowest simd

