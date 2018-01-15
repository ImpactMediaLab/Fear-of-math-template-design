
   
library(shiny)
library(shinydashboard)
library(scales)
#library(MASS)
#data(beav1)

library(shinydashboard)



shinyUI(dashboardPage(
  dashboardHeader(title = "Testing the value of a growth mindset", titleWidth = 400),
  dashboardSidebar(
    sidebarMenu(
      menuItem("intro", tabName = "intro", icon = icon("dashboard")),
      menuItem("exam", tabName = "exam", icon = icon("dashboard")),
      menuItem("lesson", tabName = "lesson", icon = icon("dashboard")),
      menuItem("results", tabName = "results", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
    tabItem(tabName = "intro",
             fluidRow(
               imageOutput("experimental_design", height = 430, width = 400)
             ),
             p("",span(tags$a(href = "http://benfry.com/projects", "Check out Ben Fry's gallary", style = "color:navy")), align = "right"),
             
             tags$h1("Using quantitative thought to analyze data"),
             tags$h4(p("Created by", span(tags$a(href = "http://www.colorado.edu/eeb/tuff/Tuff_et_al./Ty_Tuff.html", "Ty Tuff", style = "color:black")), "and Kika Tuff"  ), align="center"),
             ### tags$iframe(id="iframe1", src="http://player.vimeo.com/video/21172499?"),
             
            p("The purpose of this lab is to introduce you to statistical analysis tools (in this case R) and to give you a framework that will help you consider data and data analysis based on the process of quantitative thinking. This will become important both as you move forward with your independent projects and in your future academic and professional careers. This shinyapps (https://www.shinyapps.io) online workflow application will help facilitate the learning process without the distraction of having to learn how to code.")
      
      ),
      tabItem(tabName = "exam",
               fluidRow(
                 imageOutput("Big_Data_Traffic", height = 430, width = 400)
               ),
               p("",span(tags$a(href = "http://benfry.com/projects", "Check out Ben Fry's gallary", style = "color:navy")), align = "right"),
               
               tags$h1("Using quantitative thought to analyze data"),
               tags$h4(p("Created by", span(tags$a(href = "http://www.colorado.edu/eeb/tuff/Tuff_et_al./Ty_Tuff.html", "Ty Tuff", style = "color:black")), "and Kika Tuff"  ), align="center"),
               ### tags$iframe(id="iframe1", src="http://player.vimeo.com/video/21172499?"),
               
               p("The purpose of this lab is to introduce you to statistical analysis tools (in this case R) and to give you a framework that will help you consider data and data analysis based on the process of quantitative thinking. This will become important both as you move forward with your independent projects and in your future academic and professional careers. This shinyapps (https://www.shinyapps.io) online workflow application will help facilitate the learning process without the distraction of having to learn how to code.")
               
        ),
            # First tab content
      tabItem(tabName = "lesson",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "results",
              h2("Widgets tab content")
      )
    ))
  ))
  
  