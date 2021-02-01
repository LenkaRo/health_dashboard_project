# Choropleth map description

- Temporal data is simply data that represents a state in time
- Geographic data or geospatial data, refers to data and information that has explicit or implicit association with a location relative to Earth
- Demographic data is statistical data collected about the characteristics of the population, e.g. age, gender and income

I will talk you through some of the asthma related findings, displayed in the visualization feature.

Delivery of frontline healthcare services in Scotland are the responsibility of 14 regional National Health Service Boards that report to the Scottish Government.
These align with the combined area of each Local Authority that they serve.

We are looking at a spatial and temporal choropleth map of Scotland divided by the HB.
The GeoSpatial vector data, stored in a form of shape file, were used to outline the HB boundary lines as defined by Ordnance Survey. The data were obtained from the spatialdata.gov.scot website where are freely available to the public use.
Sadly, as of now, there is no geometry coordinates available for 4 out of 14 HB. This fact only means that these missing HBs are not displayed on the interactive map. It should be noted, it is just a visual absence that has NO effect on the presented analyses and graphs!

Each of the HB is colored in proportion to a statistical variable that represents an aggregate summary of a demographic characteristic within the area.

Using this drop down menu, you can specify which Indicator you want to get displayed. You can also narrow the year range to anytime between 2012 and 2019, inclusively, to obtain the aggregate summaries. The data were derived from the collection of documents relating to the Scottish Health Survey in 2019 and its supplementary tables. We have particularly focused on the Asthma data.

There are the three indicators that can be displayed on the interactive map related to each HB:

* Prevalence of Self-reported Doctor diagnosed asthma in adults aged 16 and over. This indicator has not changed significantly since 2012, sitting steadily at 17% level. The difference is seen between the most and the least deprived areas thought. Adults living in the most deprived quintile had a higher prevalence (21%) of doctor-diagnosed asthma than those in the other four quintiles (14-18%).
* Next Indicator - the Hospital stays across all ages is an Indicator that gives the total number of hospital stays related to Asthma diagnosis in each of the HB. 
* Finally, Hospital stay rate Indicator that gives the number of hospital stay rate per 100,000 population for each NHS Board of residence. In 2019, Fife showed the highest proportional figure with nearly 190 days of hospital stay rate per 100,000 population


# Hypothesis
* Based on the nature of the data collection of the underlying data in our analysis, we do not work with the iformation on the whole population. We technically only have access to the sample data. 

* Our question of interest here is: Is there a significant difference between means of the rates in each patient gender?

* So basically, we are interested in a hypothesis about the difference in population means μ1−μ2

* We set the conventional significance level to α=0.05 and established our Naugh and alternative hypotheses as one-tailed test of significance:

* Under H0 - the gender of a patient has no bearing on the rate, that means the gender and rate are independent. 
(In other words, there is no difference between the two groups)

* We calculate average rate across all 14 HB for both genders and using a box plot, we visualize the distribution of our two independent samples of asthma rates observed between years 2012 and 2019 - for females and males. Females are on the left, males on the right.

* We already see there is an indication that Female asthma rates tend to be somewhat higher on average.

* The exact sample means for each gender came to 126 for Females and 86.2 for Males.

* We checked whether this difference in distributions could be down to sampling variation (it means, it may have occurred ‘by chance’)! OR whether it really is a statistically significant difference. Let's perform our hypothesis test

* We generate null distribution by permutation and calculate observed statistics which came to 39.4

* Here you can see the visualization of our null distribution

* We see from the null distribution visualisation, that the observed statistic is passed the edge of our null distribution so there would be a very very small probability of getting a more extreme value than ours under H0

* We conclude that we have found enough evidence in our data to suggest that the average rate in Females is statistically significantly greater than in Males
