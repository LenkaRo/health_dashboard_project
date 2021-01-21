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
                    # eg. a Sidebar with a slider input for number of bins
                    # sliderInput("bins",
                    #             "Number of bins:",
                    #             min = 1,
                    #             max = 50,
                    #             value = 30)
                )

                mainPanel(
                    # eg. Show a plot of the Life Expectancy in Scotland
                    plotOutput("life_expectancy_graph")
                )
            )
        ),
        
        tabPanel("Topic to be agreed",
                 
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


