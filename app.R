library(shiny)
library(shinythemes)
library(here)
library(tidyverse)
library(sf)
library(tmap)
library(shapefiles)
library(infer)
library(markdown)

source(here("r_scripts/word_cloud.R"))
source(here("r_scripts/life_expectancy.R"))
source(here("r_scripts/priority_2_ p1_bmi_script.R"))
source(here("r_scripts/bmi.R"))
source(here("r_scripts/exercise.R"))
source(here("r_scripts/map_asthma.R"))
source(here("r_scripts/priority_3_graph.R"))
source(here("r_scripts/priority_4_graph.R"))
source(here("r_scripts/asthma_area_graph_MF_script.R"))
source(here("r_scripts/asthma_line_deaths_by_gender_script.R"))
source(here("r_scripts/asthma_line_rate_by_gender_script.R"))
source(here("r_scripts/asthma_MF_boxplot_script.R"))
source(here("r_scripts/hypothesis_test.R"))


# Define UI for application that draws a presentation with three tabs (add text, graphs, action buttons etc)
ui <- (fluidPage(
  
  theme = shinytheme("flatly"),
  
  # Application title
  titlePanel("Public Health in Scotland"),
  
  tabsetPanel(
    tabPanel("Intro",
             
             # sidebarLayout(
             #     # sidebarPanel(
             #     # )    
             #     #      
             #     # mainPanel(
             #     # )         
             # )            
    ),
    
    tabPanel("Overview",
             
             sidebarLayout(
               sidebarPanel(
                 
                 selectInput("select_priority",
                             label = "Select Priority",
                             choices = c("Life Expectancy", "BMI in Children", "BMI in Adults", "Activity Levels of Adults", "Mental Health", "Smoking Levels")
                 ),
                 
                 br(),
                 # show word cloud
                 plotOutput("word_cloud")
                 
               ),
               
               mainPanel(
                 
                 # overview related graph
                 plotOutput("graph"),
                 
                 uiOutput("md_file_overview_tab")
                 
               )
             )
    ),
    
    tabPanel("Asthma",
             
             sidebarLayout(
               sidebarPanel(
                 
                 selectInput("select_indicator",
                             label = "Select Indicator",
                             choices = c("proportion", "stays", "rate")
                 ),
                 
                 hr(),
                 hr(),
                 
                 absolutePanel(top = 90, #left = 80,
                               style="z-index:500;", # legend over my map (map z = 400)
                               #tags$h3("map"),
                               sliderInput("year_slider",
                                           "Choose year range",
                                           min = min(map_and_data$discharge_fin_yr_end),
                                           max = max(map_and_data$discharge_fin_yr_end),
                                           value = range(map_and_data$discharge_fin_yr_end),
                                           step = 1,
                                           sep = "", #getting rid of the default "," separator (eg 1,234)
                                           width = "400px"
                               )
                 ),
                 
                 hr(),
                 hr(),
                 
                 # interactive map
                 tmapOutput("map", width = "100%", height = 600)
                 
               ),
               
               mainPanel(
                 
                 selectInput("select_topic",
                             label = "Select Topic",
                             choices = c("Asthma in proportion", "Death by gender", "Rate by gender", "Asthma by gender", "Hypothesis test - null distribution")
                 ),
                 
                 mainPanel(
                   
                   # asthma related graph
                   plotOutput("graph_2"),
                   
                   textOutput("text_with_graph_2"),
                   
                   uiOutput("md_file_asthma_tab")
                   
                 )
                 
               )
             )            
    )
  )
))


# Define server logic
server <- (function(input, output) {
  
  ### setting up the reactive functionality, to get the results only after selecting filters and pressing action button
  ### improving efficiency of the code by applying the filter function only once if used multiple times
  # data_filtered <- eventReactive(input$update, {
  #     data %>% 
  #         filter( == input$something_from_UI)
  # })
  
  ### widget - select priority for which to display a graph (Overview Tab)
  output$priority <- renderPrint({ input$select_priority })
  
  # plot word cloud
  output$word_cloud <- renderPlot({
    
    wordcloud(words = d$word, freq = d$freq, min.freq = 1,
              max.words=80, random.order=FALSE, rot.per=0.35, 
              colors=brewer.pal(8, "Dark2"))
  })
  
  output$graph <- renderPlot({
    
    if(input$select_priority=="Life Expectancy"){
      
      return(life_expectancy_graph)
    }
    
    if(input$select_priority=="BMI in Children"){
      
      return(p1_bmi_for_graph)
    }
    
    if(input$select_priority=="BMI in Adults"){
      
      return(bmi_graph)
    }
    
    if(input$select_priority=="Activity Levels of Adults"){
      
      return(physical_activity_graph)
    }
    
    if(input$select_priority=="Mental Health"){
      
      return(priority_3_graph)
    }
    
    if(input$select_priority=="Smoking Levels"){
      
      return(priority_4_graph)
    }
    
  })
  
  # plot thematic map based on selected input (Asthma Tab)
  output$map <- renderTmap({
    
    map_and_data <- map_and_data %>% 
      filter(discharge_fin_yr_end == input$year_slider)
    
    if (input$select_indicator == "proportion") {
      tm_shape(map_and_data) +
        tm_polygons("Value", id = "HBName", fill = "Value", title = "Proportion (%)") + # add polygons colored by the Value (percentage), display name of HB when hovering mouse over the map
        tmap_mode("view") # turn it into interactive (clickable) map, set tmap viewing mode to "view" = interactive
    }
    
    else if (input$select_indicator == "stays") {
      tm_shape(map_and_data) +
        tm_polygons("avg_stay", id = "HBName", fill = "avg_stay", title = "Average length of stay (days)") +
        tmap_mode("view")
    }

    else if (input$select_indicator == "rate") {
      tm_shape(map_and_data) +
        tm_polygons("avg_rate", id = "HBName", fill = "avg_rate", title = "Average rate (units)") +
        tmap_mode("view")
    }
  })
  
  
  ### widget - select topic for which to display a graph (Asthma Tab)
  output$asthma_topic <- renderPrint({ input$select_priority })
  
  output$graph_2 <- renderPlot({
    
    if(input$select_topic=="Asthma in proportion"){
      
      return(area_graph_asthma_data_graph)
    }
    
    if(input$select_topic=="Death by gender"){
      
      return(asthma_line_deaths_by_gender_graph)
    }
    
    if(input$select_topic=="Rate by gender"){
      
      return(asthma_line_rate_MF_BS_graph)
    }
    
    if(input$select_topic=="Asthma by gender"){
      
      return(stays_and_rates_2012_2019_graph)
    }
    
    if(input$select_topic=="Hypothesis test - null distribution"){
      
      return(null_distribution_viz)
    }
  })
  
  # description with the graphs in Overview tab
  output$md_file_overview_tab <- renderUI({
    file_overview <- switch(input$select_priority,
                   "Life Expectancy" = "descriptions/life_expectancy.md",
                   #"BMI in Children" = "descriptions/f.md",
                   #"BMI in Adults" = "descriptions/bmi_id_adults.md",
                   #"Activity Levels of Adults" = "descriptions/activity_levels_of_adults.md",
                   #"Mental Health" = "descriptions/i.md",
                   #"Smoking Levels" = "descriptions/j.md"
    )
    includeMarkdown(file_overview)
  })
  
  # description with the graphs in Asthma tab
  output$md_file_asthma_tab <- renderUI({
    file_asthma <- switch(input$select_topic,
                   #"Asthma in proportion" = "descriptions/a.md",
                   #"Death by gender" = "descriptions/b.md",
                   #"Rate by gender" = "descriptions/c.md",
                   #"Asthma by gender" = "descriptions/d.md",
                   "Hypothesis test - null distribution" = "descriptions/null_hypothesis.md"
    )
    includeMarkdown(file_asthma)
  })
})

shinyApp(ui = ui, server = server)
