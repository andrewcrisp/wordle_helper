# Andrew's Wordle Helper

A shiny app to help with Wordle.  

## To use the app

This will help find the most valuable words to use based on letter prevalence.  
Play your starting word on Wordle.  Then, fill in the green letters when known,
the amber letters in each spot, and the dead letters.  The app will take
that information and return a list of valid English words and their associated 
"value".  The "value" of a word is the sum of each letter's occurence count in
the English wordlist.

I used the wordlist from dwyl:
https://github.com/dwyl/english-words

## Getting started with development

- Clone the project.
- Run renv::restore() to rebuild the environemnt from the renv.lock file.
- Run the shiny app.  I use Rstudio, so I just use the Run App button.  If you 
are using something else, you at least should be able to invoke 
```shiny::runApp("./wordle/")```.