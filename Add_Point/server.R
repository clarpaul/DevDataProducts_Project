#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

xy <- function(val) {
        if (val == 0) return("NULL")
        round(val,1)
}

shinyServer(function(input, output) {
        # Note suggestion from post for adding multiple points
        # ptlist <- list(x = vector("numeric",0), y = vector("numeric",0))
        mtcarswpt <- subset(mtcars, select = c(hp, mpg))
        clickvals <- c(0,0)
        output$plot1 <- renderPlot({
                if (!is.null(input$plot1_click)) {
                        data(mtcars)
                        mtcarswpt <<- subset(mtcars, select = c(hp, mpg))
                        clickvals[2] <<- input$plot1_click$y
                        clickvals[1] <<- input$plot1_click$x
                        # Note suggestion from post
                        # ptlist$x <<- c(ptlist$x, clickvals[1])
                        # ptlist$y <<- c(ptlist$y, clickvals[2])
                        mtcarswpt <<- data.frame(rbind(mtcarswpt,
                                                c(clickvals[2], clickvals[1])))
                }
                plot(mtcarswpt$mpg, mtcarswpt$hp, xlab = "Miles Per Gallon", 
                     ylab = "Horsepower", bty = "n", pch = 16,
                     xlim = c(10, 35), ylim = c(50, 350))
                model1 <- lm(hp ~ mpg, data = mtcarswpt)
                abline(model1, col = "red", lwd = 2)
                points(clickvals[1], clickvals[2] , col = "blue", pch = 16, cex = 1.5)
        })
        
        output$info <- renderText({
                        click <- input$plot1_click # triggers `renderText`` to execute on click
                        paste0("MPG = ", xy(clickvals[1]), "\nHP = ", xy(clickvals[2]))
        })
        
        
})
