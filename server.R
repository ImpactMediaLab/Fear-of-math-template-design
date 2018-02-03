# Template for BIOMAAP educational modules
# January 15th, 2018
# Created by Impact Media Lab

######### Load required packages

library(shiny)
library(shinydashboard)
library(plotrix)
library(leaflet)
library(shinyjs)
source('www/ShinyAssessment.R')
source('www/ShinyAssessment2.R')
#remove(SHOW_ASSESSMENT3)
#remove(SHOW_ASSESSMENT2)

math.items3 <- as.data.frame(read.csv('www/items.csv', stringsAsFactors=FALSE))
math.items2 <- as.data.frame(read.csv('www/quiz1.csv', stringsAsFactors=FALSE))


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
  
# Building an example action button
  
######################################################      
  
  observeEvent(input$do, {
    session$sendCustomMessage(type = 'testmessage',
                              message = 'Right! You chose the correct answer.')
  })

  
######################################################      
  
# Building a sample test question
  
######################################################      
  
#  output$selected_var <- renderText({ 
#    paste("You have selected", input$var)
#  })
  
  
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

    
#  output$assessmentBox <- renderInfoBox({
#    infoBox(
#      "Survey Assessment", paste0(25 + input$count, "%"), icon = icon("list"),
#      color = "purple", fill = F)
#  })
#  output$quizBox <- renderInfoBox({
#    infoBox(
#      "Quiz Score", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
#      color = "purple", fill = F)
#  })
#  output$feedbackBox <- renderInfoBox({
#    infoBox(
#      "Mindset Feedback", paste0(25 + input$count, "%"), icon = icon("list"),
#      color = "purple", fill = F)
#  })
  
  
######################################################      
  
######### BUILDING THE MINDSET ASSESSMENT

######################################################      

    
    # Save the most recent assessment results to display
    assmt.results3 <- reactiveValues(
      math = integer()
    )
  
  assmt.results2 <- reactiveValues(
    math = logical()
  )  
    
    # This function will be called when the assessment is completed.
    saveResults3 <- function(results) {
      assmt.results3$math <-  factor(results,
       levels = names(math.items3)[4:9],
       ordered = TRUE)
    }
    
    saveResults2 <- function(results) {
      assmt.results2$math <- results == math.items2$Answer
    }
    
   
    
    # Multiple choice test example
    test3 <- ShinyAssessment3(input, output, session,
                            name = 'Statistics3',
                            item.stems = math.items3$Stem,
                            item.choices = math.items3[,c(4:9)],
                            callback = saveResults3,
                            start.label = 'Take the Mindset Survey',
                            width="100%",
                            itemsPerPage = 1,
                            inline = FALSE)
    
    SHOW_ASSESSMENT3$show <- FALSE
    
    output$ui3 <- renderUI({
      if(SHOW_ASSESSMENT3$show) { # The assessment will take over the entire page.
        fluidPage(width = 12, uiOutput(SHOW_ASSESSMENT3$assessment))
      } else { # Put other ui components here
        fluidPage(	 
          
          fluidRow(
            img(class="image", src ="growth_vs_fixed.png", width = "26%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:20px; margin-bottom:-10px")
            ),
          
          tags$h1("What's your current mindset?", align = "center"),
          
          p("Before we get started, let's explore your current perspective on learning mathematics.
            We will have you complete this brief survey. There are no right or wrong answers. 
            We are just interested in your ideas."),
          
          p("For this assessment, indicate the extent to which you agree or disagree with 
            each of the following statements."
          ),

          uiOutput(test3$button.name, align="center"),
          br(),
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
                            itemsPerPage = 1,
                            inline = FALSE)
    
    output$ui2 <- renderUI({
      if(SHOW_ASSESSMENT2$show) { # The quiz will take over the entire page.
        fluidPage(width = 12, uiOutput(SHOW_ASSESSMENT2$assessment))
      } else { # Put other ui components here
        fluidPage(	 
          
          # QUIZ ON TOPIC PAGE
          tabItem(tabName = "quiz",
                  fluidRow(
                    img(class="image", src ="brain.png", width = "26%", style="display: block; margin-left: auto; 
                        margin-right: auto; margin-top:20px; margin-bottom:-10px")
                    ),
                  
                  tags$h1("Test Your Comprehension", align = "center"),
                  
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

                  uiOutput(test2$button.name, align="center"),
                  br(),
                  br()
                  ))
      }
    })


######################################################################      
    
######### BUILDING THE RESULTS OUTPUT FOR ASSESSMENT & QUIZ
    
######################################################################      

    output$mass.plot3 <- renderPlot({
      ab_line <- 3
      if(length(assmt.results3$math) > 0) {
        plot(assmt.results3$math)
       
        print(math.items3[,3])
        score_matrix <- matrix(NA, length(math.items3[,3]), 6 )
        
        for(i in 1:length(math.items3[,3])){
          if(math.items3[i,3] == "A"){
            score_matrix[i,] <- seq(6,1)
          }else{
            score_matrix[i,] <- rev(seq(6,1))
          }
          
        }
        
        k <- as.numeric(assmt.results3$math) #c( 2, 3, 4, 3, 6, 3, 4, 2)
        j <- 3
        score <- rep(NA, 8)
        for(j in 1:length(k)){
        score[j] <- score_matrix[j, k[j]]
        }
        
        sum_score <- sum(na.omit(score))
        save(sum_score, file="www/survey_score.Rdata")
        print(assmt.results3$math)
        print(as.numeric(assmt.results3$math))
        #plot(1:length(assmt.results3$math),assmt.results3$math, col="#605ea6", yaxt="n", ylab="", xlab="question number", pch=19)
        #axis(2, labels=c("right", "wrong"), at=c(0,1))
        
        plot(1:61,type="n",axes=FALSE, ylim=c(0,1), ylab="", xlab="", bty="n", cex.main=1.3, cex=3, family="Source Sans Pro")
        gradient.rect(1,0,48,1,col=smoothColors("powderblue",25,"#1176ff"), gradient="x", border="#222D32")
        axis(1, labels=c("Fixed", "Growth"), at=c(1,45), col = NA, col.ticks = "#222D32", cex.axis=1.3, tcl = 1, family="Source Sans Pro", 
             font=2)
        #abline(v=ab_line, col= "#1176ff", lwd=2)
        text( sum(na.omit(score))+ 5, 0.75 ,"You Are Here",  font=4, cex=1)
        abline(v=sum(na.omit(score)) , lwd=5)
      
      } else {
        plot(0,0,type="n", bty="n", xaxt="n", yaxt="n", xlab="", ylab="")
        mtext("Please take the \n Mindset Assessment to \n see your results", cex=1.5, line=-10, family="Source Sans Pro")
      }
    })
    
    output$mass.plot2 <- renderPlot({
      if(length(assmt.results2$math) > 0) {
        plot(1:length(assmt.results2$math),assmt.results2$math, col="#605ea6", yaxt="n", ylab="", xlab="question number", pch=19) 
        axis(2, labels=c("right", "wrong"), at=c(0,1))
        } else {
          plot(0,0,type="n", bty="n", xaxt="n", yaxt="n", xlab="", ylab="")
          mtext("Please take the \n quiz to \n see your results", cex=1.5, line=-10, family="Source Sans Pro")
        }
      })

    
######################################################################      
    
######### MAP OF LONDON
    
######################################################################      
    
  ## leaflet map
    output$mymap_1 <- renderLeaflet({
      
      m <- leaflet() %>%
        addTiles() %>%  # Add default OpenStreetMap map tiles
       # addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R") %>%
        addProviderTiles("providers$Stamen.Toner") %>%
      setView( -0.1278,51.5074, 12)
      m 
    
      })

######################################################################      
    
######### FORWARD & BACK BUTTONS ON LESSON SECTION
    
######################################################################      
    
    Previous_Button=tags$div(actionButton("Prev_Tab",HTML('
<div class="col-sm-4"><i class="fa fa-angle-double-left fa-2x"></i></div>
                                                          ')))
    Next_Button=div(actionButton("Next_Tab",HTML('
                                                 <div class="col-sm-4"><i class="fa fa-angle-double-right fa-2x"></i></div>
                                                 ')))
    
    #actionButton("Next_Tab", HTML( <div class="col-sm-8"><i class= icon("arrow-alt-circle-right",  lib = "font-awesome")))
    
    #)
   
    
    
    
    output$Next_Previous=renderUI({
      div(column(1,offset=1,Previous_Button),column(1,offset=8,Next_Button))
    })
    
    output$Next_Previous=renderUI({
      tab_list=input$List_of_tab[-length(input$List_of_tab)]
      nb_tab=length(tab_list)
      #if (which(tab_list==input$tabBox_next_previous)==nb_tab)
        #column(1,offset=1,Previous_Button)
      #else if (which(tab_list==input$tabBox_next_previous)==1)
        column(1,offset = 10,Next_Button)
      #else
      #  div(column(1,offset=1,Previous_Button),column(1,offset=8,Next_Button))
    })
      
      observeEvent(input$Prev_Tab,
                   {
                     tab_list=input$List_of_tab
                     current_tab=which(tab_list==input$tabBox_next_previous)
                     updateTabsetPanel(session,"tabBox_next_previous",selected=tab_list[current_tab-1])
                   })
      
      observeEvent(input$Next_Tab,
                   {
                     tab_list=input$List_of_tab
                     current_tab=which(tab_list==input$tabBox_next_previous)
                     updateTabsetPanel(session,"tabBox_next_previous",selected=tab_list[current_tab+1])
                   })
    
####
      
      output$score_text <- renderUI({ 
        load("www/survey_score.Rdata")
        if(sum_score < 35){
        fluidPage(
        tags$h2("Your Score Suggests", align = "center"),
       
        p("WOW, you are bad at this. Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
                probably don’t really like to put in a lot of effort on things that don’t 
          come easily to you. You may think that learning should be fast and when 
          you find something difficult you may feel like giving up and up and up."),
      
        br()
        )
        }else{if( 35 < sum_score & sum_score < 45){
          fluidPage(
            tags$h2("Your Score Suggests", align = "center"),
            
            p("AVERAGE. Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up."),
            
            br()
            )
  
        }else{
          fluidPage(
            tags$h2("Your Score Suggests", align = "center"),
            
            p("WINNING. Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up."),
            
            br()
            )
        }
        }
      })
     
      
    
#####
})