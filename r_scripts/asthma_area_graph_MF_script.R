library(tidyverse)
library(here)
library(janitor)

#Read in the data. 
area_graph_asthma_data <- read_csv(here::here("data/asthma_data/graph_area_asthma_MF_data.csv"))

area_graph_asthma_data_graph <- area_graph_asthma_data %>%
  ggplot() +
  aes(x = year, y = deaths_in_scotland, fill = cause_of_death) +
  geom_area() +
  scale_x_continuous(breaks = 2008: 2018) +
  facet_wrap(~sex) +
  theme_classic() +
  labs(
    x = "Year",
    y = "Deaths",
    title = "Combined deaths from diseases of the respiratory system",
    subtitle = "Scotland - 2008-2018 - by sex",
    fill = "Cause of Death")
  

