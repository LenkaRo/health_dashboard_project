library(tidyverse)
library(here)
library(janitor)

#Read in the data. 
asthma_line_deaths_by_gender <- read_csv(here::here("data/asthma_data/graph_line_asthma_MF_deaths.csv"))

asthma_line_deaths_by_gender %>%
  ggplot() +
  aes(x = year, y = deaths_in_scotland, colour = sex) +
  geom_line() +
  scale_x_continuous(breaks = 2008: 2018) +
  theme_classic() +
  labs(
    x = "Year",
    y = "Deaths",
    title = "Asthma Deaths",
    subtitle = "Scotland - 2008-2018 - by sex",
    )