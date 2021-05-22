
suppressWarnings(library(shiny))
suppressWarnings(library(markdown))
suppressWarnings(library(shinyBS))
suppressWarnings(library(shinythemes))
shinyUI(navbarPage("Data Science Capstone: Final Project", theme = shinytheme("sandstone"),
                   tabPanel("Next Word Prediction",
                            sidebarLayout(
                              sidebarPanel(
                                helpText("Enter a word or a sequence of words"),
                                textInput("inputString", "Input",value = "")
                              ),
                              mainPanel(
                                h2("Prediction"),
                                verbatimTextOutput("prediction"),
                                strong("User's sequence"),
                                tags$style(type='text/css', '#answer {background-color:color: white;}'), 
                                textOutput('answer'),
                                br(),
                                strong("Type of dataset used"),
                                tags$style(type='text/css', '#method {background-color:color: white;}'),
                                textOutput('method')
                              )
                            )
                   ),
                   
                   tabPanel(
                     
                     "Help",
                     
                     p("A Shiny app has been developped to take as input a phrase (multiple words) in a text box input and to output a prediction of the next word."),
                     
                     tags$div("The method for the prediction of next word:",
                              tags$ul(
                                tags$li(strong("First,"), "Generation of bigram.RData, trigram.RData and quadgram.RData from the milestone report"),
                                tags$li(strong("Then,"), "For 3 words, quadgram.RData is used"),
                                tags$li(strong("Else,"), "For 2 words trigram.RData is used"),
                                tags$li(strong("Else,"), "For single word, bigram.RData is used"),
                                tags$li(strong("Else,"), "Lastly highest frequency word is returned"),
                                tags$li(strong("Finally,", "Final prediction"))
                              ),
                              
                              tableOutput("dataStructure")
                              
                     )
                     
                   ),
                   
                   
                   
                   tabPanel(
                     
                     "Description",
                     
                     h3("Data Science Capstone: Final project"),
                     
                     h3("Author: Avanindra Thakur - 15th of May, 2021"),
                     
                     br(),
                     
                     p("This application is a web application using R and ",
                       a(href = "https://shiny.rstudio.com/", "Shiny library"),
                       "corresponding to the last assignment from,",
                       a(href = "https://www.coursera.org/learn/data-science-project", "Data Science Capstone from Coursera")
                     ),
                     
                     p("Source code is available at",
                       a(href = "https://github.com/avanindrathakur/Datascience-Capstone",
                         "https://github.com/avanindrathakur/Datascience-Capstone")
                     )
                     
                   )
                   
                   
)
)