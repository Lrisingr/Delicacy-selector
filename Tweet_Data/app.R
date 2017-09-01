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
                                      selected = names(df))
                  )
              ),
    
    mainPanel(
      textInput("text", 
                label = h3("What do ypu want to search about?"), 
                value = "Enter #Tag / @user / term"),
      hr(),
      fluidRow(column(3, verbatimTextOutput("value"))),
      tabsetPanel(id = 'dataset',
                  tabPanel("df",DT::dataTableOutput("table_tweets")),
                  tabPanel("table_summary", DT::dataTableOutput("table_summary"))
          
          )
      )
    )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {
  twitter_feed<- twitter_stuff(input$text)
  twFeed_csv<- write.csv(twitter_feed,file = "savedTweets.csv")
  
  df = twitter_feed[sample(nrow(twitter_feed),500),]
    bind_Signal <- data.frame() #take tweet id from tweet dataframe and bind POST content with the tweet_id
    bind_Signal_to_df<-data.frame()
    
  #choose columns to display
    # output$table_tweets <- DT::renderDataTable({
    #                                             DT::datatable(df[, input$show_vars, drop = FALSE])})
    # 
    
    jsonSignal<-give_me_a_json_damnit(df, bind_Signal, bind_Signal_to_df)
    output$table_summary<- DT::renderDataTable({DT::datatable(jsonSignal)})
     output$table_tweets<- DT::renderDataTable({
                             DT::datatable(df,
                                           options = list(lengthMenu = c(50, 300, 500)))})
     output$value<- renderPrint(input$text)

    }
# Run the application 
shinyApp(ui = ui, server = server)

