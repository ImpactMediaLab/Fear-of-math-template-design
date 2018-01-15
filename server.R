library(shiny)
library(shinydashboard)
library(scales)
#library(MASS)
#data(beav1)


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  
     })
    
    
})

