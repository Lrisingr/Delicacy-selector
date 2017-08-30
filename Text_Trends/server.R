library(shiny) 
library(tm)
library(wordcloud)
library(twitteR)
shinyServer(function(input, output, session)
  {
  setup_twitter_oauth(APIKey,APISecret,accessToken,accessTokenSecret)
  token <- get("oauth_token", twitteR:::oauth_cache) #Save the credentials info
  token$cache()
  output$currentTime <- renderText({invalidateLater(1000, session) #Here I will show the current time
    paste("Current time is: ",Sys.time())})
  observe({
    invalidateLater(60000,session)
    count_positive = 0
    count_negative = 0
    count_neutral = 0
    positive_text <- vector()
    negative_text <- vector()
    neutral_text <- vector()
    vector_users <- vector()
    vector_sentiments <- vector()
    tweets_result = ""
    tweets_result = searchTwitter("word-or-expression-to-evaluate") #Here I use the searchTwitter function to extract the tweets
    for (tweet in tweets_result)
      {
        print(paste(tweet$screenName, ":", tweet$text))
        vector_users <- c(vector_users, as.character(tweet$screenName)); #save the user name
        
    }
    df_users_sentiment <- data.frame(vector_users) 
    output$tweets_table = renderDataTable(df_users_sentiment)
})
})
  