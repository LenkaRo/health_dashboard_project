library(tidyverse)

smoking_clean <- read_csv("data/priority_4/priority_4_clean")

smoking_clean %>%
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
