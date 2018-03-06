# Template for BIOMAAP educational modules
# January 15th, 2018
# Created by Impact Media Lab

######### Load required packages

library(shiny)
library(shinydashboard)
library(leaflet)

########## Color palette:

# Bright blue #1176ff
# Sidebar black #222D32
# Grey background: #ecf0f5
# Accent dark blue: #1E5DB2
# Accent green: #8FB230

######### A dashboard has three parts: a header, a sidebar, and a body. 
shinyUI(dashboardPage(skin ="purple",
                      
# HEADER  
  dashboardHeader(title = "BIOMAAP template"
                  
                  
                  ##### DROPDOWN MENUS
                  
                  # DROPDOWN MENU: TASKS
                  #dropdownMenu(type = "tasks", badgeStatus = "success",
                  #             taskItem(value = 90, color = "green",
                  #                      "Documentation"
                  #             ),
                  #             taskItem(value = 17, color = "aqua",
                  #                      "Project X"
                  #             ),
                  #             taskItem(value = 75, color = "yellow",
                  #                      "Server deployment"
                  #             ),
                  #             taskItem(value = 80, color = "red",
                  #                      "Overall project"
                  #             )
                  #)
                  ),

# SIDEBAR  
  dashboardSidebar(
    sidebarMenu(  id = "tabs",
      menuItem("Welcome", tabName = "welcome", icon = icon("hand-spock-o")),
      menuItem("Mindset Survey", tabName = "assessment", icon = icon("pencil-square")),
      menuItem("Survey Results", tabName = "assessment_results", icon = icon("bar-chart")),
      menuItem("Topic exploration", tabName = "lesson", icon = icon("graduation-cap")),
      menuItem("Review", tabName = "quiz", icon = icon("question-circle")),
      #menuItem("Quiz Results", tabName = "results", icon = icon("bar-chart")),
      menuItem("Summary", tabName = "summary", icon = icon("bar-chart"))
    )
  ),

#BODY
# Boxes need to be put in a row (or column)  
  dashboardBody(

# Adding custom CSS    
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
    ),

# Changing Dashboard purple skin settings to match BIOMAAP logo colors    
    tags$style(HTML("

                    .skin-purple .main-header .logo {
                    background-color: #0066ff;
                    color: #fff; 
                    border-bottom: 0 solid transparent;
                    }

                    .skin-purple .main-header .logo:hover {
                    background-color: #0066ff
                    }

                    .skin-purple .main-header .navbar {
                    background-color: #1176ff;
                    }

                    .skin-purple .main-header .navbar .sidebar-toggle:hover {
                    background-color: #0066ff;
                    }

                    .skin-purple .sidebar-menu > li.active > a, 
                    .skin-purple .sidebar-menu > li:hover > a {
                    color: #fff;
                    background: #1e282c;
                    border-left-color: #1176ff;
                    }

                    .nav-tabs-custom > .nav-tabs > li.active {
                     border-top-color: #1176ff;
                    }

                    ")
               ),

    tabItems( 
    
      
######################################################      
# BUILDING THE PAGES #
######################################################      



      # WELCOME PAGE
      tabItem(tabName = "welcome",
              
            fluidRow(
              img(class="image", src ="growth_mindset.png", width = "35%", style="display: block; margin-left: auto; 
                  margin-right: auto; margin-top:20px; margin-bottom:0px")
              ),

            tags$h1("Cultivating Your Growth Mindset", align = "center"
                    ),
            
           tags$h2("Created by",span(tags$a(href="https://sites.google.com/site/flemingdavies/", target="_blank", "Arietta Fleming-Davies")), 
                    "and",span(tags$a(href="https://www.radford.edu/content/csat/home/biology/faculty/jeremy-wojdak.html", target="_blank", "Jeremy Wojdak")),
                    "as part of",span(tags$a(href="http://biomaap.org", target="_blank", "BIOMAAP"))),
                   
            tags$h2("Built by",span(tags$a(href="https://www.impactmedialab.com/", target="_blank", "Impact Media Lab"))
                    ),
            
            br()
      ),

      
######################################################      


      # MINDSET ASSESSMENT PAGE
      tabItem(tabName = "assessment",
              uiOutput('ui3')
      ),

      
######################################################      


# MINDSET ASSESSMENT RESULTS PAGE
tabItem(tabName = "assessment_results",
        fluidRow(
          img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
              margin-right: auto; margin-top:20px; margin-bottom:-10px")
          ),
        
        tags$h1("Let's Review Your Results", align = "center"),
        
        p("Your score on the survey will help us determine where you 
          start on the spectrum between a fixed versus growth mindset. As you will 
          learn in this module, a ‘fixed mindset’ suggests that you are born with 
          the potential to be good or bad at math, and that practicing math cannot 
          change your natural-born abilities. Instead, we want you to help you shift towards a growth mindset. A ‘growth 
          mindset’ suggests that you can become good at anything, including math, 
          with effort, patience, and practice. A growth mindset suggests that you 
          are not limited by natural abilities but only by the amount of time and 
          energy you commit to learning."
          ),

        p("Although we’d like to already have a growth mindset towards learning, 
          the truth is that we are all on a journey, starting out at different 
          points on the mindset spectrum. The goal is to recognize fixed mindset 
          elements in ourselves and reflect on feedback and strategies for how to 
          improve."
        ),

        tags$h2("Let's see where you start on the mindset spectrum", align = "center"),
        
        fluidRow(
          box(plotOutput(outputId="mass.plot3", width = "600px", height = "300px"), width=12, align="center")
        ),
        
        # Want this text to be based on the score from the survey (3 categories)
        fluidRow(
          box(width=12,
            
              uiOutput("score_text")
          )
        ),
        
        tags$h2("Now that we know a little about your starting mindset, let's continue to 
          the Topic Exploration section to learn more about cultivating a growth mindset."),
        
        br(),
        br()
),


######################################################      

      
      # LESSON ON TOPIC PAGE
      tabItem(tabName = "lesson",
          fluidRow( #closing the tab panels
            tags$script("
                               $('body').mouseover(function() {
                        list_tabs=[];
                        $('#tabBox_next_previous li a').each(function(){
                        list_tabs.push($(this).html())
                        });
                        Shiny.onInputChange('List_of_tab', list_tabs);})
                        "),
            uiOutput("Next_Previous"),
                   
            tabBox(width=12,id="tabBox_next_previous",
            
            tabPanel("Video", 
                     
              tags$iframe(width= "560", height= "315", style="display: block; margin-left:auto; margin-right:auto; margin-top:40px; 
              margin-bottom:-10px;",
                          src="https://www.youtube.com/embed/2zrtHt3bBmQ?rel=0&amp;controls=0", 
                          frameborder="0", allow="autoplay; encrypted-media", allowfullscreen=T
              ),
              
              tags$h3("Video produced by",span(tags$a(href="https://www.youtube.com/channel/UCxgOUb7t6VTS0-TPSPInBpg", "Class Dojo"))
              ),
              
              tags$h1("Cultivating a Growth Mindset", align = "center"
                       ),
              
              tags$h2("In a growth mindset, people believe that their most basic abilities can be 
                developed through dedication and hard work — brains and talent are just the 
                      starting point. This view creates a love of learning and a resilience that is 
                      essential for great accomplishment."),
              tags$h2("- Carol Dweck"
                      ),
              
              br()
            ),
            
            
              tabPanel("Outline",
              fluidRow(
                img(class="image", src ="growth_mindset.png", width = "25%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:0px; margin-bottom:-10px")
                ),
              tags$h1("Outline"),
              tags$h2("1:	People are not born with the ability to perform tasks"),
              tags$h2("2:	Your brain changes as you learn new tasks and as you practice"),
              tags$h2("3: When we say we “just aren’t good” at something, we limit our own potential."),
              
              br()
              
              ),
            
              tabPanel("Part 1",
              fluidRow(
                img(class="image", src ="baby.png", width = "25%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:0px; margin-bottom:-10px")
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
                mathematics."
              ),
              
              tags$h2("But having a fixed mindset limits your learning potential AND goes 
                      against what we know from studies in brain and learning science."
                      ),
              br()
              ),
            
            tabPanel("Part 2",
              
              fluidRow(
                img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:0px; margin-bottom:-10px")
                ),
              
              tags$h1("2:	Your brain changes as you learn new tasks and as you practice"
                      ),
              
              p("Your brain is plastic! Not plastic like Tupperware, but plastic in the sense 
                that it is moldable, changeable, and flexible. When you take on difficult 
                mental tasks, like learning math, your brain gets busy rewiring itself in a 
                process that is analogous to the way your muscles build themselves up each time 
                you work out."
              ),
              
              tags$h2("Much like strenthening your muscles, learning new skills can be difficult
                (and painful) at first, but your brain will adjust and it will get easier."
              ),
            
              p("Scholz et al. (2009) studied the brains of people learning to juggle (Figure 1 below). 
                They found that the density of grey matter increased and the 
                structure of white matter changed in those that learned to juggle, even after 
                just a few weeks. People's brains were changing in response to new demands."
                ),
              
              #box(plotOutput(outputId="mass.plot3", width = "600px", height = "455px"), width=12, align="center")
              
              fluidRow(
                box("Figure 1", img(src ="Scholz_et_al2.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:0px; margin-bottom:20px"), width=12)
              ),
              
              tags$h3("Figure 1. A) Red areas show areas of increased grey matter density
                from scan 1 (pre-training) to scan 2 (after six weeks of training) to scan 3 (four weeks later with no additional training).  B) People
                that did not train (the control group) saw no increase in grey matter density
                during the experiment, while those training to juggle saw increases at scan 2
                and again at scan 3, even though training had stopped."
                ),
              
              p("Similarly, Woolett and Maguire (2011) examined the brains of people studying 
                for the prospective cab drivers test in London. There, prospective cab drivers
                have to pass a tremendously demanding test of the crowded and complex road 
                network. Woolett and Maguire found that people who studied for (and passed) 
                the test had developed more grey matter in their posterior hippocampi, the 
                brain region associated with spatial reasoning (Figure 2 below)."
                ),
            
              fluidRow( 
                tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
                box("Figure 2. A", leafletOutput("mymap_1", width="100%", height=300), width=6),
                box("Figure 2.B", img(src ="Woolett_Maguire_revised.png", width = "100%", height="100%", style="display: block; margin-left: auto; 
                                    margin-right: auto; margin-top:0px; margin-bottom:20px"), width=6)
                ),
              
              tags$h3("Figure 2. A) Street map of London. What a mess!  B) Results before and 
                      after subjects studied for their test of London streets. Those that 
                      studied hard and qualified (qualified trainees) had an increase in gray 
                      matter density in their hippocampi, but those that gave up on the 
                      training (non-qualified trainees) or never trained (controls) did not 
                      see an increase in gray matter. Panel A is from openstreetmap.org; panel 
                      B is modified from Woollett and Maguire 2011."
              ),
              
              p("With math, some people experience the ‘pain’ of doing new, difficult work and
                conclude that they don't have a gift for math. Unfortunately, parents and 
                teachers may accidentally reinforce this message, saying things like ‘maybe 
                math just isn’t your strength’ or ‘maybe math isn’t for you.’ But just as 
                no one is born juggling, no one is born good at math."
              ),
              
              br()
            ),
            
            tabPanel("Part 3",
              
              fluidRow(
                img(class="image", src ="brain_locked.png", width = "25%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:0px; margin-bottom:-10px")
                ),
              
              tags$h1("3: When we say we “just aren’t good” at something, we limit our own potential."
                      ),
              
              p("The idea that you can increase your own brainpower through hard work is 
                called a ‘growth mindset’. Someone with a growth mindset believes they can 
                increase their ability through effort and practice. In contrast, someone with 
                ‘fixed mindset’ believes they are inherently good or bad at certain tasks, and 
                there is little to be done about it."
              ),
              
              tags$h2("Growth and fixed mindsets aren't simply ‘good’ and ‘bad’ attitudes, but 
                instead reflect a person's ideas about how much they can improve."
                      ),
              
              p("A growth mindset is empowering because it reinforces a person's control over their 
                own growth and learning. A fixed mindset can limit your potential, such that if you 
                believe that no matter how hard you work, you won't get any better, you will 
                almost certainly give up."
              ),
              
              br()
            ),
            
            tabPanel("Summary",
              
              fluidRow(
                img(class="image", src ="brain.png", width = "25%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:0px; margin-bottom:-10px")
                ),
              
              tags$h1("What can brain research teach us about you and your ability to learn mathematics?"
                      ),
              tags$h2("1:	Expect learning to feel hard, especially at first"
                      ),
              tags$h2("2:	Your brain will rewire itself to accommodate the increased demands"
                      ),
              tags$h2("3: The only way to get better at math is to do more math"
                      ),
              
              br()
            ),
              
            tabPanel("References",
                     
              fluidRow(
              img(class="image", src ="references.png", width = "25%", style="display: block; margin-left: auto; 
              margin-right: auto; margin-top:0px; margin-bottom:-10px")
              ),
              
              tags$h1("References"
              ),
              
              tags$h2(span(tags$a(href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2770457/pdf/ukmss-27837.pdf", target="_blank",  
                                  "Scholz J, Klein MC, Behrens T, Johansen-Berg H. 2009.
                                  Training induces changes in white-matter architecture.
                                  Nature Neuroscience 12:1370-1371."))),
              
              tags$h2(span(tags$a(href="https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3268356/", target="_blank", 
                                  "Woollett K, Maguire EA. 2011. Acquiring ‘the knowledge’ of London's 
                layout drives structural brain changes. Current Biology 21:2109-2114."))),
              
              br()
      
            ))
            
            #uiOutput("Next_Previous")
            
              )), #closing the whole thing
      
      
######################################################      
      
      # STUDENT SURVEY QUIZ
     
      
tabItem(tabName = "quiz",
        fluidRow( #closing the tab panels
          tags$script("
                      $('body').mouseover(function() {
                      list_tabs3=[];
                      $('#tabBox_next_previous3 li a').each(function(){
                      list_tabs.push($(this).html())
                      });
                      Shiny.onInputChange('List_of_tab3', list_tabs3);})
                      "),
          uiOutput("Next_Previous3"),
          
          tabBox(width=12,id="tabBox_next_previous3",
                 
                 tabPanel("Instructions",
                            fluidRow(
                              
                              tags$h1("Let's Review the Material", align = "center"),
                              
                              p("Let’s explore your comprehension of the information presented in this 
                                module. This short review presents examples of 
                                fixed and growth mindsets that we may encounter in our everyday lives, when 
                                we interact with teachers, coaches, and classmates. Can you tell when 
                                someone is demonstrating a fixed versus growth mindset?"),
                              
                              tags$h2("Complete the review and see how you do. You can always re-read the module and try again.", align = "center"),
                              
                              br()
                              )
                            ),
                 
                 tabPanel("1",
                          fluidRow(
                            column(width=12, align="center",
                            radioButtons("quiz_question_1", label = h2("Teacher says to student: 'You sure are smart!'"),
                                       choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                       selected = character(), width="100%", inline =TRUE)
                            )
                            ),
                          uiOutput("quiz_question_1_lesson")
                 ),
          
                 tabPanel("2",
                          fluidRow(
                            column(width=12, align="center",
                                   radioButtons("quiz_question_2", label = h2("Teacher says to student: 'Wow... you worked really hard on this assignment!'"),
                                                choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                                selected = character(), width="100%", inline =TRUE)
                            )
                            ),
                   uiOutput("quiz_question_2_lesson")
                 ),
                 
                 tabPanel("3",
                          fluidRow(
                            column(width=12, align="center",
                                   radioButtons("quiz_question_3", label = h2("Coach says to player: 'If we practice with discipline, we will play with discipline.'"),
                                                choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                                selected = character(), width="100%", inline =TRUE)
                            )
                          ),
                          uiOutput("quiz_question_3_lesson")
                 ),
                 
                 tabPanel("4",
                          fluidRow(
                            column(width=12, align="center",
                                   radioButtons("quiz_question_4", label = h2("Coach says to player: 'You are not cut out for this sport.'"),
                                                choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                                selected = character(), width="100%", inline =TRUE)
                            )
                          ),
                          uiOutput("quiz_question_4_lesson")
                 ),
                 
                 tabPanel("5",
                          fluidRow(
                            column(width=12, align="center",
                                   radioButtons("quiz_question_5", label = h2("Player says to coach: 'I just can't hit curveballs.'"),
                                                choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                                selected = character(), width="100%", inline =TRUE)
                            )
                          ),
                          uiOutput("quiz_question_5_lesson")
                 ),
                 
                 tabPanel("6",
                          fluidRow(
                            column(width=12, align="center",
                                   radioButtons("quiz_question_6", label = h2("Student says to classmate: 'I am not good at Physics.'"),
                                                choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                                selected = character(), width="100%", inline =TRUE)
                            )
                          ),
                          uiOutput("quiz_question_6_lesson")
                 ),
                 
                 tabPanel("7",
                          fluidRow(
                            column(width=12, align="center",
                                   radioButtons("quiz_question_7", label = h2("Student says to classmate: 'Wow... you got a 93% on the Physics test? You are so lucky that Physics just makes sense to you.'"),
                                                choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                                selected = character(), width="100%", inline =TRUE)
                            )
                          ),
                          uiOutput("quiz_question_7_lesson")
                 ),
                 
                 tabPanel("8",
                          fluidRow(
                            column(width=12, align="center",
                                   radioButtons("quiz_question_8", label = h2("Young man says to friend: 'My last three girlfriends broke up with me because I don't communicate. I am doomed to be alone forever.'"),
                                                choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                                selected = character(), width="100%", inline =TRUE)
                            )
                          ),
                          uiOutput("quiz_question_8_lesson")
                 ),
                 
                 tabPanel("9",
                          fluidRow(
                            column(width=12, align="center",
                                   radioButtons("quiz_question_9", label = h2("Hi. I'm a blank question. Just here if you need me."),
                                                choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                                selected = character(), width="100%", inline =TRUE)
                            )
                          ),
                          uiOutput("quiz_question_9_lesson")
                 ),
                 
                 tabPanel("10",
                          fluidRow(
                            column(width=12, align="center",
                                   radioButtons("quiz_question_10", label = h2("Hi. I'm a blank question. Just here if you need me."),
                                                choices = list("Growth mindset" = 1, "Fixed mindset" = 2), 
                                                selected = character(), width="100%", inline =TRUE)
                            )
                          ),
                          uiOutput("quiz_question_10_lesson")
                          
          ))
        )),

######################################################      

      
      # RESULTS PAGE
#      tabItem(tabName = "results",
              # infoBoxes with fill=FALSE
#              fluidRow(
#                img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
#                    margin-right: auto; margin-top:20px; margin-bottom:-10px")
#                ),
              
#              tags$h1("Let's Review Your Results", align = "center"),

#              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
#                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim 
#                veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
#                commodo consequat. Duis aute irure dolor in reprehenderit in voluptate 
#                velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
#                cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id 
#                est laborum."
#                ),
              
#              fluidRow(
#                img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
#                    margin-right: auto")
#                ),
              
#              tags$h1("Quiz Scores", align = "center"),
              
#              fluidRow(
#                # Dynamic infoBoxes
#                infoBoxOutput("assessmentBox", width=4),
#                infoBoxOutput("quizBox"),
#                infoBoxOutput("feedbackBox")
#              ),
              
#              fluidRow(
#                box(solidHeader = TRUE, collapsible = F,
#                  plotOutput("mass.plot2"), width=12, height="100%")
#              ),
              
#              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
#                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim 
#                veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
#                commodo consequat. Duis aute irure dolor in reprehenderit in voluptate 
#                velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
#                cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id 
#                est laborum."
#              ),
              
#             br(),


#br(),
#br()
#      ),

######################################################      

# SUMMARY PAGE

        tabItem(tabName = "summary",
        
        fluidRow(
          img(class="image", src ="lifter.png", width = "25%", style="display: block; margin-left: auto; 
              margin-right: auto; margin-top:20px; margin-bottom:-10px")
          ),
        
        
        
        tags$h1("Great job completing the module!", align = "center"
        ),
        
        fluidRow(
          column(width=12, downloadButton('downloadReport', label ='Print Your Scores',
                                          style="color: #FFF; font-family: default; font-weight: 500;
                                          background-color: #1176ff; border-color: #1176ff, align: center",
                                          width="400px"
                                          ),
                 align='center')
          ),
        br(),
        
        fluidRow(
          img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
              margin-right: auto")
          ),
        
        tags$h2("Summary of main points"),
        tags$h2("1:	People are not born with the ability to perform tasks"),
        tags$h2("2:	Your brain changes as you learn new tasks and as you practice"),
        tags$h2("3: When we say we “just aren’t good” at something, we limit our own potential."),
        br(),

        fluidRow(
          img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
              margin-right: auto")
          ),
        
        fluidRow(
          img(class="image", src ="results.png", width = "25%", style="display: block; margin-left: auto; 
              margin-right: auto; margin-top:10px; margin-bottom:-10px")
          ),
        
        tags$h1("Steps to Further Your Growth Mindset", align = "center"
        ),
        
        p("Although we’d like to always maintain a growth mindset, the truth is 
          that we are all on the journey towards a more empowered approach to learning. 
          The goal is to recognize fixed mindset elements in ourselves and then 
          reflect on feedback and strategies for how to improve."
          ),
        
        tags$h2("It may not be easy or comfortable to change your mindset about learning 
          math."),
        
        p("Mindsets are cultivated over the course of our lives by the things 
          that we see, hear, learn, and experience. Mindsets can be deeply rooted 
          and can be difficult and slow (maybe even painful) to change.
          But with patience, practice, and an awareness of your own fixed-mindset 
          tendencies, you can develop a growth mindset about your own math abilities."
        ),
        
        p("Here are some steps that you can take to cultivate your growth mindset:"
        ),
        
        tags$h2("1:	This is the first step."),
        p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim 
          veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
          commodo consequat. Duis aute irure dolor in reprehenderit in voluptate 
          velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
          cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id 
          est laborum."
        ),
        tags$h2("2:	This is the second step."),
        p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim 
          veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
          commodo consequat. Duis aute irure dolor in reprehenderit in voluptate 
          velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
          cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id 
          est laborum."
        ),
        tags$h2("3: This is the third step."),
        p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim 
          veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
          commodo consequat. Duis aute irure dolor in reprehenderit in voluptate 
          velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
          cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id 
          est laborum."
        ),
        
        fluidRow(
          img(src ="line.png", width = "100%", style="display: block; margin-left: auto; 
              margin-right: auto")
          ),
        
        fluidRow(
          img(src ="BioMAAP_logo.png", width = "48%", style="display: block; margin-left: auto; 
              margin-right: auto; margin-top:20px; margin-bottom:-10px")
          ),
        
        tags$h2("This module was created by",span(tags$a(href="https://sites.google.com/site/flemingdavies/", target="_blank", "Arietta Fleming-Davies")), 
                "and",span(tags$a(href="https://www.radford.edu/content/csat/home/biology/faculty/jeremy-wojdak.html", target="_blank", "Jeremy Wojdak")),
                "as part of",span(tags$a(href="http://biomaap.org", target="_blank", "BIOMAAP."))
        ),
        
        p("BIOMAPP (Biology Students Math Attitudes and Anxiety Program) is an initiative supported with 
          funding from the",span(tags$a(href="https://www.nsf.gov", target="_blank", "National Science
          Foundation.")), "BIOMAAP aims to help undergraduate biology majors improve their 
          attitudes and decrease their anxiety towards mathematics, and thus to help faculty
          teach quantitative topics in biology. BIOMAAP is a resource for educators who are 
          looking to implement non-invasive techniques to change student attitudes and reduce 
          anxiety towards math."
        ),
        tags$h2("For more BIOMAAP educational modules and resources, click",
                span(tags$a(href="http://biomaap.org", target="_blank", "HERE"))
        ),
        
        
        br(),
        br()
        )

######### Closing tabs

      )
  )
))
