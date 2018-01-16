# Template for BIOMAAP educational modules
# January 15th, 2018
# Created by Impact Media Lab

######### Load required packages

library(shiny)
library(shinydashboard)

######### A dashboard has three parts: a header, a sidebar, and a body. 
shinyUI(dashboardPage(skin ="black",
  
# HEADER  
  dashboardHeader(title = "BIOMAAP module template",
                  
                  
                  ##### DROPDOWN MENUS
                  
                  # DROPDOWN MENU: TASKS
                  dropdownMenu(type = "tasks", badgeStatus = "success",
                               taskItem(value = 90, color = "green",
                                        "Documentation"
                               ),
                               taskItem(value = 17, color = "aqua",
                                        "Project X"
                               ),
                               taskItem(value = 75, color = "yellow",
                                        "Server deployment"
                               ),
                               taskItem(value = 80, color = "red",
                                        "Overall project"
                               )
                  )),

# SIDEBAR  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Welcome", tabName = "welcome", icon = icon("hand-spock-o")),
      menuItem("Survey", tabName = "survey", icon = icon("pencil-square")),
      menuItem("Lesson", tabName = "lesson", icon = icon("graduation-cap")),
      menuItem("Quiz", tabName = "quiz", icon = icon("question-circle")),
      menuItem("Results", tabName = "results", icon = icon("bar-chart"))
    )
  ),

#BODY
# Boxes need to be put in a row (or column)  
  dashboardBody(
    tabItems(
      
      # WELCOME PAGE
      tabItem(tabName = "welcome",
             fluidRow(
               img(src ="BioMAAP_logo2.png", width = 450, style="display: block; margin-left: auto; 
                   margin-right: auto; margin-top:40px; margin-bottom:20px")
               #imageOutput("BIOMAAPlogo_photo", height = "100px", width = "100px", inline = T)
             ),
             #p("",span(tags$a(href = "http://benfry.com/projects", "Check out Ben Fry's gallary", style = "color:navy")), align = "right"),
             
             tags$h2("SKILLS TO EMBRACE MATH AND SUCCEED IN BIOLOGY", align = "center"),
             tags$h4(p("Developed by Arietta Fleming-Davies and Jeremy Wojdak", style = "color:black", align="center")),
             tags$h4(p("Built by", span(tags$a(href = "https://www.impactmedialab.com/", "Impact Media Lab", style = "color:black"))), align="center"),
             ### tags$iframe(id="iframe1", src="http://player.vimeo.com/video/21172499?"),
            
             br(),
             
             p("The Biology Students Math Attitudes and Anxiety Program is a resource for 
              educators who are looking to implement non-invasive techniques to change 
              student attitudes and reduce anxiety towards math. Lorem ipsum dolor sit amet, 
               consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et 
               dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco 
               laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
               reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
               Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
               deserunt mollit anim id est laborum"),
            
            fluidRow(
              img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                   margin-right: auto")
            )
      
      ),
      
      # STUDENT SURVEY PAGE
      tabItem(tabName = "survey",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      # LESSON ON TOPIC PAGE
      tabItem(tabName = "lesson",
              fluidRow(
                imageOutput("looking_hard", height = 430, width = 400)
              )
              ),
      
      # QUIZ ON TOPIC PAGE
      tabItem(tabName = "quiz",
              fluidRow(
                #box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      # RESULTS PAGE
      tabItem(tabName = "results",
              # infoBoxes with fill=FALSE
              fluidRow(
                  # A static infoBox
                  infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
                  # Dynamic infoBoxes
                  infoBoxOutput("progressBox"),
                  infoBoxOutput("approvalBox")
              ),
                
              # infoBoxes with fill=TRUE
              fluidRow(
                  infoBox("New Orders", 10 * 2, icon = icon("credit-card"), fill = TRUE),
                  infoBoxOutput("progressBox2"),
                  infoBoxOutput("approvalBox2")
              ),
                
              fluidRow(
                # Clicking this will increment the progress amount
                  box(width = 4, actionButton("count", "Increment progress"))
              )
       )
      )
  )
))
