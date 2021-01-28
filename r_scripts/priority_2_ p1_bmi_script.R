library(tidyverse)
library(janitor)
library(here)

# Resources:
#   Data source: https://statistics.gov.scot/resource?uri=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2Fp1-BMI-clinical
#   Public Health Priorities: https://www.gov.scot/binaries/content/documents/govscot/publications/corporate-report/2018/06/scotlands-public-health-priorities/documents/00536757-pdf/00536757-pdf/govscot%3Adocument/00536757.pdf

#The following graph is meant to illustrate the level of historical progress that has been made in Priority 2 of the Scottish Government's Public Health Priorities (PHPs), as set out in 2018.

#Priority 2 is as follows: 

#"A Scotland where we flourish in our early years".

#Within the document, further detail is provided:

#"We want Scotland to be the best place for a child to grow up. Addressing the health and wellbeing issues of our children and young people and recognising, respecting and promoting their rights is essential to achieving this outcome."

#With this in mind, I decided that a measure relating to early years health would be an appropriate measure to represent the priority. The data used for this is as follows:

# Primary 1 Children Body Mass Index - Clinical

# Percent of children who are classed as healthy weight, underweight, overweight, obese or severely obese at their Primary 1 review

#Note: In Scotland, the school year begins in mid-August and children normally start in Primary One between the ages of 4 and a half and 5 and a half. 

#A full publication report and technical report are available. All publications and supporting material to this topic area can be found on the ISD Scotland - Child Health Website.



#Read in the data. 4 data slices have been cleaned and bound in a separate notepad. I've put the original csvs in the data folder in "priority_2".

p1_bmi_for_graph <- read_csv(here::here("data/priority_2_data/p1_bmi_for_graph.csv"))

p1_bmi_for_graph <- p1_bmi_for_graph %>%
#This filter is currently a placeholder for a select box button listing the different "reference_area" options. Although this button will return an individual regions data (as below), I'd also like to add a couple of widgets that don't necessarily require inputs. The first would be a checkbox group button to select which of the weight categories you'd like to have. The second would be a slider to adjust the date range.
  filter(reference_area == "Scotland",
         year %in% 2008:2018) %>% 
  
  ggplot() +
  aes(x = year, y = ratio, fill = category) +
  geom_bar(stat = "identity") + 
  theme_classic() +
  scale_x_continuous(breaks = 2008: 2018) +
  scale_y_continuous(breaks = seq(from = 0, to = 100, by = 10)) +
  labs(
    x = "Year",
    y = "Proportion of Total BMIs in Area (%)",
    title = "Primary 1 Children Body Mass Index - Clinical",
    subtitle = "Percentage of children who are classed in different BMI categories at their Primary 1 review"
  )+ 
  scale_fill_discrete(name = "BMI Category",
                      labels = c(
                        "Healthy", 
                        "Obese or Severly Obese", 
                        "Overweight", 
                        "Underweight"))



