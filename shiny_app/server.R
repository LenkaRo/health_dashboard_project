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
    
    ### select widget - select priority for which to display a graph
    output$priority <- renderPrint({ input$select_priority })
    
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


output$plot <- renderUI({
    
    if(input$select_priority=="Life Expectancy"){
        output$life_expectancy_graph <- renderPlot({
            
            source(here("r_scripts/life_expectancy.R"))
            life_expectancy
            
        })
    }
    
    else if(input$select_priority=="BMI in Children"){
        output$priority_2_p1_bmi_graph <- renderPlot({
            
            source(here("r_scripts/priority_2_ p1_bmi_script.R"))
            p1_bmi_for_graph
            
        })
    }
    
    else if(input$select_priority=="BMI in Adults"){
        output$bmi_graph <- renderPlot({
            
            source(here("r_scripts/bmi.R"))
            bmi_graph
            
        })
    }
    
    else if(input$select_priority=="Activity Levels of Adults"){
        output$physical_activity_graph <- renderPlot({
            
            source(here("r_scripts/exercise.R"))
            physical_activity_graph
            
        })
    }
    
})