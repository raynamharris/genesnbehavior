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
library(cowplot)


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
      labs(y = input$variable, 
           subtitle = "Changes in learning, memory, and activity over time.") +
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
  
  output$PCAplot <- renderPlot({
    
    a <- sup3 %>%
      ggplot(aes(y= !!input$variable, 
                 x=PC1)) +
      geom_point(aes(color=treatment)) +
      geom_smooth(method = "lm", aes(color = treatment2)) +
      theme_minimal(base_size = 16) +
      scale_color_manual(values = allcolors) +
      theme(legend.position = "bottom") +
      labs(x = "PC1: estimate of memory",
           subtitle = "Analyais of principle components (PC) 1 and 2")
    
    b <- sup3 %>%
      ggplot(aes(y= !!input$variable, 
                 x=PC2)) +
      geom_point(aes(color=treatment)) +
      geom_smooth(method = "lm", aes(color = treatment2)) +
      theme_minimal(base_size = 16) +
      scale_color_manual(values = allcolors) +
      theme(legend.position = "none")+
      labs(x = "PC2: estimate of activity",
           subtitle = "")
    
    legend <- get_legend(a)
    
    ab <- plot_grid(a + theme(legend.position = "none"),
                    b)
    
    plot_grid(ab,legend, ncol = 1, rel_heights = c(1,0.1), rel_widths = c(1.1,1))
    
    
  })  
  
})
