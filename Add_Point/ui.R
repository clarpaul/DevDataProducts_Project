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
  titlePanel("Regression model: Effect of adding observations"),
  
    # Show a plot
    mainPanel(
       h4("Click in plot area to add points to regression"),
       plotOutput("plot1", click = "plot1_click"),
       actionButton("button", "Clear plot"),
       h4("Coordinates of most recently added point"),
       verbatimTextOutput("infopts"),
       h4("Correlation and p-value"),
       verbatimTextOutput("infocoefs")
    )
  )
)
