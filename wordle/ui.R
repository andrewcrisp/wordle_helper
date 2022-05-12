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
      menuItem("App", tabName = "app", icon=icon("puzzle-piece")),
      menuItem("About", tabName = "about", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "app",
              fluidRow(
                titlePanel("Confirmed Letters"),
                column(2, selectInput(inputId = "letter_1", choices = c('', LETTERS), label = NULL, width = "7ch")),
                column(2, selectInput(inputId = "letter_2", choices = c('', LETTERS), label = NULL, width = "7ch")),
                column(2, selectInput(inputId = "letter_3", choices = c('', LETTERS), label = NULL, width = "7ch")),
                column(2, selectInput(inputId = "letter_4", choices = c('', LETTERS), label = NULL, width = "7ch")),
                column(2, selectInput(inputId = "letter_5", choices = c('', LETTERS), label = NULL, width = "7ch")),
              ),
              fluidRow(
                titlePanel("Amber Letters"),
                column(2, textInput(inputId = "amber_letters_1", label = NULL, width = "15ch")),
                column(2, textInput(inputId = "amber_letters_2", label = NULL, width = "15ch")),
                column(2, textInput(inputId = "amber_letters_3", label = NULL, width = "15ch")),
                column(2, textInput(inputId = "amber_letters_4", label = NULL, width = "15ch")),
                column(2, textInput(inputId = "amber_letters_5", label = NULL, width = "15ch")),
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
              h2("Andrew's Wordle Helper"),
              p("This is just a fun project to see how far I can push Wordle solutions."),
              a("https://github.com/andrewcrisp/wordle_helper")
      )
    )
  )
)
