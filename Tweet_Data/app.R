
library(shiny)
library(twitteR) 
library(plyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
  title = "Tweet Analysis with Watson",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "df"',
        checkboxGroupInput("show_vars", "Columns in df to show:",
                           names(df), selected = names(df))
      )),
    mainPanel(
      textInput("text", label = h3("Text input"), value = "Enter #tag or user or term"),
      hr(),
      fluidRow(column(3, verbatimTextOutput("value"))),
      tabsetPanel(
        id = 'dataset',
        tabPanel("df", DT::dataTableOutput("mytable1")))
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  #Setup the Twitter Account and pass the tokens
  setup_twitter_oauth(APIKey,APISecret,accessToken,accessTokenSecret)
  #input text "Dosa OR Dhosa OR #Dosa OR #Dhosa
  tweets_list <- searchTwitter("Dosa OR Dhosa", n=1000,lang = "en")
  tweets_text = laply(tweets_list, function(t) t$getText())
  tweets_clean <- clean.text(tweets_text)
  
  #convert the tweets_text object to a data frame
  #make data frame
 df <- do.call("rbind", lapply(tweets_list, as.data.frame))
 df["text"] = tweets_clean

 
 
 
 # choose columns to display
 dat_tweets = df[sample(nrow(df), 1000), ]
 output$mytable1 <- DT::renderDataTable({
   DT::datatable(dat_tweets[, input$show_vars, drop = FALSE],options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
 })
 
 
 
 
 
 
 
   
  # output$tbl = DT::renderDataTable(
  #   df, options = list(lengthMenu = c(5, 30, 50), pageLength = 5)
  # )
}

# Run the application 
shinyApp(ui = ui, server = server)

