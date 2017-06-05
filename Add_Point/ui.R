#
# Shiny UI for "Regression Model: Effect of Adding Observations"
#
# This is the user-interface definition of a Shiny web application that allows the
# user to add observations to a regression model and see changes in real-time
# 
#

library(shiny)

# Define UI for application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Regression Line: Effect of Adding Observations"),
  
    # Show a plot and related information
       sidebarLayout(
          sidebarPanel(  
            # INSTRUCTIONS
            span(h4("Instructions:"), style = "color:blue"), 
            div("1. Click in plot area to add points to regression and see how the best-fit line changes."),
            div("2. Use button to clear added points and start over"),
       
            
          
            # INFORMATION BOXES
            h4("Coordinates of most recently added point"),
            verbatimTextOutput("info_added_pt"),
            h4("Equation: least squares best fit line"),
            verbatimTextOutput("info_equation"),
            h4("Correlation and p-value"),
            verbatimTextOutput("info_coefs")
          ),
          mainPanel(
            # PLOT
            plotOutput("plot1", click = "plot1_click"),
            
            # BUTTON: CLEAR AND START OVER
            br(),
            actionButton("button", span("Clear added points", style = "color:blue")),
       
            # CHECKBOX: SHOW ORIGINAL TREND LINE
            span(
              checkboxInput("showOriginal", "Show Original Trend Line", value = TRUE),
              style = "color:blue"
            )
          )
       )
  )
)
