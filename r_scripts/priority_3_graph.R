library(tidyverse)
library(here)

mental_health_clean <- read_csv(here("data/mental_health_data/mental_health.csv"))

priority_3_graph <- mental_health_clean %>% 
  arrange(date_code) %>% 
  group_by(date_code, age) %>% 
  summarise(swemwbs_score = mean(swemwbs_score)) %>% 
  group_by(age) %>% 
  ggplot() +
  aes(x = date_code, y = swemwbs_score, colour = age) +
  geom_line(aes(group = age)) +
  geom_point() +
  scale_y_continuous(limits = c(24, 25)) +
  theme_classic() +
  theme(legend.title = element_blank()) +
  labs(
    x = "",
    y = "Mental Health Score",
    title = "Mental Health Over Time"
  )

  