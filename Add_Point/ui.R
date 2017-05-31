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
  titlePanel("Regression Model: Effect of Adding Observations"),
  
    # Show a plot and related information
    mainPanel(
       h4("Instructions: Click inside plot area to add points to regression"),
       plotOutput("plot1", click = "plot1_click"),
       
       actionButton("button", "Clear added points"),
       
       # Information boxes
       
       h4("Coordinates of most recently added point"),
       verbatimTextOutput("info_added_pt"),
       
       h4("Equation of best fit line by least squares (including any added points)"),
       verbatimTextOutput("info_equation"),
       
       h4("Correlation and p-value (including any added points)"),
       verbatimTextOutput("info_coefs")
    )
  )
)
