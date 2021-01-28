# We have two independent samples of asthma rates observed between years 2012 nd 2019 - for females and males. 
# Is there a significant difference between means of the rates in each patient gender?

# We are interested in hypotheses about the difference in population means μ1−μ2
# Both samples are size of 8

# We set the conventional significance level α=0.05

# Hypothesis is a two-tailed test of significance:
# H0: μ_rate(female) = μ_rate(male)
# Ha: μ_rate(female) ≠ μ_rate(male)

# Under H0 - the gender of a patient has no bearing on the rate, i.e. the gender and rate are independent
# There is no difference between the two groups

library(tidyverse)
library(infer)
library(here)

population <- read_csv(here("data/asthma_data/complete_asthma_stays_rate_2012_2019_with_codes.csv"))

# average rate across all 14 HB
## for female
females <- population %>% 
  filter(sex == "Female") %>% 
  filter(rate != "-") %>% 
  filter(age_grp == "All ages") %>% 
  group_by(discharge_fin_yr_end) %>%
  summarise(
    avg_rate = mean(as.numeric(rate))
  ) %>% 
  mutate(sex = "Female")

## for male
males <- population %>% 
  filter(sex == "Male") %>% 
  filter(rate != "-") %>% 
  filter(age_grp == "All ages") %>% 
  group_by(discharge_fin_yr_end) %>%
  summarise(
    avg_rate = mean(as.numeric(rate))
  ) %>% 
  mutate(sex = "Male")

rates <- bind_rows(females, males)

#unique(population$age_grp)

# box plot (8 observations in each group), visualise the distributions
rates %>% 
  ggplot(aes(y = avg_rate, x = sex)) +
  geom_boxplot() 

# calculate exact sample means for each sex
# there is an indication that Females rate tends to be higher on average
rates %>%
  group_by(sex) %>% 
  summarise(
    avg_rate = mean(avg_rate)
  )

# let’s check whether this difference in distributions could be down to sampling variation (i.e. it may have occurred ‘by chance’) 
# or whether it is a statistically significant difference by performing our hypothesis test

# generate our null distribution by permutation
null_distribution <- rates %>% 
  specify(avg_rate ~ sex) %>% #it is the relationship between rate (response) and sex (explanatory) we are testing
  hypothesize(null = "independence") %>% #the null hypothesis is there is no relationship i.e. they are independent
  generate(reps = 1000, type = "permute") %>% 
  calculate(stat = "diff in means", order = c("Female", "Male")) #our sample stat is mean of algarve minus mean of nice, so this is the order we specify in the calculate step

head(null_distribution)

# calculate observed statistics
observed_stat <- rates %>% 
  specify(avg_rate ~ sex) %>%
  calculate(stat = "diff in means", order = c("Female", "Male"))

observed_stat

# visualization of null distribution
# We see from the visualisation that the observed statistic is passed the edge of our null distribution
# So there would be a very very small probability of getting a more extreme value than ours under H0
null_distribution_viz <- null_distribution %>%
  visualise() +
  shade_p_value(obs_stat = observed_stat, direction = "both")
#null_distribution_viz

# let’s calculate the p-value to be sure
p_value <- null_distribution %>%
  get_p_value(obs_stat = observed_stat, direction = "both")
#p_value

# It is smaller than our critical value of 0.05 and so we reject H0
# and conclude that we have found enough evidence in our data to suggest that the average rate in Females is statistically significantly greater than in Males