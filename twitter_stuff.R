#add twitter keyword as input parameter from shiny textbox at later stage 
library(twitteR)
library(plyr)


twitter_stuff<- function(searchTerm, numTweets){
  #Setup the Twitter Account and pass the tokens
  setup_twitter_oauth(APIKey,APISecret,accessToken,accessTokenSecret)
  #input text "Dosa OR Dhosa OR #Dosa OR #Dhosa
  tweets_list <- twitteR::searchTwitteR(searchString = searchTerm, n=numTweets,lang = "en")
  #getUser<- twitteR::getUser("@Deals4Every")
  tweets_text = laply(tweets_list, function(t) t$getText())
  tweets_clean <- clean.text(tweets_text)
  #convert the tweets_text object to a data frame
  #make data frame
  df <- do.call("rbind", lapply(tweets_list, as.data.frame))
  df["text"] = tweets_clean
  return(df)
}


