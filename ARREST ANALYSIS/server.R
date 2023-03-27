

#adding the server function 

function(input, output, session){
    #structure
    output$structure <- renderPrint(
      #getting the struture of my data
      
      my_data %>% 
        str()
    )
    
  #summary
    output$summary <- renderPrint(
      #summary stats 
      
      my_data %>% 
        summary()
    )
    
  
  #datatable
    output$dataT <- renderDataTable(
      my_data
    )
    
 #stacked histogram and boxplot
    output$histplot <- renderPlotly({
      
      p1 =  my_data %>% 
        plot_ly() %>% 
        add_histogram(~get(input$var1)) %>% 
        layout(xaxis = list(title = input$var1))
      
      
      #box plot
      p2 = my_data %>% 
        plot_ly() %>% 
        add_boxplot(~get(input$var1)) %>% 
        layout(yaxis = list(showticklabels = F))
      
      #using the stack plot to place each plot on each other 
      
      subplot(p2, p1, nrows = 2, shareX = TRUE) %>% 
        hide_legend() %>% 
        layout(title = "Distribution chart - Histogram and Boxpplot",
               yaxis = list(title = "Frequency")) 
      
    })
    
#scatter
    
    output$scatter <- renderPlotly({
      # ceating scatter plot for relationship using ggplot 
      p = my_data %>% 
        ggplot(aes(x = get(input$var3), y = get(input$var4)))+
        geom_point()+
        geom_smooth(method = input$fit )+
        labs(title = paste("Relationship between",  input$var3, "and", input$var3, "Arrests"),
             x = input$var3,
             Y = input$var4)+
        theme(plot.title = element_textbox_simple(size = 10, halign = 0.5))
        ggplotly(p)
      })
    
    output$cor <- renderPlotly({
     my_df <- my_data %>% 
       select(-states)
      
     #compute a correllation matrix
     corr <- round(cor(my_df), 1)
     
       p.mat <- cor_pmat(my_df)
      
      corr.plot <- ggcorrplot(
        corr, 
        hc.order = TRUE,
        lab = TRUE,
        outline.col = "white",
        p.mat = p.mat
      )
      
      ggplotly(corr.plot)
      
    })
    
    output$bar <- renderPlotly({
      my_data %>% 
        plot_ly() %>% 
        add_bars(x = ~states, y = ~get(input$var2)) %>% 
        layout(title = paste("Statewise Arrests for ", input$var2),
               xaxis = list(title  = "State"),
               yaxis = list(title = paste(input$var2, " Arrest per 100,000 residents")))
    })
    
    output$head1 <- renderText(
      paste("5 states with high rate of ", input$var2, "Arrest")
    )
    
    output$head2 <- renderText(
      paste("5 states with low rate of ", input$var2, "Arrest")
    )
    
    # rendering table with 5 states with high rrest for specifi crime type
    
    output$top5 <- renderTable({
      my_data %>% 
        select(states, input$var2) %>% 
        arrange(desc(get(input$var2))) %>% 
        head(5)
    })
    
    # rendering table with 5 states with low rrest for specifi crime type
    
    output$low5 <- renderTable({
      my_data %>% 
        select(states, input$var2) %>% 
        arrange(get(input$var2)) %>% 
        head(5)
    })
    
    output$map_plot <- renderPlot({
      new_join %>% 
        ggplot(aes(x = long, y = lat, fill = get(input$crimetype), group = group))+
        geom_polygon(color = "black", size = 0.4)+
        scale_fill_gradient(low = "#73A5c6", high = "#001B3A", name = paste(input$crimetype))+
        theme_void()+
        labs(title = paste("Choropleth map of", input$crimetype, "Arrest per 1000,000 resident by states"))+
        theme(
          plot.title = element_textbox_simple(face = "bold",
                                              size = 18,
                                              halign = 0.5),
          legend.position = c(0.2, 0.1),
          legend.direction = "horizontal"
        )+
        geom_text(aes(x = x, y = y, label = abb), size = 4, color = "white")
    })
}
