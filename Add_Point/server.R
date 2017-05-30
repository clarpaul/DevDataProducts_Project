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
        
        output$plot1 <- renderPlot({
                data(mtcars)
                mtcarswpt <- subset(mtcars, select = c(hp, mpg))
                if (!is.null(input$plot1_click)) {
                                mtcarswpt <- data.frame(rbind(mtcarswpt,
                                        c(input$plot1_click$y, input$plot1_click$x)))
                }
                plot(mtcarswpt$mpg, mtcarswpt$hp, xlab = "Miles Per Gallon", 
                     ylab = "Horsepower", bty = "n", pch = 16,
                     xlim = c(10, 35), ylim = c(50, 350))
                model1 <- lm(hp ~ mpg, data = mtcarswpt)
                abline(model1, col = "red", lwd = 2)
                if (!is.null(input$plot1_click)) {
                        points(input$plot1_click$x, input$plot1_click$y , col = "blue", pch = 16, cex = 2)
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
