give_me_a_json_damnit<- function(data_frame,bind_id_with_Signal,bind_id_with_Signal_to_df)
  {
    url_NLU="https://gateway.watsonplatform.net/natural-language-understanding/api"
    version="?version=2017-02-27"
    jsonFile = "jsonFile.json"
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
                                  "&features=keywords,entities,categories",
                                  "&entities.emotion=true",
                                  "&entities.sentiment=true",
                                  "&keywords.emotion=true",
                                  "&keywords.sentiment=true",
                                  sep=""),
                                  authenticate(username_NLU,password_NLU),
                                  add_headers("Content-Type"="application/json"))
      #Take the POST json and read the content as text or as default json
      Signal <- content(response)
      #Bind each tweet ID with the sentiments/entities/categories produced from Watson
      #bind_id_with_Signal= rbind(text_id,Signal)
      new_SignalContent <- toJSON(Signal)
      
      bind_id_with_Signal_to_df<- rbind(bind_id_with_Signal,c(text_id,new_SignalContent))
      colnames(bind_id_with_Signal_to_df)[1]<- "Tweet_ID"
      colnames(bind_id_with_Signal_to_df)[2]<- "JsonContent"
      
      #Just convert the Signal to JSON for future use 
      write(new_SignalContent,file = "feed.json",append = TRUE,sep = "")
  }
  return(bind_id_with_Signal_to_df)
}  