#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Wordle helper"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("App", tabName = "app"),
      menuItem("About", tabName = "about", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "app",
              fluidRow(
                titlePanel("Confirmed Letters"),
                #textInput(inputId = "attempt_1", label = NULL),
                column(2, selectInput(inputId = "letter_1", choices = c('', LETTERS), label = NULL, width = "7ch")),
                column(2, selectInput(inputId = "letter_2", choices = c('', LETTERS), label = NULL, width = "7ch")),
                column(2, selectInput(inputId = "letter_3", choices = c('', LETTERS), label = NULL, width = "7ch")),
                column(2, selectInput(inputId = "letter_4", choices = c('', LETTERS), label = NULL, width = "7ch")),
                column(2, selectInput(inputId = "letter_5", choices = c('', LETTERS), label = NULL, width = "7ch")),
              ),
              fluidRow(
                box(
                  textInput(inputId = "deadLetters", label = "Known dead letters")
                ),
                
                box(
                  title = "Possible words",
                  tableOutput(outputId = "possible_words")
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "about",
              h2("Widgets tab content")
      )
    )
  )
  
)

# # Define UI for application that draws a histogram
# shinyUI(fluidPage(
# 
#     # Application title
#     titlePanel("Wordle Helper"),
# 
#     # Sidebar with a slider input for number of bins
#     sidebarLayout(
#       
#         sidebarPanel(
#             sliderInput("bins",
#                         "Number of bins:",
#                         min = 1,
#                         max = 50,
#                         value = 30)
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#             plotOutput("distPlot")
#         )
#     )
# ))
