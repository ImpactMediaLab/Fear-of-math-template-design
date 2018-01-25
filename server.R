# Template for BIOMAAP educational modules
# January 15th, 2018
# Created by Impact Media Lab

######### Load required packages

library(shiny)
library(shinydashboard)
library(plotrix)
library(leaflet)
source('ShinyAssessment.R')
source('ShinyAssessment2.R')
#remove(SHOW_ASSESSMENT)
#remove(SHOW_ASSESSMENT2)

math.items <- as.data.frame(read.csv('items.csv', stringsAsFactors=FALSE))
math.items2 <- as.data.frame(read.csv('quiz1.csv', stringsAsFactors=FALSE))


######################################################      

# Define server logic required to draw a histogram

######################################################      


shinyServer(function(input, output, session) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
     })

  
######################################################      
  
######### Images used in the module

######################################################      
  
  
  output$BIOMAAPlogo_photo <- renderImage({
    list(
      src = "www/BioMAAP_logo3.png",
      contentType = "image/png",
      alt = "Face"
    )}, deleteFile = FALSE)

    
######################################################      
  
######### Info boxes on the RESULTS page

######################################################      

    
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
  
  
######################################################      
  
######### BUILDING THE MINDSET ASSESSMENT

######################################################      

    
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
      assmt.results2$math <- results == math.items$Answer
    }
    
    # Provide some basic feedback to students
    output$math.results <- renderText({
      txt <- ''
      if(length(assmt.results$math) > 0) {
        txt <- paste0('You got ', sum(assmt.results$math, na.rm=TRUE),
                      ' of ', length(assmt.results$math), ' items correct.')
      } else {
        txt <- 'No results found. Please take the Mindset Assessment.'
      }
      return(txt)
    })
    
    # Multiple choice test example
    test <- ShinyAssessment(input, output, session,
                            name = 'Statistics',
                            item.stems = math.items$Stem,
                            item.choices = math.items[,c(4:8)],
                            callback = saveResults,
                            start.label = 'Take the Mindset Assessment',
                            width="100%",
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
          
          tags$h1("Take the Mindset Assessment", align = "center"),
          
          tags$h2("In a growth mindset, people believe that their most basic abilities can be 
                  developed through dedication and hard work — brains and talent are just the 
                  starting point. This view creates a love of learning and a resilience that is 
                  essential for great accomplishment."),
          tags$h2("- Carol Dweck"),
          
          br(),
          
          fluidRow(img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")),
          
          p("Although we’d like to always maintain a growth mindset, the truth is that we 
            can only be on a journey to a growth mindset. The goal is to recognize fixed 
            mindset elements in ourselves and then reflect on feedback and strategies 
            for how to improve. The Mindset Assessment is a quick diagnostic tool to help 
            you assess where you fall on the continuum between fixed and and growth mindsets.
            There are no right or wrong answers. We are just interested in your ideas."),
          
          p("For this assessment, indicate the extent to which you agree or disagree with 
            each of the following statements."
          ),
      
          uiOutput(test$button.name, align="center"),
          br()
          )
      }
    })

    
######################################################      
    
######### BUILDING THE GROW MINDSET QUIZ
    
######################################################      
    
    # Multiple choice test example
    test2 <- ShinyAssessment2(input, output, session,
                            name = 'Statistics2',
                            item.stems = math.items2$Stem,
                            item.choices = math.items2[,c(4:8)],
                            callback = saveResults2,
                            start.label = 'Take the Quiz',
                            width="100%",
                            itemsPerPage = 8,
                            inline = FALSE)
    
    output$ui2 <- renderUI({
      if(SHOW_ASSESSMENT2$show) { # The quiz will take over the entire page.
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
                  
                  p("Now let’s explore your comprehension of the information presented in the 
                    'Cultivating a Growth Mindset' lesson. This short quiz presents examples of 
                    fixed and growth mindsets that we may encounter in our everyday lives, when 
                    we interact with teachers, coaches, and classmates. Can you tell when 
                    someone is demonstrating a fixed versus growth mindset? Take the quiz and 
                    see how you score. You can always re-read the lesson and try again."
                    ),
                  
                  #p("For the quiz, determine whether the statement exemplifies a growth or 
                   # fixed mindset."
                    #),

                  br(),
                  uiOutput(test2$button.name, align="center"),
                  br()
                  ))
      }
    })


######################################################################      
    
######### BUILDING THE RESULTS OUTPUT FOR ASSESSMENT & QUIZ
    
######################################################################      

    output$mass.plot <- renderPlot({
      
      if(length(assmt.results$math) > 0) {
        plot(1:10,type="n",axes=FALSE, ylim=c(0,1), ylab="", xlab="", bty="n", main="Where do you fall on the continuum \n between a fixed versus growth mindset?", family="Source Sans Pro")
        gradient.rect(1,0,10,1,col=smoothColors("powderblue",25,"#605ea6"), gradient="x", border="#222D32")
        axis(1, labels=c("FIXED", "GROWTH"), at=c(1,10), col = NA, col.ticks = "#222D32", cex=2, tcl = 1, family="Source Sans Pro", font=2)
        abline(v=3, col= "#605ea6", lwd=2)
        #abline(v=sum(na.omit(assmt.results$math)))
      } else {
        plot(0,0,type="n", bty="n", xaxt="n", yaxt="n", xlab="", ylab="")
        mtext("Please take the \n Mindset Assessment to \n see your results", cex=2, line=-10, family="Source Sans Pro")
      }
    })
    
    output$mass.plot2 <- renderPlot({
      if(length(assmt.results2$math) > 0) {
        plot(1:length(assmt.results2$math),assmt.results2$math, col="#605ea6", yaxt="n", ylab="", xlab="question number", pch=19) 
        axis(2, labels=c("right", "wrong"), at=c(0,1))
        } else {
          plot(0,0,type="n", bty="n", xaxt="n", yaxt="n", xlab="", ylab="")
          mtext("Please take the \n quiz to \n see your results", cex=2, line=-10, family="Source Sans Pro")
        }
      })
  
  ## leaflet map
    output$mymap_1 <- renderLeaflet({
      
      m <- leaflet() %>%
        addTiles() %>%  # Add default OpenStreetMap map tiles
       # addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R") %>%
        addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
      setView( -0.1278,51.5074, 8)
      m 
    
      })
    
######
})