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
# In 2017, the Scottish Government published a plan called A Healthier Future – Scotland's Diet and Healthy Weight Delivery Plan. The plan sets out a vision for everyone in Scotland to eat well and have a healthy weight.
#
# Diet, physical activity and sedentary behavior are strongly associated with BMI


# Graph - BMI in adults (16+), time series - 2008-2018
# 
# Data source: Scottish Health Survey-Scotland level data: a data cube column (Indicators of population health and related risk factors from the Scottish Health Survey (2008-2019))
#              available from: https://statistics.gov.scot/slice?dataset=http%3A%2F%2Fstatistics.gov.scot%2Fdata%2Fscottish-health-survey-scotland-level-data&http%3A%2F%2Fpurl.org%2Flinked-data%2Fcube%23measureType=http%3A%2F%2Fstatistics.gov.scot%2Fdef%2Fmeasure-properties%2Fpercent&http%3A%2F%2Fpurl.org%2Flinked-data%2Fsdmx%2F2009%2Fdimension%23refPeriod=http%3A%2F%2Freference.data.gov.uk%2Fid%2Fyear%2F2018&http%3A%2F%2Fstatistics.gov.scot%2Fdef%2Fdimension%2FscottishHealthSurveyIndicator=http%3A%2F%2Fstatistics.gov.scot%2Fdef%2Fconcept%2Fscottish-health-survey-indicator%2Foverweight-overweight-including-obese&http%3A%2F%2Fstatistics.gov.scot%2Fdef%2Fdimension%2Fsex=http%3A%2F%2Fstatistics.gov.scot%2Fdef%2Fconcept%2Fsex%2Fall
# 
# Resource: Scottish Health Survey 2018: main report - revised 2020, chapter 7 Obesity
#           available from: https://www.gov.scot/publications/scottish-health-survey-2018-volume-1-main-report/pages/62/
#
# We are looking at a graph showing Prevalence of overweight including obesity (BMI 25 and over) among adults aged 16 and over, further split by gender, 2008 to 2018
#
# In 2018, two thirds (65%) of adults were overweight, including 28% who were obese, with both these trends remaining stable since 2008
# A greater proportion of men were overweight or obese than women.
# This has considerable individual, social, and economic consequences, obesity continues to be a key priority and a major challenge for the Scottish government, the NHS and other public services.
# The cost to the health service in Scotland of overweight and obesity combined is estimated to be between £363 and £600 million (most of these costs are incurred because of associated conditions such as cardiovascular disease and type 2 diabetes, rather than direct costs of treating or managing overweight and obesity)

# load in libraries
library(tidyverse)
library(here)
library(lubridate)

overweight <- read_csv(here("data/priority_6/BMI/scottish_health_survey_tidy.csv")) 

years <- unique(overweight$date_code) %>% sort()

bmi_graph <- overweight %>% 
  ggplot() +
  aes(x = date_code, y = value, colour = sex) +
  geom_line(aes(group = sex)) +
  geom_point() +
  expand_limits(y = c(0, 80)) +
  theme_classic() +
  theme(legend.title = element_blank()) +
  scale_x_continuous(labels = years, breaks = years) +
  labs(
    x = "Survey Year",
    y = "Percentage",
    title = "Prevalence of overweight incl. obesity among adults aged 16 and over",
    subtitle = "(BMI 25 kg/m² and over)"
  )

# unique(overweight$scottish_health_survey_indicator)
