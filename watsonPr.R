#Barking up the Watson services tree

#Authentication and Housekeeping 
library("WatsonR")
source("keys.R")
source("twitterSearch.R")
source("Utility_Functions.R")


##sets CERT Global to make a CA Cert go away - http://stackoverflow.com/questions/15347233/ssl-certificate-failed-for-twitter-in-r

options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
Sys.setlocale(locale="C") # error: input string 1 is invalid in this locale
options(warn=-1) # careful - turns off warnings  

watson.keys.display()

me <- twitteR::getUser("sharavankoushik")
length(tweets_harvey)
tweets <- laply(tweets_harvey,function(t) t$getText())
tweets<- clean.text(tweets)

Encoding(tweets) <- "UTF=8"


api_feature <- "TextGetCombinedData"
uname_pswd_NLU
output_mode <- "json"

#Performing operations on the Tweet data passing it to the services offered by Watson
text <- URLencode("I like chocolate ice cream and red boots and Molson Beer")
query <- paste(NLU_url,api_feature,"?extract=keyword,entity,concept&apikey=",uname_pswd_NLU,"&text=",text,"&outputMode=",output_mode, sep="")
response <- POST(query)
content(response)
response

url_NLU="https://gateway.watsonplatform.net/natural-language-understanding/api"
version="?version=2017-02-27"


resonse = POST(url="https://gateway.watsonplatform.net/natural-language-understanding/api/v1/analyze?version=2017-02-27&url=www.ibm.com&features=keywords,entities",
     authenticate(username_NLU,password_NLU),
     add_headers("Content-Type"="application/json"))


raw_text <- "IBM is an American multinational technology company headquartered in Armonk, New York, United States, with operations in over 170 countries"
raw_text <- "I love ice cream and unicorns! I love Vancouver"
text <- URLencode(raw_text)


response <- POST(url=paste(
  url_NLU,
  "/v1/analyze",
  version,
  "&text=",text,
  "&features=keywords,entities",
  "&entities.emotion=true",
  "&entities.sentiment=true",
  "&keywords.emotion=true",
  "&keywords.sentiment=true",
  sep=""),
  authenticate(username_NLU,password_NLU),
  add_headers("Content-Type"="application/json")
)

Signal <- content(response)

key_words <- Signal$keywords

for(i in 1:length(key_words)){
  print(paste(key_words[[i]]$text,"|| Sentiment Score : ", key_words[[i]]$sentiment$score))
}

for(i in 1:length(Signal$entities)){
  print(paste("Type:",Signal$entities[[i]]$type,
              " Text:",Signal$entities[[i]]$text,
              " SubType:",Signal$entities[[i]]$disambiguation$subtype))
}