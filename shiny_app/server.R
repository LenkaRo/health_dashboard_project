# Define server logic
shinyServer(function(input, output) {
    
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