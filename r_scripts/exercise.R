#########################################
# A healthy diet and regular exercise   #
#########################################

# Priority 6: A Scotland where we eat well, have a healthy weight and are physically active

# Resources: 
#   Public Health Priorities: https://www.gov.scot/binaries/content/documents/govscot/publications/corporate-report/2018/06/scotlands-public-health-priorities/documents/00536757-pdf/00536757-pdf/govscot%3Adocument/00536757.pdf
#
# A healthy diet and regular exercise bring a wide range of benefits for both physical and mental health
# Poor diet, an unhealthy weight and physical inactivity are all major and growing issues for Scotland and impact across all public services and communities, and with significant costs to the economy.
# It is a very complex and challenging topic where multiple factors play role - our income, influence from family and friends, marketing influences;
#   - access to affordable sports, social expectations etc.
# In 2018, a 36 pages long action plan called A More Active Scotland was published. It's aim has been to find ways to encourage people to be more physically active
# (just to pick an example, it was suggesting to increase investment that support active travel, eg making towns and cities safer for walkers and cyclist)
# This actions plan cooperates with various has further impact to other action plans, for instance plans aiming to lower carbon emission etc.
# In July last year, the Scottish Government published a plan called A Healthier Future – Scotland's Diet and Healthy Weight Delivery Plan. The plan sets out a vision for everyone in Scotland to eat well and have a healthy weight.
#
# Diet, physical activity and sedentary behavior are strongly associated with BMI


# Graph - Activity Levels of adults aged 16 and over, 2018
#
# Data: Adult Physical Activity, xlsx, sheet W243, available from: https://www.gov.scot/publications/scottish-health-survey-2018-supplementary-tables/
# Along with eating well and having a healthy weight, being physically active forms one of the six Public Health Priorities for Scotland published jointly by the Scottish Government and COSLA in 2018.
# The CMO 2011 recommendations stated that adults should engage in at least moderate activity for a minimum of 150 minutes a week. Alternatively, 75 minutes of vigorous activity spread across the week.
#
# We are looking at a graph showing an Estimate of Activity Levels of adults aged 16 and over in Scotland in 2018
# An estimated 66% of adults (aged 16 years and over) met the guideline to do at least 150 minutes moderate or 75 minutes vigorous activity (or an equivalent combination of these) per week in 2018
# Men were more likely than women to meet physical activity guidelines in 2018 (70% and 62%, respectively).
# Adults in the most deprived areas of Scotland were least likely to meet physical activity guidelines.
#
# Physical inactivity is estimated to contributes to nearly 2,500 deaths in Scotland annually, costing the NHS around £94 million.



# load in libraries
library(tidyverse)
library(here)
library(lubridate)

physical_activity <- read_csv(here("data/priority_6/physical_activity/activity_level_2018.csv"), col_names = FALSE)

names(physical_activity) <- c("activity_level", "x16_24", "x25_34", "x35_44", "x45_54", "x55_64", "x65_74", "x75", "total")
row_names <- c("Male", "Male", "Male", "Male",
                                 "Female", "Female", "Female", "Female",
                                 "All adults", "All adults", "All adults", "All adults")

physical_activity$gender <- row_names 

# change the order of factor levels by specifying the order of activity_level explicitly
physical_activity <- physical_activity %>% 
  mutate(
    activity_level = factor(activity_level, levels = c("Meets recommendations", "Some activity", "Low activity", "Very low activity"))
  )

# check the order of levels
# physical_activity$activity_level
# Levels: Meets recommendations > Some activity > Low activity > Very low activity

# plot a graph Physical activity levels in Scotland by age, 2018
physical_activity_graph <- physical_activity %>% 
  select(activity_level, total, gender) %>% 
  filter(gender == "Male" | gender == "Female") %>% 
  ggplot() +
  aes(x = activity_level, y = total, fill = gender) +
  geom_col(position = "dodge") +
  theme_classic() +
  theme(legend.title = element_blank()) +
  labs(
    x = "Activity level",
    y = "Percentage",
    title = "Activity Levels of adults aged 16 and over, 2018"
  )
