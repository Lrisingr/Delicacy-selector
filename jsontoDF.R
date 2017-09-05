library(rjson)
purch<- fromJSON(paste(readLines("Tweet_Data/hoepfullyworks.json"), collapse=""))

library(tidyjson)
library(jsonlite)
jsontoDF<- jsonlite::fromJSON(txt = "Tweet_Data/data.json")


