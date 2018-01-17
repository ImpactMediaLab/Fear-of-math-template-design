# Template for BIOMAAP educational modules
# January 15th, 2018
# Created by Impact Media Lab

######### Load required packages

library(shiny)
library(shinydashboard)

source('ShinyAssessment.R')
math.items <- as.data.frame(read.csv('items.csv', stringsAsFactors=FALSE))


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

  

#####
  
  
    # Save the most recent assessment results to display
    assmt.results <- reactiveValues(
      math = logical()
    )
    
    # This function will be called when the assessment is completed.
    saveResults <- function(results) {
      assmt.results$math <- results == math.items$Answer
    }
    
    
    
    # Provide some basic feedback to students
    output$math.results <- renderText({
      txt <- ''
      if(length(assmt.results$math) > 0) {
        txt <- paste0('You got ', sum(assmt.results$math, na.rm=TRUE),
                      ' of ', length(assmt.results$math), ' items correct.')
      } else {
        txt <- 'No results found. Please complete the statistics assessment.'
      }
      return(txt)
    })
    
    
    
    # Multiple choice test example
    test <- ShinyAssessment(input, output, session,
                            name = 'Statistics',
                            item.stems = math.items$Stem,
                            item.choices = math.items[,c(4:8)],
                            callback = saveResults,
                            start.label = 'Start this thing',
                            itemsPerPage = 8,
                            inline = FALSE)
    
    
    
    output$ui <- renderUI({
      if(SHOW_ASSESSMENT$show) { # The assessment will take over the entire page.
        fluidPage(width = 12, uiOutput(SHOW_ASSESSMENT$assessment))
      } else { # Put other ui components here
        fluidPage(	 
          
          fluidRow(
            img(src ="placeholder.png", width = 400, style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:40px; margin-bottom:10px")
            ),
          
          br(),
          tags$h1("Take the Mindset Assessment to Learn About Your Mindset", align = "center"),
          br(),
          
          tags$h2("In a growth mindset, people believe that their most basic abilities can be 
                  developed through dedication and hard work — brains and talent are just the 
                  starting point. This view creates a love of learning and a resilience that is 
                  essential for great accomplishment"),
          tags$h2("- Carol Dweck"),
          br(),
          p("Although we’d like to always have a growth mindset, the reality is that we can 
            only be on a journey to a growth mindset. The goal is to recognize fixed 
            mindset elements in ourselves and then reflect on feedback and strategies 
            for how to improve. The Mindset Assessment is a quick diagnostic tool 
            drawn from research-validated measures for people age 12 and over to use 
            to assess their mindsets."),
          br(),
          uiOutput(test$button.name),
          tags$h2("Take the survey", align="center"),
          fluidRow(
            img(src ="play-button.png", width = 100, style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:10px; margin-bottom:0px")
            ),
          
          br()
          
          )
        
      }
    })
  
  
  
  
  
  
  
  
  
######
})