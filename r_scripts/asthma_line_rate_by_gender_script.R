library(tidyverse)
library(here)
library(janitor)

#Read in the data. 
asthma_line_rate_MF_BS <- read_csv(here::here("data/asthma_data/graph_line_rates_MF_BS.csv"))

asthma_line_rate_MF_BS %>%                                    
  ggplot() +
  aes(x = discharge_fin_yr_end,
      y = as.numeric(rate),
      colour = sex) +
  geom_line() +
  scale_x_continuous(breaks = 2012: 2019) +
  theme_classic() +
  labs(
    x = "Year",
    y = "Rate",
    title = "Asthma Rate of Incidents (per 100,000)",
    subtitle = "Scotland - 2012-2019 - by sex"
  )
