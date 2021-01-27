library(shiny)
library(shinythemes)
library(here)
library(tidyverse)
library(sf)
library(tmap)
library(shapefiles)
library(infer)
library(markdown)

source(here("r_scripts/life_expectancy.R"))
source(here("r_scripts/priority_2_ p1_bmi_script.R"))
source(here("r_scripts/bmi.R"))
source(here("r_scripts/exercise.R"))
source(here("r_scripts/map_asthma.R"))
source(here("r_scripts/priority_3_graph.R"))
source(here("r_scripts/priority_4_graph.R"))
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
                 )
               ),
               
               mainPanel(
                 
                 # overview related graph
                 plotOutput("graph")
                 
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
                             choices = c("a", "b", "c", "Hypothesis test - null distribution")
                 ),
                 
                 mainPanel(
                   
                   # asthma related graph
                   plotOutput("graph_2"),
                   
                   textOutput("text_with_graph_2"),
                   
                   uiOutput("md_file")
                   
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
    
    if(input$select_topic=="a"){
      
      return(doug_1_graph)
    }
    
    if(input$select_topic=="b"){
      
      return(doug_2_graph)
    }
    
    if(input$select_topic=="c"){
      
      return(doug_3_graph)
    }
    
    if(input$select_topic=="Hypothesis test - null distribution"){
      
      return(null_distribution_viz)
    }
  })
  
  #output$md_file <- renderPrint({ "descriptions/null_hypothesis.md" })
  
  output$md_file <- renderUI({
    file <- switch(input$select_topic,
                   #"a" = "descriptions/a.md",
                   #"b" = "descriptions/b.md",
                   #"c" = "descriptions/c.md",
                   "Hypothesis test - null distribution" = "descriptions/null_hypothesis.md"
    )
    includeMarkdown(file)
  })
  
  
  # output$text_with_graph_2 <- renderText({
  #   
  #   if(input$select_topic=="Hypothesis test - null distribution"){
  #   
  #     text <- paste(readLines("descriptions/null_hypothesis.txt"), collapse = "\n")
  #     return(text)
  #   }
  #   
  # })
})

shinyApp(ui = ui, server = server)
