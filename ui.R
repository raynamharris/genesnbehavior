#
# This is the user-interface definition of a Shiny web application. 
# You can run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Genes and Behavior"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      p("This Shiny App was built to explore the data collected 
        to better understand how gene expression
        in three subfields of the male mouse hippocampus changes 
        in response to active place avoidance traning."),
      strong("Experimental design"),
      img(src='fig-1a.png', align = "center", width = 200),
      p(" "),
      varSelectInput("variable", "Behavioral estimate:",
                     behaviors, selected = "MaxTimeAvoid")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      
      #h4("static figure 1"),
      h4("Interactively explore the relationship between behavior and 
         gene expression in the mouse hippocampus"),
      plotOutput("behaviorplot"),
      plotOutput("PCAplot")
    )
  )
))
