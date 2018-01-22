# Template for BIOMAAP educational modules
# January 15th, 2018
# Created by Impact Media Lab

######### Load required packages

library(shiny)
library(shinydashboard)

######### A dashboard has three parts: a header, a sidebar, and a body. 
shinyUI(dashboardPage(skin ="purple",
  
# HEADER  
  dashboardHeader(title = "BIOMAAP template",
                  
                  
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

# Adding custom CSS    
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
    ),
    
    tabItems(
      
      # WELCOME PAGE
      tabItem(tabName = "welcome",
              
              fluidRow(
                img(src ="BioMAAP_logo2.png", width = 400, style="display: block; margin-left: auto; 
                margin-right: auto; margin-top:40px; margin-bottom:20px")
               #imageOutput("BIOMAAPlogo_photo", width = "1080px", height = "400px", inline = F)
             ),

             tags$h1("Skills to Embrace Math and Succeed in Biology", align = "center"),
             tags$h2("Created by",span(tags$a(href="https://sites.google.com/site/flemingdavies/", "Arietta Fleming-Davies")), 
                     "and",span(tags$a(href="https://www.radford.edu/content/csat/home/biology/faculty/jeremy-wojdak.html", "Jeremy Wojdak"))),
             tags$h2("Built by",span(tags$a(href="https://www.impactmedialab.com/", "Impact Media Lab"))),
             #tags$iframe(id="iframe1", src="https://www.youtube.com/embed/jbXH1Qxl70U?rel=0" frameborder="0" allow="autoplay; encrypted-media"),
            
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
             br()
      
      ),
      
      # STUDENT SURVEY PAGE
      tabItem(tabName = "survey",

              uiOutput('ui')

      ),
      
      # LESSON ON TOPIC PAGE
      tabItem(tabName = "lesson",
              fluidRow(
                img(src ="placeholder.png", width = 400, style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:10px")
              ),
              
              br(),
              tags$h1("Cultivating a Growth Mindset", align = "center"),
              br(),
              fluidRow(
                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")),
              tags$h1("Takeaways"),
              tags$h2("1:	People are not born with the ability to perform tasks"),
              tags$h2("2:	Your brain changes as you learn new tasks and as you practice"),
              tags$h2("3: When we say we “just aren’t good” at something, we limit our own potential."),
              
              fluidRow(
                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")),
              br(),
              tags$h1("1:	People are not born with the ability to perform tasks"),
              
              p("Although we’d like to always have a growth mindset, the reality is that we can 
                only be on a journey to a growth mindset. The goal is to recognize fixed 
                mindset elements in ourselves and then reflect on feedback and strategies 
                for how to improve. The Mindset Assessment is a quick diagnostic tool 
                drawn from research-validated measures for people age 12 and over to use 
                to assess their mindsets."),
              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et 
                dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco 
                laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
                reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
                Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
                deserunt mollit anim id est laborum"),
              
              fluidRow(
                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")),
              br(),
              tags$h1("2:	Your brain changes as you learn new tasks and as you practice"),
              
              p("Although we’d like to always have a growth mindset, the reality is that we can 
                only be on a journey to a growth mindset. The goal is to recognize fixed 
                mindset elements in ourselves and then reflect on feedback and strategies 
                for how to improve. The Mindset Assessment is a quick diagnostic tool 
                drawn from research-validated measures for people age 12 and over to use 
                to assess their mindsets."),
              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et 
                dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco 
                laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
                reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
                Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
                deserunt mollit anim id est laborum"),
              
              fluidRow(
                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")),
              br(),
              tags$h1("3: When we say we “just aren’t good” at something, we limit our own potential."),
              
              p("Although we’d like to always have a growth mindset, the reality is that we can 
                only be on a journey to a growth mindset. The goal is to recognize fixed 
                mindset elements in ourselves and then reflect on feedback and strategies 
                for how to improve. The Mindset Assessment is a quick diagnostic tool 
                drawn from research-validated measures for people age 12 and over to use 
                to assess their mindsets."),
              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et 
                dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco 
                laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
                reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
                Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
                deserunt mollit anim id est laborum")
            
              ),
      
      # QUIZ ON TOPIC PAGE
      tabItem(tabName = "quiz",
              fluidRow(
                img(src ="placeholder.png", width = 400, style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:10px")
                ),
              
              br(),
              tags$h1("Take the Quiz to Test Your Comprehension", align = "center"),
              br(),
              
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
              
              br(),
              
              fluidRow(
                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")
                ),
              
              br(),
              
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
                img(src ="placeholder.png", width = 400, style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:10px")
                ),
              
              br(),
              tags$h1("Check Your Answers", align = "center"),
              br(),
              
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
              
              br(),
              
              fluidRow(
                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")
                ),
              
              br(),
              
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
