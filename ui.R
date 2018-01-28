# Template for BIOMAAP educational modules
# January 15th, 2018
# Created by Impact Media Lab

######### Load required packages

library(shiny)
library(shinydashboard)
library(leaflet)

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
      menuItem("Mindset Assessment", tabName = "assessment", icon = icon("pencil-square")),
      menuItem("Assessment Results", tabName = "assessment_results", icon = icon("bar-chart")),
      menuItem("Lesson", tabName = "lesson", icon = icon("graduation-cap")),
      menuItem("Quiz", tabName = "quiz", icon = icon("question-circle")),
      menuItem("Quiz Results", tabName = "results", icon = icon("bar-chart"))
    )
  ),

#BODY
# Boxes need to be put in a row (or column)  
  dashboardBody(

# Adding custom CSS    
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css")
    ),

# Overriding color of "primary" status on boxes    
    tags$style(HTML("
                    .box.box-solid.box-primary>.box-header {
                    color:#ffffff;
                    background:#ffffff
                    }
                    
                    .box.box-solid.box-primary{
                    border-bottom-color:#9999cc;
                    border-left-color:#9999cc;
                    border-right-color:#9999cc;
                    border-top-color:#9999cc;
                    }
                    
                    ")),  
    
    tabItems(
    
      
######################################################      
# BUILDING THE PAGES #
######################################################      



      # WELCOME PAGE
      tabItem(tabName = "welcome",
              
            fluidRow(
              img(src ="placeholder.png", width = "50%", style="display: block; margin-left: auto; 
                  margin-right: auto; margin-top:40px; margin-bottom:0px")
              ),

            tags$h1("Cultivating Your Growth Mindset", align = "center"
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

      
######################################################      


      # MINDSET ASSESSMENT PAGE
      tabItem(tabName = "assessment",
              uiOutput('ui')
      ),

      
######################################################      


# MINDSET ASSESSMENT RESULTS PAGE
tabItem(tabName = "assessment_results",
        fluidRow(
          img(src ="placeholder.png", width = "50%", style="display: block; margin-left: auto; 
              margin-right: auto; margin-top:40px; margin-bottom:0px")
          ),
        
        tags$h1("Let's Review Your Results", align = "center"),
        
        p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim 
          veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
          commodo consequat. Duis aute irure dolor in reprehenderit in voluptate 
          velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
          cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id 
          est laborum."
        ),
        
        fluidRow(
          box(status = "primary", solidHeader = TRUE, collapsible = F, 
              plotOutput("mass.plot"), width=12, height="100%")
        ),
        
        p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim 
          veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
          commodo consequat. Duis aute irure dolor in reprehenderit in voluptate 
          velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
          cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id 
          est laborum."
        ),
        
        br(),
        br()
),


######################################################      

      
      # LESSON ON TOPIC PAGE
      tabItem(tabName = "lesson",
          tabBox(width=12,id="tabBox_next_previous",
            tabPanel("Video",
                     
              tags$iframe(class="video", width= "560", height= "315", 
                          src="https://www.youtube.com/embed/KUWn_TJTrnU?rel=0&amp;controls=0&amp;showinfo=0", 
                          frameborder="0", allow="autoplay; encrypted-media", allowfullscreen=T
              ),
             
               tags$h1("Cultivating a Growth Mindset", align = "center"
                       ),
              
              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim 
                veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
                commodo consequat. Duis aute irure dolor in reprehenderit in voluptate 
                velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
                cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id 
                est laborum."
              ),
              
              br(),
              br()
            ),
            
              tabPanel("Outline",
              fluidRow(
                img(src ="placeholder.png", width = "50%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:0px")
                ),
              tags$h1("Outline"),
              tags$h2("1:	People are not born with the ability to perform tasks"),
              tags$h2("2:	Your brain changes as you learn new tasks and as you practice"),
              tags$h2("3: When we say we “just aren’t good” at something, we limit our own potential."),
              
              br(),
              br()
              
              ),
            
              tabPanel("Lesson1",
              fluidRow(
                img(src ="placeholder.png", width = "50%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:0px")
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
              br(),
              br()
              ),
            
            tabPanel("Lesson2",
              
              fluidRow(
                img(src ="placeholder.png", width = "50%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:0px")
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
              
              fluidRow(
                box("Figure 1", status = "primary", solidHeader = TRUE, img(src ="Scholz_et_al.png", width = "100%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:10px; margin-bottom:0px"), width=12)
              ),
              
              tags$h3("Figure 1. A) Outlined white areas show areas of increased grey matter density
                from scan 1 (pre-training) to scan 2 (after six weeks of training).  B) People
                that did not train (the control group) saw no increase in grey matter density
                during the experiment, while those training to juggle saw increases at scan 2,
                and again four weeks later with no additional training (scan 3)."
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
                box("Figure 2. A", status = "primary", solidHeader = TRUE, leafletOutput("mymap_1", width="100%", height=300), 
                  width=12)
                ),
              
              #fluidRow(
              #  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
                
                #column(6,box(leafletOutput("mymap_1", width="100%", height=300), 
                             #plotOutput("Traits_on_trees_1", width = "100%", height = "300px"),
                             #plotOutput("trait_binary_bar_1", width = "100%", height = "300px")
                            # width=12)),
                #column(6, img(src ="Woolett_Maguire_revised.png", width="90%", height=320))
              #),
              
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
              
              br(),
              br()
            ),
            
            tabPanel("Lesson3",
              
              fluidRow(
                img(src ="placeholder.png", width = "50%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:0px")
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
                img(src ="placeholder.png", width = "50%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:0px")
                ),
              
              tags$h5("Summary"
              ),
              
              tags$h1("What can brain research teach us about you and your ability to learn mathematics?"
                      ),
              tags$h2("1:	Expect learning to feel hard, especially at first"
                      ),
              tags$h2("2:	Your brain will rewire itself to accommodate the increased demands"
                      ),
              tags$h2("3: The only way to get better at math is to do more math"
                      ),
              
              br(),
              br()
            ),
              
            tabPanel("References",
                     
              fluidRow(
              img(src ="placeholder.png", width = "50%", style="display: block; margin-left: auto; 
              margin-right: auto; margin-top:40px; margin-bottom:0px")
              ),
              
              tags$h1("References"
              ),
              tags$h2("Scholz J, Klein MC, Behrens T, Johansen-Berg H. 2009. Training 
                induces changes in white-matter architecture. Nature Neuroscience 
                12:1370-1371."
              ),
              tags$h2("Woollett K, Maguire EA. 2011. Acquiring ‘the knowledge’ of London's 
                layout drives structural brain changes. Current Biology 21:2109-2114."
              ),
              
              br(),
              br()
      
            )), #closing the tab panels
          tags$script("
    $('body').mouseover(function() {
                      list_tabs=[];
                      $('#tabBox_next_previous li a').each(function(){
                      list_tabs.push($(this).html())
                      });
                      Shiny.onInputChange('List_of_tab', list_tabs);})
                      "),
          uiOutput("Next_Previous")
              ), #closing the whole thing
      
      
######################################################      
      
      # STUDENT SURVEY QUIZ
      tabItem(tabName = "quiz",
              uiOutput('ui2')
      ),
      
######################################################      

      
      # RESULTS PAGE
      tabItem(tabName = "results",
              # infoBoxes with fill=FALSE
              fluidRow(
                img(src ="placeholder.png", width = "50%", style="display: block; margin-left: auto; 
                    margin-right: auto; margin-top:40px; margin-bottom:0px")
                ),
              
              tags$h1("Let's Review Your Results", align = "center"),

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
              
              tags$h1("Results from the quiz", align = "center"),
              
              fluidRow(
                # Dynamic infoBoxes
                infoBoxOutput("assessmentBox", width=4),
                infoBoxOutput("quizBox"),
                infoBoxOutput("feedbackBox")
              ),
              
              fluidRow(
                box(solidHeader = TRUE, collapsible = F,
                  plotOutput("mass.plot2"), width=12, height="100%")
              ),
              
              p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim 
                veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea 
                commodo consequat. Duis aute irure dolor in reprehenderit in voluptate 
                velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
                cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id 
                est laborum."
              ),
              
              br(),
              br(),
              br()
       )
      )
  )
))
