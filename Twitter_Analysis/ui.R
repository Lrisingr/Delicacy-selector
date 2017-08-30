#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Analysis of Twitter data using IBM Watson and WatsonR Package"),
  
  # Text input to get the name of the tag / user / term 
  textInput("text", label = h3("Please Enter Text"), value = "Enter #tagname or user or term"),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value")))
    
    )
  )
  
