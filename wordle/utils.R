library(dplyr)

get_data_dir <- function(dir_path = './data') {
  if (!dir.exists(dir_path)){
    dir.create(dir_path, recursive = TRUE)
  }
  return(dir_path)
}

limit_amber_letter <- function(words, raw_amber_letters, position) {
  amber_letters <- unique(strsplit(raw_amber_letters, split = "")[[1]])
  if(length(amber_letters > 0)){
    amber_letters_regex <- paste0("[", paste0(amber_letters, collapse = "|"), "]")

    neg_grep <- grep_pattern <- c(".", ".", ".", ".", ".")
    neg_grep[position] <- amber_letters_regex
    neg_grep <- paste0(neg_grep, collapse = "")
    words <- words %>%
      filter(!grepl(neg_grep, word))
    
    #pos_grep <- paste0('.*', amber_letters_regex, '.*', sep='')
    pos_grep <- paste0(paste0('(?=.*', amber_letters, ')'), collapse = '')
    words <- words %>%
      filter(grepl(pos_grep, word, perl = TRUE))
    
  }
  return(words)
}

limit_letter <- function(words, letter, position){
  if(toupper(letter) %in% LETTERS){
    grep_pattern <- c(".", ".", ".", ".", ".")
    grep_pattern[position] <- tolower(letter)
    grep_pattern <- paste0(grep_pattern, collapse = "")
    words <- words %>%
      filter(grepl(grep_pattern, word))
  }
  return(words)
}

limit_word_size <- function(words, num_chars = 5){
  words <- words %>%
    mutate(len = nchar(word)) %>%
    filter(len == num_chars) %>%
    select(-len)
  return(words)
}

load_words <- function() {
  data_dir <- get_data_dir()
  url <- "https://github.com/dwyl/english-words/raw/master/words_alpha.txt"
  
  #words_zip_file <- file.path(data_dir, "words_alpha.zip")
  words_file <- file.path(data_dir, "words_alpha.txt")
  if (!file.exists(words_file)) {
    #if (!file.exists(words_zip_file)) {
    #  download.file(url, words_zip_file)
    #}
    download.file(url, words_file)
  }
  words <- read.delim2(words_file, header=FALSE, sep='\n')
  colnames(words) <- "word"
  return(words)
}

remove_dead_letters <- function(words, dead_letters) {
  if(length(dead_letters > 0)){
    grep_string <- paste0(dead_letters, collapse = "|")
    words <- words %>%
      filter(!grepl(tolower(grep_string), word))
  }
  return(words)
}