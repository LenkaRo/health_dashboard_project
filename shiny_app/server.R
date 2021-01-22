library(shiny)
library(here)

# Define server logic required to eg draw a histogram
shinyServer(function(input, output) {
    
    ### setting up the reactive functionality, to get the results only after selecting filters and pressing action button
    ### improving efficiency of the code by applying the filter function only once if used multiple times
    # data_filtered <- eventReactive(input$update, {
    #     data %>% 
    #         filter( == input$something_from_UI)
    # })
    
    ### life expectancy graph 
    output$life_expectancy_graph <- renderPlot({
        
        here("r_scripts/life_expectancy.R")
        life_expectancy
        
    })
    
    
}
)