library(tidyverse)
library(here)
library(janitor)

#Read in the data. 
stays_and_rates_2012_2019 <- read_csv(here::here("data/asthma_data/box_plot_asthma_MF.csv"))


stays_and_rates_2012_2019_graph <- stays_and_rates_2012_2019 %>% 
  ggplot(aes(y = as.numeric(rate))) +
  geom_boxplot()+
  facet_wrap(~ sex) +
    theme_classic() +
    labs(
    x = "",
    y = "Mean Rate of Incidents (per 100,000)",
    title = "Dispersion of Asthma Rates - by sex",
    subtitle = "All Regions in Scotland - 2012-2019")
    
stays_and_rates_2012_2019 %>% 
  group_by(sex) %>% 
  summarise(avg = mean(as.numeric(rate), na.rm = TRUE))
