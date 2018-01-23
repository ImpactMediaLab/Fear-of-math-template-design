# Template for BIOMAAP educational modules
# January 15th, 2018
# Created by Impact Media Lab

######### Load required packages

library(shiny)
library(shinydashboard)

source('ShinyAssessment.R')
source('ShinyAssessment2.R')
(remove(SHOW_ASSESSMENT))
remove(SHOW_ASSESSMENT2)

math.items <- as.data.frame(read.csv('items.csv', stringsAsFactors=FALSE))
math.items2 <- as.data.frame(read.csv('quiz1.csv', stringsAsFactors=FALSE))


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
     })
  
######### Images used in the module
  
  output$BIOMAAPlogo_photo <- renderImage({
    list(
      src = "www/BioMAAP_logo3.png",
      contentType = "image/png",
      alt = "Face"
    )}, deleteFile = FALSE)
  

######### Info boxes on the RESULTS page
  
  output$assessmentBox <- renderInfoBox({
    infoBox(
      "Survey Assessment", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple", fill = F)
  })
  output$quizBox <- renderInfoBox({
    infoBox(
      "Quiz Score", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "purple", fill = F)
  })
  output$feedbackBox <- renderInfoBox({
    infoBox(
      "Mindset Feedback", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple", fill = F)
  })
  
  
######### BUILDING THE DYNAMIC MINDSET ASSESSMENT #########
  
    # Save the most recent assessment results to display
    assmt.results <- reactiveValues(
      math = logical()
    )
  
  assmt.results2 <- reactiveValues(
    math = logical()
  )  
    
    # This function will be called when the assessment is completed.
    saveResults <- function(results) {
      assmt.results$math <- results == math.items$Answer
    }
    
    saveResults2 <- function(results) {
      assmt.results2$math <- results == math.items2$Answer
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
                            start.label = 'Start the Assessment',
                            width="100%",
                            #background.color="purple",
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
          
          tags$h1("Take the Mindset Assessment to Learn About Your Mindset", align = "center"),
          
          tags$h2("In a growth mindset, people believe that their most basic abilities can be 
                  developed through dedication and hard work — brains and talent are just the 
                  starting point. This view creates a love of learning and a resilience that is 
                  essential for great accomplishment."),
          tags$h2("- Carol Dweck"),
          br(),
          fluidRow(img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")),
          
          p("Although we’d like to always have a growth mindset, the reality is that we can 
            only be on a journey to a growth mindset. The goal is to recognize fixed 
            mindset elements in ourselves and then reflect on feedback and strategies 
            for how to improve. The Mindset Assessment* is a quick diagnostic tool, 
            drawn from research-validated measures for people age 12 and over to use 
            to assess their mindsets."),

          uiOutput(test$button.name, align="center"),
          tags$h3("* This assessment has been modified from",span(tags$a(href="http://blog.mindsetworks.com/what-s-my-mindset", "Mindset Works"))),
          br()
          )
      }
    })
    
    # Multiple choice test example
    test2 <- ShinyAssessment2(input, output, session,
                            name = 'Statistics2',
                            item.stems = math.items2$Stem,
                            item.choices = math.items2[,c(4:8)],
                            callback = saveResults2,
                            start.label = 'Start the Assessment',
                            width="100%",
                            #background.color="purple",
                            itemsPerPage = 8,
                            inline = FALSE)
    
    output$ui2 <- renderUI({
      if(SHOW_ASSESSMENT2$show) { # The assessment will take over the entire page.
        fluidPage(width = 12, uiOutput(SHOW_ASSESSMENT2$assessment))
      } else { # Put other ui components here
        fluidPage(	 
          
          # QUIZ ON TOPIC PAGE
          tabItem(tabName = "quiz",
                  fluidRow(
                    img(src ="placeholder.png", width = 400, style="display: block; margin-left: auto; 
                        margin-right: auto; margin-top:40px; margin-bottom:10px")
                    ),
                  
                  tags$h1("Take the Quiz to Test Your Comprehension", align = "center"),
                  
                  p("Our mindsets exist on a continuum from fixed to growth, and although 
                    we’d like to always have a growth mindset, the reality is that we can 
                    only be on a journey to a growth mindset. The goal is to recognize fixed 
                    mindset elements in ourselves and then reflect on feedback and strategies 
                    for how to improve. The Mindset Assessment is a quick diagnostic tool 
                    drawn from research-validated measures for people age 12 and over to use 
                    to assess their mindsets. It has been used in many studies to show how 
                    mindsets can change, and can be used by you and your students to identify 
                    areas in which you can work toward a growth mindset. You will be delivered
                    personalized feedback after you submit the assessment."),
                  
                  fluidRow(
                    img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                        margin-right: auto")
                    ),
                  br(),
                  uiOutput(test2$button.name, align="center"),
                  br()
                  ))
      }
    })
  
######
})