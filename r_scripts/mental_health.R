library(tidyverse)
library(janitor)



mental_health <- read_csv("data/mental_health_data/data/mental_health_data.csv") %>% clean_names()

mental_health


