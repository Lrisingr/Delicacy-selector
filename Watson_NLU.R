give_me_a_json_damnit<- function(data_frame,bind_id_with_Signal,bind_id_with_Signal_to_df)
  {
    url_NLU="https://gateway.watsonplatform.net/natural-language-understanding/api"
    version="?version=2017-02-27"
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
      bind_id_with_Signal_to_df<-  do.call("rbind.fill", lapply(Signal, as.data.frame))
      #Just convert the Signal to JSON for future use 
      new_SignalContent <- fromJSON(Signal)
      
     key_words <- Signal$keywords  # Used not for atomic vectors i.e remove as="text" in content()
    
    #data_frame <- do.call("rbind", lapply(Signal, as.data.frame))
    #x_frame <- rbind(df_new,data_frame)
     for(i in 1:length(key_words)){
      print(paste(key_words[[i]]$text,"|| Sentiment Score : ", key_words[[i]]$sentiment$score))
    }
    for(i in 1:length(Signal$entities)){
      print(paste("Type:",Signal$entities[[i]]$type,
                  " Text:",Signal$entities[[i]]$text,
                  " SubType:",Signal$entities[[i]]$disambiguation$subtype))
    }
  }
  
  return(bind_id_with_Signal_to_df)
  
}  