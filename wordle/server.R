#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)

source('./utils.R')

shinyServer(function(input, output) {
  
  words <- load_words()
  words <- limit_word_size(words = words, num_chars = 5)
  
  short_words <- words

  possible_words <- reactive({
    short_words <- words
    short_words <- limit_letter(short_words, input$letter_1, 1)
    short_words <- limit_letter(short_words, input$letter_2, 2)
    short_words <- limit_letter(short_words, input$letter_3, 3)
    short_words <- limit_letter(short_words, input$letter_4, 4)
    short_words <- limit_letter(short_words, input$letter_5, 5)
    
    short_words <- limit_amber_letter(short_words, input$amber_letters_1, 1)
    short_words <- limit_amber_letter(short_words, input$amber_letters_2, 2)
    short_words <- limit_amber_letter(short_words, input$amber_letters_3, 3)
    short_words <- limit_amber_letter(short_words, input$amber_letters_4, 4)
    short_words <- limit_amber_letter(short_words, input$amber_letters_5, 5)
    
    dead_letters <- unique(strsplit(input$deadLetters, split = "")[[1]])
    short_words <- remove_dead_letters(short_words, dead_letters)
    return(short_words)
  })
  
  output$possible_words <- renderTable(head(possible_words()))
})
