
#install.packages(c("devtools", "rjson", "bit64", "httr", "twitteR", "ROAuth"))

## TWITTER

library(twitteR)
library(RJSONIO)
library(stringr)
library(tm)
library(plyr)
library(ROAuth)  # if you get this error - need this lib Error: object 'OAuthFactory' not found

## WATSON
library(RCurl) # General Network Client Interface for R
library(rjson) # JSON for R
library(jsonlite) # JSON parser
library(XML) # XML parser
library(httr) # Tools for URLs and HTTP
library(stringr)
library(data.table) # data shaping
library(reshape2) # data shaping
library(tidyr) # data cleaning
library(dplyr) # data cleaning
library(png) # for the presenting of images
library(plyr)
#Gather Keys and variables

source("keys.R")
source("Utility_Functions.R")
source("Twitter_Analysis/server.R")
source("Twitter_Analysis/ui.R")



#Setup the Twitter Account and pass the tokens
setup_twitter_oauth(APIKey,APISecret,accessToken,accessTokenSecret)

#Lets do the search using console first, later retrieve the search object from the Shiny input text box 
#when user enter a term/hashtag/username pass it to the function and give the results on all forms i.e ex: "Dosa" then convert it

## 6 types of entities in Objects #media
                                  #urls
                                  #user_mentions
                                  #hashtags
                                  #symbols
                                  #extended_entities

# The data about the location is not necessarily that the tweeet is posted from but also location mentioned in a tweet

tweets_list <- searchTwitter("Dosa OR Dhosa OR #Dosa OR #Dhosa", n=1000,lang = "en")
tweets_text = laply(tweets_list, function(t) t$getText())
tweets_clean <- clean.text(tweets_text)

#convert the tweets_text object to a data frame
#make data frame
df <- do.call("rbind", lapply(tweets_list, as.data.frame))
df["text"] = tweets_clean

##Can we get a map of resources from where the users tweeted and how many of them are from Android / Apple / Websites

alchemy_url <- "https://watson-api-explorer.mybluemix.net/alchemy-api/calls/"
api_feature<- "text/TextGetCombinedData"

