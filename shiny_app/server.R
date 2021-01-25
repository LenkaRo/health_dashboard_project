library(shiny)
library(here)

source(here("r_scripts/life_expectancy.R"))
source(here("r_scripts/priority_2_ p1_bmi_script.R"))
source(here("r_scripts/bmi.R"))
source(here("r_scripts/exercise.R"))

# Define server logic required to eg draw a histogram
shinyServer(function(input, output) {
    
    ### setting up the reactive functionality, to get the results only after selecting filters and pressing action button
    ### improving efficiency of the code by applying the filter function only once if used multiple times
    # data_filtered <- eventReactive(input$update, {
    #     data %>% 
    #         filter( == input$something_from_UI)
    # })
    
    
    
#     ### life expectancy graph 
#     output$life_expectancy_graph <- renderPlot({
# 
#         source(here("r_scripts/life_expectancy.R"))
#         life_expectancy
# 
#     })
#     
#     output$priority_2_p1_bmi_graph <- renderPlot({
#         
#         source(here("r_scripts/priority_2_ p1_bmi_script.R"))
#         p1_bmi_for_graph
#         
#     })
#     
#     output$bmi_graph <- renderPlot({
#         
#         source(here("r_scripts/bmi.R"))
#         bmi_graph
#         
#     })
#     
#     output$physical_activity_graph <- renderPlot({
#         
#         source(here("r_scripts/exercise.R"))
#         physical_activity_graph
#         
#     })
#     
#     
# }
# )
 ### select widget - select priority for which to display a graph
output$priority <- renderPrint({ input$select_priority })




output$graph <- renderPlot({
    
    if(input$select_priority=="Life Expectancy"){
         
            
            
            return(life_expectancy)
            
    
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
})