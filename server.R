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
  
######### BUILDING THE MINDSET SURVEY

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
          
          p("For this survey, indicate the extent to which you agree or disagree with 
            each of the following statements."
          ),

          uiOutput(test3$button.name, align="center"),
          br(),
          br()
          )
      }
    })


######################################################################      
    
######### BUILDING THE RESULTS OUTPUT FOR SURVEY
    
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
       
       ####### 
   
        require(png)
        img<-readPNG("www/Spectrum_background.png")
        img2<-readPNG("www/youarehere_button.png")
        
        par(mar=c(0,0,0,0))
        #now open a plot window with coordinates
        plot(1:10,ty="n", bty='n', xaxt="n", yaxt="n", xlab="", ylab="", ylim=c(3,9), xlim=c(1.8,9.2))
        #specify the position of the image through bottom-left and top-right coords
        
        #Adding image background
        #xleft, ybottom, xright, ytop
        rasterImage(img,0.55,1.5,10.45,10)

        dat <- read.csv("www/Default Dataset.csv", as.is=TRUE, header=F)
        points(dat[,1], dat[,2], col="white", pch=20, cex=3.5)
        
        points(dat[1:sum_score,1], dat[1:sum_score,2], col="#FFA444", pch=20, cex=3.6)
        # Adding the You Are Here button
        rasterImage(img2,dat[sum_score,1]-0.35,dat[sum_score,2],dat[sum_score,1]+0.15,dat[sum_score,2]+0.55)
        
        dev.copy(png, "www/survey_output_figure.png")
        dev.off()
      
      } else {
        plot(0,0,type="n", bty="n", xaxt="n", yaxt="n", xlab="", ylab="")
        mtext("Please take the \n Mindset Assessment to \n see your results", 
              cex=1.5, line=-10, family="Source Sans Pro")
      }
    }
)
    
    output$mass.plot2 <- renderPlot({
      if(length(assmt.results2$math) > 0) {
        plot(1:length(assmt.results2$math),assmt.results2$math, col="#605ea6", yaxt="n", ylab="", xlab="question number", pch=19) 
        axis(2, labels=c("right", "wrong"), at=c(0,1))
        } else {
          plot(0,0,type="n", bty="n", xaxt="n", yaxt="n", xlab="", ylab="")
          mtext("Please take the \n quiz to \n see your results", cex=1.5, line=-10, family="Source Sans Pro")
        }
      })

    output$per_lesson <- renderPlot({
      plot(1:10, col="red")
      
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
    
    #Previous_Button=tags$div(actionButton("Prev_Tab",HTML('<div class="col-sm-4"><i class="fa fa-angle-double-left fa-2x"></i></div>')))
    
    Next_Button=div(
      actionButton(inputId="Next_Tab", label ='Next Page', icon = icon("angle-double-right"), 
                   style="color: #8FB230; font-family: 'Source Sans Pro', sans-serif; font-size: 14px; font-weight: 400;
                   background-color: #ecf0f5; border-color: #ecf0f5", width="100%")
    )
    
    output$Next_Previous=renderUI({
      #div(column(1,offset=1,Previous_Button),column(1,offset=8,Next_Button))
      div(column(12, Next_Button, offset=0))
    })
    
    output$Next_Previous=renderUI({
      tab_list=input$List_of_tab[-length(input$List_of_tab)]
      nb_tab=length(tab_list)
      #if (which(tab_list==input$tabBox_next_previous)==nb_tab)
        #column(1,offset=1,Previous_Button)
      #else if (which(tab_list==input$tabBox_next_previous)==1)
        #column(1,offset = 10,Next_Button)
        column(12,offset = 0,Next_Button)
        
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
    
######################################################################      
      
######### RESULTS OUTPUT FOR 3 MINDSET CATEGORIES
      
######################################################################      
      
      
      output$score_text <- renderUI({ 
        load("www/survey_score.Rdata")
        if(sum_score < 17){
        fluidPage(
        tags$h2("Your Score Suggests", align = "center"),
       
        p("Needs work. Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
          probably don’t really like to put in a lot of effort on things that don’t 
          come easily to you. You may think that learning should be fast and when 
          you find something difficult you may feel like giving up and up and up."),
      
        br()
        )
        }else{if( 16 < sum_score & sum_score < 33){
          fluidPage(
            tags$h2("Your Score Suggests", align = "center"),
            
            p("Pretty good. Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up."),
            
            br()
            )
  
        }else{
          fluidPage(
            tags$h2("Your Score Suggests", align = "center"),
            
            p("You've got it. Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up."),
            
            br()
            )
        }
        }
      })
     
######################################################################      
      
######### BUILDING THE INTERACTIVE QUIZ
      
######################################################################      
      
      
###########################  1   #####################
   
      output$quiz_question_1_lesson <- renderUI({ 
       
       if(length(input$quiz_question_1) == 0){
         fluidPage(
           #p("Answer me one little question"),
           )
         
       }else{if(input$quiz_question_1 == 2){
          fluidPage(
            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
              margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Right! You chose the correct answer.", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        }else{
          fluidPage(

            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        
        }
       }
        
      })
      
###########################  2   #####################
      output$quiz_question_2_lesson <- renderUI({ 
        
        if(length(input$quiz_question_2) == 0){
          fluidPage(
          )
          
        }else{if(input$quiz_question_2 == 1){
          fluidPage(

            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
                  margin-right: auto; margin-top:0px; margin-bottom:-10px"),
              tags$h2("Right! You chose the correct answer.", align = "center"),
              
              p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
                probably don’t really like to put in a lot of effort on things that don’t 
                come easily to you. You may think that learning should be fast and when 
                you find something difficult you may feel like giving up and up and up.")
              )
        }else{
          fluidPage(

            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
          
        }
        }
        
      })
      
      ###########################  3   #####################3
      output$quiz_question_3_lesson <- renderUI({ 
        
        if(length(input$quiz_question_3) == 0){
          fluidPage(
            #p("Answer me one little question"),
          )
          
          
        }else{if(input$quiz_question_3 == 1){
          fluidPage(

            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Right! You chose the correct answer.", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        }else{
          fluidPage(
            
            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
          
        }
        }
        
      })
      
      ###########################  4   #####################3
      output$quiz_question_4_lesson <- renderUI({ 
        
        if(length(input$quiz_question_4) == 0){
          fluidPage(
            #p("Answer me one little question"),
          )
          
        }else{if(input$quiz_question_4 == 2){
          fluidPage(

            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Right! You chose the correct answer.", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        }else{
          fluidPage(

            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
          
        }
        }
        
      })
      
      ###########################  5   #####################3
      output$quiz_question_5_lesson <- renderUI({ 
        
        if(length(input$quiz_question_5) == 0){
          fluidPage(
          )
        
        }else{if(input$quiz_question_5 == 2){
          fluidPage(
            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
              margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Right! You chose the correct answer.", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
          )
        }else{
          fluidPage(
            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
          )
          
        }
        }
        
      })
      
      ###########################  6   #####################3
      output$quiz_question_6_lesson <- renderUI({ 
        
        if(length(input$quiz_question_6) == 0){
          fluidPage(
          )
          
          
        }else{if(input$quiz_question_6 == 2){
          fluidPage(
            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Right! You chose the correct answer.", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        }else{
          fluidPage(
            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
          
        }
        }
        
      })
      
      ###########################  7   #####################3
      output$quiz_question_7_lesson <- renderUI({ 
        
        if(length(input$quiz_question_7) == 0){
          fluidPage(
          )
          
        }else{if(input$quiz_question_7 == 2){
          fluidPage(
            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Right! You chose the correct answer.", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        }else{
          fluidPage(
            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
          
        }
        }
        
      })
      
      ###########################  8   #####################3
      output$quiz_question_8_lesson <- renderUI({ 
        
        if(length(input$quiz_question_8) == 0){
          fluidPage(
          )

        }else{if(input$quiz_question_8 == 2){
          fluidPage(
            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Right! You chose the correct answer.", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        }else{
          fluidPage(
            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
          
        }
        }
        
      })
      
      ###########################  9   #####################3
      output$quiz_question_9_lesson <- renderUI({ 
        
        if(length(input$quiz_question_9) == 0){
          fluidPage(
            p("Placeholder for a potential question")
          )
          
          
        }else{if(input$quiz_question_9 == 1){
          fluidPage(
            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Right! You chose the correct answer.", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        }else{
          fluidPage(
            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
          
        }
        }
        
      })
      
      ###########################  10   #####################3
      output$quiz_question_10_lesson <- renderUI({ 
        
        if(length(input$quiz_question_10_lesson) == 0){
          fluidPage(
          )
          
        }else{if(input$quiz_question_10_lesson == 1){
          fluidPage(
            img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Right! You chose the correct answer.", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        }else{
          fluidPage(
            img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:0px; margin-bottom:-10px"),
            tags$h2("Nice try! Let's talk through the problem", align = "center"),
            
            p("Right now, you lean toward thinking that your intelligence doesn’t change much. You prefer not to make mistakes if you can help it and you 
              probably don’t really like to put in a lot of effort on things that don’t 
              come easily to you. You may think that learning should be fast and when 
              you find something difficult you may feel like giving up and up and up.")
            )
        }
        }
        
        })
      
##############
      
      
    ## header so you know where you are...  
      output$downloadReport <- downloadHandler(
        filename = function() {"plots.pdf"},
        content = function(file) {
          
          pdf(file, height = 11, width=8.5)
          require(png)
          img<-readPNG("www/GMmodule_summary_page_printout-01.png")
          img2<-readPNG("www/survey_output_figure.png")
          
          par(mar=c(0,0,0,0))
          #now open a plot window with coordinates
          plot(1:10,ty="n", bty='n', xaxt="n", yaxt="n", xlab="", ylab="", ylim=c(1.35,9.65), xlim=c(1.35,9.65))
          #specify the position of the image through bottom-left and top-right coords
          
          #xleft, ybottom, xright, ytop
          rasterImage(img,1,1,10,10)
          rasterImage(img2,1.8,5.4,4.6,7.1)
          rasterImage(img2,6.3,5.4,9.1,7.1)
          
          dev.off()}
      )
      
      observeEvent(input$switchtab, {
        newtab <- switch(input$tabs,
                         "assessment" = "assessment_results",
                         "assessment_results" = "assessment"
        )
        updateTabItems(session, "tabs", newtab)
      })
      
      
      
    
#####
})