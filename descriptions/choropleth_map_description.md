# Choropleth map description

- Temporal data is simply data that represents a state in time
- Geographic data or geospatial data, refers to data and information that has explicit or implicit association with a location relative to Earth
- Demographic data is statistical data collected about the characteristics of the population, e.g. age, gender and income

Delivery of frontline healthcare services in Scotland are the responsibility of 14 regional National Health Service Boards that report to the Scottish Government.
These align with the combined area of each Local Authority that they serve.

We are looking at a spatial and temporal choropleth map of Scotland, that is divided by the HB.
The GeoSpatial vector data, stored in a form of shape file, were used to outline the HB boundary lines as defined by Ordnance Survey. The data were obtained from the spatialdata.gov.scot website and are freely available to the public use.
Sadly, as of now, there is no geometry coordinates available for 4 out of 14 HB. This fact only means that these missing HBs are not displayed on the interactive map. It should be noted, it is just a visual absence that has NO effect on the presented analyses and graphs!

Each of the HB is colored in proportion to a statistical variable that represents an aggregate summary of a demographic characteristic within the area.

Using this drop down menu, you can specify which Indicator you want to get displayed. You can also narrow the year range to anytime between 2012 and 2019, inclusively, to obtain the aggregate summaries; You can also just focus on any particular year alone. The data were derived from the collection of documents relating to the Scottish Health Survey in 2019 and its supplementary tables. We have particularly focused on the Asthma data.

There are the three indicators
* Prevalence of Self-reported Doctor diagnosed asthma in adults aged 16 and over. This indicator has not changed significantly since 2012, sitting steadily at 17%. The difference is seen between the most and the least deprived areas thought. Adults living in the most deprived quintile had a higher prevalence (21%) of doctor-diagnosed asthma than those in the other four quintiles (14-18%).
* Hospital stays across all ages is an Indicator that gives the total number of hospital stays related to Asthma diagnosis in each of the HB. 
* Finally, Hospital stay rate Indicator that gives the number of hospital stay rate per 100,000 population for each NHS Board of residence. In 2019, Fife showed the highest proportional figure with nearly 190 days of hospital stay rate per 100,000 population.