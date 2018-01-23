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
              
            #fluidRow(
            #    img(src ="BioMAAP_logo2.png", width = 400, style="display: block; margin-left: auto; 
            #    margin-right: auto; margin-top:40px; margin-bottom:20px")
            # ),
            tags$iframe(class="video", width = "560", height = "315", src="https://www.youtube.com/embed/jbXH1Qxl70U?rel=0&amp;controls=0&amp;showinfo=0", frameborder="0", allow="autoplay; encrypted-media", allowfullscreen=T
                        ),

            tags$h1("Skills to Embrace Math and Succeed in Biology", align = "center"
                    ),
            
            tags$h2("Created by",span(tags$a(href="https://sites.google.com/site/flemingdavies/", "Arietta Fleming-Davies")), 
                     "and",span(tags$a(href="https://www.radford.edu/content/csat/home/biology/faculty/jeremy-wojdak.html", "Jeremy Wojdak"))
                    ),
            tags$h2("Built by",span(tags$a(href="https://www.impactmedialab.com/", "Impact Media Lab"))
                    ),
            
            p("The Biology Students Math Attitudes and Anxiety Program is a resource for 
              educators who are looking to implement non-invasive techniques to change 
              student attitudes and reduce anxiety towards math. Lorem ipsum dolor sit amet, 
               consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et 
               dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco 
               laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
               reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
               Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
               deserunt mollit anim id est laborum"
              ),
            
            br(),
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
             
               tags$h1("Cultivating a Growth Mindset", align = "center"
                       ),
              
              fluidRow(img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")
                       ),
              
              tags$h1("Takeaways"),
              tags$h2("1:	People are not born with the ability to perform tasks"),
              tags$h2("2:	Your brain changes as you learn new tasks and as you practice"),
              tags$h2("3: When we say we “just aren’t good” at something, we limit our own potential."),
              
              br(),
              br(),
              
              fluidRow(
                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")
                ),
            
              fluidRow(
                img(src ="placeholder.png", width = 200, style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:10px")
                ),
              
              tags$h1("1:	People are not born with the ability to perform tasks"
                      ),
              
              p("Do you believe that people are born with the ability to juggle? 
                That babies either have a 'juggler's brain' or they don't? That no amount of 
                practice or learning can change your natural-born ability to catch and toss 
                balls into the air?"
                ), 

              tags$h2("Probably, you don't. Most people expect that those who can juggle have 
                      put in time and effort to learn how to do it."
                      ),
              
              p("But many people believe that you are born either good or bad at math. When 
                you hear someone say, ‘I’m just not good at it,’ they are demonstrating a 
                ‘fixed mindset.’ A fixed mindset suggests you are born with the potential to 
                be good or bad at certain tasks and, thus, you have limited control over your 
                ability to excel. People often have a fixed mindset when it comes to learning 
                mathematics"
              ),
              
              tags$h2("But having a fixed mindset limits your learning potential AND goes 
                      against what we know from studies in brain and learning science."
                      ),
              
              fluidRow(
                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")
                ),
              
              fluidRow(
                img(src ="placeholder.png", width = 200, style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:10px")
                ),
              
              tags$h1("2:	Your brain changes as you learn new tasks and as you practice"
                      ),
              
              p("Your brain is plastic! Not plastic like Tupperware, but plastic in the sense 
                that it is moldable, changeable, and flexible. When you take on difficult 
                mental tasks, like learning math, your brain gets busy rewiring itself in a 
                process that is analogous to the way your muscles build themselves up each time 
                you work them hard."
                ),
              
              fluidRow(
                img(src ="Scholz_et_al.png", width = 600, style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:10px")
                ),
              
              p("Scholz et al. (2009) studied the brains of people learning to juggle. 
                They found that the density of grey matter increased and the 
                structure of white matter changed in those that learned to juggle, even after 
                just a few weeks. People's brains were changing in response to new demands."
                ),

              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et 
                dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco 
                laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in 
                reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
                Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
                deserunt mollit anim id est laborum"),
              
              fluidRow(
                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto")),
              
              fluidRow(
                img(src ="placeholder.png", width = 200, style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:10px")
                ),
              tags$h2("3: When we say we “just aren’t good” at something, we limit our own potential."),
              
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
      
      
      # STUDENT SURVEY QUIZ
      tabItem(tabName = "quiz",
              uiOutput('ui2')
      ),
      
      
      # RESULTS PAGE
      tabItem(tabName = "results",
              # infoBoxes with fill=FALSE
              fluidRow(
                img(src ="placeholder.png", width = 400, style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:10px")
                ),
              
              tags$h1("Let's Review Your Results", align = "center"),

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
              
              fluidRow(
                  # Dynamic infoBoxes
                infoBoxOutput("assessmentBox", width=4),
                infoBoxOutput("quizBox"),
                infoBoxOutput("feedbackBox")
                ),
              
              fluidRow(
                box(plotOutput("mass.plot")),
                box(
                  plotOutput("mass.plot2")
                )
              ),
              
              br(),
              br()
       )
      )
  )
))
