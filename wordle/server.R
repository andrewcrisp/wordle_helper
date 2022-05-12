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
  
  all_letters <- data.frame('letter'= letters)
  row.names(all_letters) <- letters
  for (letter in letters) {
    num_words <- words %>% filter(grepl(letter, word)) %>% count()
    all_letters[letter, "num_words"] <- num_words$n
  }
  
  short_words <- short_words %>% 
    rowwise(word) %>%
    mutate(cum_letters = sum(all_letters[strsplit(word, split = "")[[1]],"num_words"])) %>%
    mutate(cum_unique_letters = sum(all_letters[unique(strsplit(word, split = "")[[1]]),"num_words"])) %>%
    ungroup()
  
  possible_words <- reactive({
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
    short_words <- short_words %>%
      arrange(desc(cum_unique_letters))
    return(short_words)
  })
  
  #output$possible_words <- renderTable(head(possible_words()))
  output$possible_words <- renderDataTable(possible_words(),
                                           options = list(
                                             searching = FALSE,
                                             pageLength = 10
                                           ))
})
