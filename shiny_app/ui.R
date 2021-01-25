library(shiny)
library(shinythemes)
library(ggthemes)
library(tidyverse)

# Define UI for application that draws a presentation with three tabs (add text, graphs, action buttons etc)
shinyUI(fluidPage(
    
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
                 
            # sidebarLayout(
            #     sidebarPanel(
            #     )    
            #          
            #     mainPanel(
            #     )         
            # )            
        )
    )
))


