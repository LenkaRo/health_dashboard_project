#########################################
# A healthy diet and regular exercise   #
#########################################

# Priority 6: A Scotland where we eat well, have a healthy weight and are physically active

# Resources: 
#   Data source: Supplementary tables are available on the Scottish Government SHeS website, eg for 2018 https://www.gov.scot/publications/scottish-health-survey-2018-volume-1-main-report/
#                                                                                                   2008 - 2012 https://www.gov.scot/publications/scottish-health-survey-2012-volume-1-main-report/pages/11/#table71
#                (downloaded as .xls file, only one sheet with relevant statistics kept, saved as .numbers file, exported as .csv file, relevant numbers extracted)
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

# Graph 1 - BMI by age, time series - 2018

# 2/3 two thirds (65%) of adults in Scotland Obesity (BMI 30+) ranges from 20% in the are overweight
# We are looking at a graph showing Prevalence of overweight including obesity (BMI 25 and over) among adults aged 16 and over, 2003 to 2018

# In 2018, 65% of adults aged 16 and over were overweight, including 28% who were obese. The numbers are remaining broadly stable since 2008

# Graph 2

# Physical inactivity is estimated to be up to contributes to nearly 2,500 deaths in Scotland annually, costing the NHS around £94 million


# load in libraries
library(tidyverse)
library(here)
library(lubridate)

bmi_2018 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(68, 63),
  year = c(2018, 2018)
)

bmi_2017 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(68, 63),
  year = c(2017, 2017)
)

bmi_2016 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(68, 61),
  year = c(2016, 2016)
)

bmi_2015 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(67, 62),
  year = c(2015, 2015)
)

bmi_2014 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(69, 61),
  year = c(2014, 2014)
)

bmi_2013 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(68, 61),
  year = c(2013, 2013)
)

bmi_2012 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(68, 60),
  year = c(2012, 2012)
)

bmi_2011 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(67, 60),
  year = c(2011, 2011)
)

bmi_2010 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(66, 62),
  year = c(2010, 2010)
)

bmi_2009 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(66, 61),
  year = c(2009, 2009)
)

bmi_2008 <- tibble(
  gender = c("Male", "Female"),
  BMI_25_and_over = c(63, 62),
  year = c(2008, 2008)
)

bmi_all <- rbind(bmi_2008, bmi_2009, bmi_2010, bmi_2011, bmi_2012, bmi_2013, 
                 bmi_2014, bmi_2015, bmi_2016, bmi_2017, bmi_2018) 

years <- unique(bmi_all$year)

# plot graph BMI
bmi_graph <- bmi_all %>% 
  group_by(gender) %>% 
  ggplot() +
  aes(x = year, y = BMI_25_and_over, col = gender) +
  geom_point() +
  geom_line() +
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
