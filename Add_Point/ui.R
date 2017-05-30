#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Interactive plot"),
  
    # Show a plot
    mainPanel(
       h4("Click in the plotting area to add a point to the regression"),
       plotOutput("plot1", click = "plot1_click"),
       h4("Coordinates of added point"),
       verbatimTextOutput("info")
    )
  )
)
