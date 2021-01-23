#################################
# Life Expectancy in Scotland   #
#################################

# Overview
#
# Resources:
#   Data source: statistics.gov.uk
#   Public Health Priorities: https://www.gov.scot/binaries/content/documents/govscot/publications/corporate-report/2018/06/scotlands-public-health-priorities/documents/00536757-pdf/00536757-pdf/govscot%3Adocument/00536757.pdf
#
# The Life Expectancy (LE) in Scotland is calculated using abridged life tables (= calculated for grouped ages, range of 3 years) to allow for comparison with the subnational figures. 
#
# Graph 1
# We are looking at a graph showing the LE in Scotland for females and males based on the year they were born.
# 
## LE refers to the number of years that a person could expect to survive if the current mortality rates for each age group, sex and geographic area remain constant throughout their life.
## Life expectancy is a useful statistic as it provides a snapshot of the health of a population and allows the identification of inequalities between populations. 
#
# Both lines have a steady upward trend until the year of 2015, where we see a drop. 
# The line then carries on in a horizontal way suggesting no changes in life expectancy for either gender.
# The LE in Scotland for those born between 2016 and 2018 was 77.2 years for males and 81.2 years for females
#
# Regarding to nrscotland.gov.uk, this stall/drop in LE in Scotland is especially seen in some particular councils and correlates with SIMD (Scottish index of multiple deprivation)
# There is a big gap in life expectancy between the most and least deprived areas. The gap is roughly 13 years for males and around 10 years for females. 
# This gap is even bigger for healthy life expectancy: around 24 years for females and 23 years for males.
#
# Graph 2
# This graph is showing the Healthy Life Expectancy (HLE) in Scotland for females and males based on the year they were born.
# ## HLE refers to the number of years that a person could be expected to live in ‘good’ or ‘very good’ health based on how individuals perceive their general health. (HLE is derived by combining the estimates of (LE) with the data on self-assessed health (from the Annual Population Survey)) 
#
## Both numbers (LE and HLE) are used as indicators in monitoring and investigating health inequality issues within Scotland, setting public health targets, informing pensions policy, research and teaching. 


# load in libraries
library(tidyverse)
library(here)
library(janitor)

# read in data
# check your pwd, here::here()
# subset and summarise data needed for the life expectancy graph
# plot the graph
life_expectancy <- read_csv(here("data/life_expectancy/life_expectancy.csv")) %>% clean_names() %>% 
  arrange(date_code) %>% 
  filter(age == "0 years") %>% 
  group_by(date_code, sex) %>% 
  summarise(avg_life_expectancy = mean(value)) %>% 
  group_by(sex) %>% 
  ggplot() +
  aes(x = date_code, y = avg_life_expectancy, colour = sex) +
  geom_point() +
  geom_line() +
  expand_limits(y = 60) +
  theme_classic() +
  scale_y_continuous(breaks = seq(from = 60, to = 85, by = 2)) +
  theme(axis.text.x = element_text(angle = 90)) +
  theme(legend.title = element_blank()) +
  labs(
    x = "",
    y = "Life Expectancy in years",
    title = "Life Expectancy at Birth in Scotland"
  )

# # calculate the life expectancy statistics
# life_expectancy %>% 
#   group_by(sex) %>% 
#   filter(age == "0 years") %>% 
#   filter(date_code == "2016-2018") %>% 
#   summarise(avg_life_exp = mean(value))
