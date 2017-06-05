#
# Shiny Server for "Regression Model: Effect of Adding Observations"
#
# This is the user-interface definition of a Shiny web application that allows the
# user to add observations to a regression plot and see changes in real-time
# 
#

library(shiny)

xy <- function(val) {
        if (val == 0) return("NULL")
        format(round(val,1), nsmall = 1)
}

originalData <- subset(mtcars, select = c(hp, mpg))
originalModel <- lm(hp ~ mpg, data = originalData)

shinyServer(function(input, output) {
        
        initialize_data <- function() {
                ptlist <<- list(x = vector("numeric",0), y = vector("numeric",0))
                mtcarswpt <<- subset(mtcars, select = c(hp, mpg))
                clickvals <<- c(0,0)
        }
        
        initialize_data()
        
        replot <- function() {
                plot(mtcarswpt$mpg, mtcarswpt$hp, main =
                        "Horsepower vs. Miles-per-gallon", 
                        xlab = "MPG", ylab = "HP", bty = "n", pch = 16,
                        xlim = c(10, 35), ylim = c(50, 350))
                mtext("From R `mtcars` dataset")
                model1 <<- lm(hp ~ mpg, data = mtcarswpt)
                abline(model1, col = "red", lwd = 2)
                points(ptlist$x, ptlist$y, col = "red", pch = 16, cex = 1.5)
        }
        
        output$plot1 <- renderPlot({
                if (!v$clearpoints) {
                
                        if (!is.null(input$plot1_click)) {
                                clickvals[2] <<- input$plot1_click$y
                                clickvals[1] <<- input$plot1_click$x
                                ptlist$x <<- c(ptlist$x, clickvals[1])
                                ptlist$y <<- c(ptlist$y, clickvals[2])
                                mtcarswpt <<- data.frame(rbind(mtcarswpt,
                                                c(clickvals[2], clickvals[1])))
                        }
                }
                replot()
                if (input$showOriginal) {
                        abline(originalModel, lwd = 1)
                }
                isolate(v$clearpoints <- FALSE)
        })
        
        v <- reactiveValues(clearpoints = FALSE)
        
        observeEvent(input$button, {
                initialize_data()
                v$clearpoints <- TRUE
        })
        
        output$info_added_pt <- renderText({
                        
                clearpoints <- v$clearpoints # `v` triggers `renderText` on buttonpush
                click <- input$plot1_click # `plot1_click` triggers `renderText` on mouse-click
                
                paste0("MPG = ", xy(clickvals[1]), "\nHP = ", xy(clickvals[2]))
        })
        
        output$info_coefs <- renderText({
                
                clearpoints <- v$clearpoints # `v` triggers `renderText` on buttonpush
                click <- input$plot1_click # `plot1_click` triggers `renderText` on mouse-click
                
                cor_mtcars <- format(round(cor(mtcarswpt$hp, mtcarswpt$mpg),2), nsmall = 2)
                pval <- paste0(format(anova(model1)$`Pr(>F)`[[1]]*100, digits = 3), "%")
                paste0("Cor(HP, MPG) = ", cor_mtcars, "\nP-Value of MPG = ", pval)
        })
        
        output$info_equation <- renderText({
                
                clearpoints <- v$clearpoints # `v` triggers `renderText` on buttonpush
                click <- input$plot1_click # `plot1_click` triggers `renderText` on mouse-click
                
                intercept <- format(round(coef(model1)[[1]],1), nsmall = 1)
                MPG <- format(round(coef(model1)[[2]],2), nsmall = 2)
                paste0("HP = ", intercept, " + ", MPG, " * ", "MPG")
        })

        
})
