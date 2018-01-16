# Template for BIOMAAP educational modules
# January 15th, 2018
# Created by Impact Media Lab

######### Load required packages

library(shiny)
library(shinydashboard)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
     })
  
  ######### Info boxes used in the module
  
  output$progressBox <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple"
    )
  })
  output$approvalBox <- renderInfoBox({
    infoBox(
      "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow"
    )
  })
  
  # Same as above, but with fill=TRUE
  output$progressBox2 <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple", fill = TRUE
    )
  })
  output$approvalBox2 <- renderInfoBox({
    infoBox(
      "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow", fill = TRUE
    )
  })
    
  ######### Images used in the module
  
  output$BIOMAAPlogo_photo <- renderImage({
    list(
      src = "www/BioMAAP_logo3.png",
      contentType = "image/png",
      alt = "Face"
    )}, deleteFile = FALSE)
  
  output$math_anxiety_photo <- renderImage({
    list(
      src = "www/math_anxiety.png",
      contentType = "image/png",
      alt = "Face"
    )}, deleteFile = FALSE)
  
  output$looking_hard <- renderImage({
    list(
      src = "www/looking_hard_at_data.png",
      contentType = "image/png",
      alt = "Face"
    )}, deleteFile = FALSE)
})
  

