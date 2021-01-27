library(tidyverse)
library(here)
library(janitor)

#Read in the data. 
stays_and_rates_2012_2019 <- read_csv(here::here("data/asthma_data/complete_asthma_stays_rate_2012_2019_with_codes.csv"))


  stays_and_rates_2012_2019 %>% 
  filter(hbresname != "NHS Scotland",
         sex == "Male" | sex == "Female",
         age_grp == "All ages"
  ) %>% 
  ggplot(aes(y = as.numeric(rate))) +
  geom_boxplot()+
  facet_wrap(~ sex) +
    theme_classic() +
    labs(
    x = "Year",
    y = "Proportion of Total BMIs in Area (%)",
    title = "Primary 1 Children Body Mass Index - Clinical",
    subtitle = "Percentage of children who are classed in different BMI categories at their Primary 1 review")
    
  

  
  #ggplot() +
  #aes(x = year, y = ratio, fill = category) +
 # geom_bar(stat = "identity") + 
  #theme_classic() +
 # scale_x_continuous(breaks = 2008: 2018) +
 # scale_y_continuous(breaks = seq(from = 0, to = 100, by = 10)) +
 # labs(
 #   x = "Year",
 #   y = "Proportion of Total BMIs in Area (%)",
 #   title = "Primary 1 Children Body Mass Index - Clinical",
 #   subtitle = "Percentage of children who are classed in different BMI categories at their Primary 1 review"
#  )+ 
 # scale_fill_discrete(name = "BMI Category",
 #                     labels = c(
 #                       "Healthy", 
 #                       "Obese or Severly Obese", 
 #                      "Overweight", 
 #                       "Underweight"))