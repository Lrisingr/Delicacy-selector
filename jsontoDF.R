library(rjson)
purch<- fromJSON(paste(readLines("Tweet_Data/feed_col.json"), collapse=""))

library(tidyjson)

cab<-tidyjson::read_json("Tweet_Data/CopyOffeed_col.json")