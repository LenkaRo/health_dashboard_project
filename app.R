library(shiny)
library(shinythemes)
library(here)
library(tidyverse)
library(sf)
library(tmap)
library(rmapshaper)
library(leaflet)
library(shapefiles)
library(rgdal)

source(here("r_scripts/life_expectancy.R"))
source(here("r_scripts/priority_2_ p1_bmi_script.R"))
source(here("r_scripts/bmi.R"))
source(here("r_scripts/exercise.R"))
source(here("r_scripts/map_asthma.R"))


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
                             choices = c("Life Expectancy", "BMI in Children", "BMI in Adults", "Activity Levels of Adults")
                 )
               ),
               
               mainPanel(
                 #uiOutput('plot')
                 #eg. Show a plot of the Life Expectancy in Scotland
                 plotOutput("graph")
                 
               )
             )
    ),
    
    tabPanel("Asthma",
             
             sidebarLayout(
               sidebarPanel(
                 
                 selectInput("select",
                             label = "Select",
                             choices = c("a", "b", "c")
                 )
               ),
               
               mainPanel(
                 
                 tmapOutput("map", width = "50%", height = 400)
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
  
  ### widget - select priority for which to display a graph
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
    
  })
  
  output$map <- renderTmap({
    
    # create choropleth map with tmap - has interactive features (using tmap to turn it into interactive JavaScript map (zoom, click and display the data))
    tm_shape(map_and_data) +
      tm_polygons("Value", id = "HBName", fill = "Value", title = "Percentage") + # add polygons colored by the Value (percentage), display name of HB when hovering mouse over the map
      tmap_mode("view")
  })
})

shinyApp(ui = ui, server = server)
