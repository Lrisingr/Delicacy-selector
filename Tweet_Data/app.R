library(shiny)
library(twitteR) 
library(plyr)
library(httr)
library(RJSONIO)
source("../twitter_stuff.R")
source("../Watson_NLU.R")


# Define UI for application that draws a histogram
ui <- fluidPage(
    title = "Tweet Analysis with Watson",
    sidebarLayout(
          sidebarPanel(
              conditionalPanel('input.dataset === "df"',
                  checkboxGroupInput("show_vars", 
                                     "Tweet DB columns",
                                      names(df), 
                                      selected = names(df)))),
    
    mainPanel(
      textInput("text", 
                label = h3("What do you want to search about?"), 
                value = " "),
      actionButton(inputId = "action",label = "Go"),
      hr(),
      fluidRow(column(3, verbatimTextOutput("value"))),
      tabsetPanel(id = 'dataset',
                  tabPanel("table_summary", DT::dataTableOutput("table_summary")),
                  tabPanel("df",DT::dataTableOutput("table_tweets"))
                 )
      )
    )
    )

searchTerm <- "#food OR Food"
# Define server logic required to draw a histogram
server <- function(input, output) {
  twitt_df <- twitter_stuff(searchTerm,1000)
  twFeed_csv<- write.csv(twitt_df,file = "savedTweets.csv",append = TRUE)
  df = twitt_df[sample(nrow(twitt_df),500),]
  bind_Signal <- data.frame() #take tweet id from tweet dataframe and bind POST content with the tweet_id
  bind_Signal_to_df<-data.frame()
  #choose columns to display
    jsonSignal<-give_me_a_json_damnit(df, bind_Signal, bind_Signal_to_df)
    write.table(x = jsonSignal, file= "jsonSignal_TweetID.csv",append = TRUE,row.names = FALSE ,quote = FALSE)
    output$table_summary<- DT::renderDataTable({DT::datatable(jsonSignal)})
    output$table_tweets<- DT::renderDataTable({DT::datatable(df,
                          options = list(lengthMenu = c(50, 300, 500)))})
     output$value <- renderPrint("Done") 
    }
# Run the application 
shinyApp(ui = ui, server = server)

