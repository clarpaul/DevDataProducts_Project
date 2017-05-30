#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyServer(function(input, output) {
        data(mtcars)
        mtcarswpt <- subset(mtcars, select = c(hp, mpg))
        clickvals <- c(0,0)
        output$plot1 <- renderPlot({
                if (!is.null(input$plot1_click)) {
                        data(mtcars)
                        mtcarswpt <- subset(mtcars, select = c(hp, mpg))
                        set <- function() {
                                click_y <- input$plot1_click$y
                                click_x <- input$plot1_click$x
                                mtcarswpt <- data.frame(rbind(mtcarswpt,
                                                        c(click_y, click_x)))
                                function() {
                                        c(click_x, click_y)
                                }
                        }
                        clickvals <- set()
                }
                plot(mtcarswpt$mpg, mtcarswpt$hp, xlab = "Miles Per Gallon", 
                     ylab = "Horsepower", bty = "n", pch = 16,
                     xlim = c(10, 35), ylim = c(50, 350))
                model1 <- lm(hp ~ mpg, data = mtcarswpt)
                abline(model1, col = "red", lwd = 2)
                points(clickvals[1], clickvals[2] , col = "blue", pch = 16, cex = 2)
                if (!is.null(input$plot1_click)) {

                        
                }
        })
        
        output$info <- renderText({
                if (!is.null(input$plot1_click)) {
                        paste0("x = ", round(input$plot1_click$x, 1), "\ny = ", round(input$plot1_click$y, 1))
                } else {
                        paste0("x = ", "\ny = ")
                }
        })
        
        
})
