library(httr)
library(jsonlite)
url_NLU="https://gateway.watsonplatform.net/natural-language-understanding/api"
version="?version=2017-02-27"

Bind.tID.Signal<-data.frame()
#take tweet id from tweet dataframe and bind POST content with the tweet_id
bind_id_with_Signal <- data.frame() 
NLU.results<- function(data_frame)
  {
    for(i in 1:length(data_frame$text))
    {
      raw_text<- data_frame$text[i]
      text_id<- data_frame$id[i]
      encoded_text<- URLencode(raw_text)
      response <- POST(url=paste(
                                  url_NLU,
                                  "/v1/analyze",
                                  version,
                                  "&text=",encoded_text,
                                  "&features=concepts,keywords,entities,categories",
                                  "&entities.emotion=true",
                                  "&entities.sentiment=true",
                                  "&keywords.emotion=true",
                                  "&keywords.sentiment=true",
                                  sep=""),
                                  authenticate(username_NLU,password_NLU),
                                  add_headers("Content-Type"="application/json"))
      #Take the POST json and read the content as text or as default json
      if(response$status_code == 200){
      Signal <- content(response)
      Signal.asTxt<- content(response,as = "text")
      Signal.JSON <- toJSON(Signal)
      write(Signal.asTxt,file="NLU_response.txt",append = TRUE)
      #Bind each tweet ID with the sentiments/entities/categories produced from Watson
      Signal.with.id= rbind(text_id,Signal)
      Bind.tID.Signal<- rbind(bind_id_with_Signal,c(text_id,Signal.JSON))
      colnames(Bind.tID.Signal)[1]<- "Tweet_ID"
      colnames(Bind.tID.Signal)[2]<- "JsonContent"
      #Just convert the Signal to JSON for future use 
      write(Signal.JSON,file = "NLU_results.json",append = TRUE)
  }}
  return(Bind.tID.Signal)
}  