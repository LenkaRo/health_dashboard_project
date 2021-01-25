# load in libraries
library(tidyverse)
library(here)
library(lubridate)
library(janitor)

overweight <- read_csv(here("data/priority_6/BMI/scottish_health_survey.csv")) %>% clean_names() 

years <- unique(overweight$date_code) %>% sort()

bmi_graph <- overweight %>% 
  filter(measurement == "Percent") %>% 
  filter(sex == "Female" | sex == "Male") %>% 
  filter(date_code != "2019") %>% 
  filter(scottish_health_survey_indicator == "Overweight: Overweight (including obese)") %>% 
  arrange(date_code) %>% 
  group_by(sex) %>% 
  ggplot() +
  aes(x = date_code, y = value, colour = sex) +
  geom_line(aes(group = sex)) +
  geom_point() +
  expand_limits(y = c(0, 80)) +
  theme_classic() +
  theme(legend.title = element_blank()) +
  scale_x_continuous(labels = as.character(years), breaks = years) +
  labs(
    x = "Survey Year",
    y = "Percentage",
    title = "Prevalence of overweight incl. obesity among adults aged 16 and over",
    subtitle = "(BMI 25 kg/m² and over)"
  )

# unique(overweight$scottish_health_survey_indicator)
