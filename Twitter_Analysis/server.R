#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

#install.packages(c("devtools", "rjson", "bit64", "httr", "twitteR", "ROAuth"))

library(twitteR)
library(ROAuth)

source("keys.R")
source("Utility_Functions.R")
library(shiny)

# Define server logic required to draw a histogram
server <-shinyServer(function(input, output) {

  # You can access the value of the widget with input$text, e.g.
  output$value <- renderPrint({ input$text })
    
  })
  
