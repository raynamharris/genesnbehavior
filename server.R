#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)


shinyServer(function(input, output) {
   
  output$behaviorplot <- renderPlot({
  
    sup1 %>%
      dplyr::group_by(treatment, trial, trialNum) %>%
      dplyr::summarise(value = mean(!!input$variable), 
                       se = sd(!!input$variable)/sqrt(length(!!input$variable)))  %>%
      ggplot(aes(x= trialNum, y=value, color=treatment)) + 
      geom_errorbar(aes(ymin=value-se, ymax=value+se, color=treatment), width=.1) +
      geom_line() +
      geom_point(size = 2) +
      labs(y = input$variable) +
      scale_x_continuous(name= "trial", 
                         breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9),
                         labels = c( "P", "T1", "T2", "T3",
                                     "Rt", "T4", "T5", "T6", "Rn")) +
      scale_alpha_continuous( breaks = c(1, 2, 3)) +
      theme_minimal(base_size = 16) +
      scale_color_manual(values = allcolors,
                         name  = NULL,
                         labels = levelstreatmentlegend)  +
      theme(legend.position = "bottom") 
  })
  
 
  
})
