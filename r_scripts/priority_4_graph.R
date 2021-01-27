library(tidyverse)
library(here)

smoking_clean <- read_csv(here("data/priority_4/priority_4_clean"))

priority_4_graph <- smoking_clean %>%
  filter(smokes_yes_no == "Yes") %>% 
  arrange(date_code) %>% 
  group_by(date_code, age) %>% 
  summarise(value = mean(value)) %>% 
  group_by(age) %>% 
  ggplot() +
  aes(x = date_code, y = value, colour = age) +
  geom_line(aes(group = age)) +
  geom_point() +
  scale_y_continuous() +
  theme_classic() +
  theme(legend.title = element_blank()) +
  labs(
    x = "",
    y = "Smoking Percent",
    title = "Smoking By Age Group"
  )
