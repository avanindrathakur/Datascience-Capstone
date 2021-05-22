suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))
suppressWarnings(library(rsconnect))

#Loading the Data

quadgram <- readRDS("quadgram.RData");
trigram <- readRDS("trigram.RData");
bigram <- readRDS("bigram.RData");
mesg <<- ""


#Cleaning the Data and Prediction App

wordPredict <- function(x) {
  inputNew <- removeNumbers(removePunctuation(tolower(x)))
  userInput <- strsplit(inputNew, " ")[[1]]
  
  if (length(userInput)>= 3) {
    userInput <- tail(userInput,3)
    if (identical(character(0),head(quadgram[quadgram$unigram == userInput[1] & quadgram$bigram == userInput[2] & quadgram$trigram == userInput[3], 4],1))){
      wordPredict(paste(userInput[2],userInput[3],sep=" "))
    }
    else {mesg <<- "4 grams is used"; head(quadgram[quadgram$unigram == userInput[1] & quadgram$bigram == userInput[2] & quadgram$trigram == userInput[3], 4],1)}
  }
  else if (length(userInput) == 2){
    userInput <- tail(userInput,2)
    if (identical(character(0),head(trigram[trigram$unigram == userInput[1] & trigram$bigram == userInput[2], 3],1))) {
      wordPredict(userInput[2])
    }
    else {mesg<<- "3 grams is used"; head(trigram[trigram$unigram == userInput[1] & trigram$bigram == userInput[2], 3],1)}
  }
  else if (length(userInput) == 1){
    userInput <- tail(userInput,1)
    if (identical(character(0),head(bigram[bigram$unigram == userInput[1], 2],1))) {mesg<<-"The word with the highest frequency is returned"}
    else {mesg <<- "2 grams is used."; head(bigram[bigram$unigram == userInput[1],2],1)}
  }
}

#Final Server 

shinyServer(function(input, output) {
  output$prediction <- renderPrint({
    result <- wordPredict(input$inputString)
    output$method <- renderText({mesg})
    result
  });
  
  output$answer <- renderText({
    input$inputString});
}
)