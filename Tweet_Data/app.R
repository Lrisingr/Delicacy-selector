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


# Define server logic required to draw a histogram
server <- function(input, output) {
  twitt_df <- twitter_stuff(1000)

  #what do i need? 
  #i need search term the size of twitter results, and bind those two and save as csv
  #searchTermVector <- rep(searchMem(),each=length(twitter_results)) #produces a column vector of searchMem() repeated the length times of twitter_results

  
  
  
  #Now how do i want the tweets to be stored in the csv? It's better to store the results along with the search term,
  # i.e bind the search term to the feed and save it as csv
  
    twFeed_csv<- write.csv(twitt_df,file = "savedTweets.csv",append = TRUE)
    df = twitt_df[sample(nrow(twitt_df),500),]
    bind_Signal <- data.frame() #take tweet id from tweet dataframe and bind POST content with the tweet_id
    bind_Signal_to_df<-data.frame()
    
  #choose columns to display
    jsonSignal<-give_me_a_json_damnit(twitt_df, bind_Signal, bind_Signal_to_df)
    output$table_summary<- DT::renderDataTable({DT::datatable(jsonSignal)})
     output$table_tweets<- DT::renderDataTable({DT::datatable(df,options = list(lengthMenu = c(50, 300, 500)))})
    }
# Run the application 
shinyApp(ui = ui, server = server)

