library(jsonlite)
jsontoDF<- jsonlite::fromJSON(txt = "Tweet_Data/data.json")

# call flatten_tweet_list and create_Keyword_matrix on jsontoDF

#pass tweet_list$keyword data frame and get individual values , 
# before passing this function to  mat<-jsontoDF$keywords, jsontoDF$sentiment and jsontoDF$emotion are lists nested within jsontoDF$keywords list , so to flatenn everything for each keyword in the specific tweet use the below function

flatten_Tweet_list <- function(df){  
  morelists <- sapply(df, function(xprime) class(xprime)[1]=="list")
  out <- c(df[!morelists], unlist(df[morelists], recursive=FALSE))
  if(sum(morelists)){ 
    Recall(out)
  }else{
    return(out)
  }
}
 keyword_arr <- jsontoDF$keywords 
 
# where df is dataframe containing result from watson NLU json 

# tweet_keyword_vector_1<- as.data.frame(flatten_Tweet_list( keyword_arr[[1]] ))
# tweet_keyword_vector_2<- as.data.frame(flatten_Tweet_list( keyword_arr[[2]] ))
# create_Keyword_matrix <- rbind(tweet_keyword_vector_1, tweet_keyword_vector_2)
# create_Keyword_matrix <- rbind(create_Keyword_matrix, tweet_keyword_vector_3)


# Need to assign a unique ID for each word(string) 
#and it's respective tweet ID where that word came from

create_Keyword_matrix<- function(df){
  word_matrix <- data.frame()
  for(i in 1:length(df)){
    if( !is.null(df[[i]]) & length(df[[i]])!=0){
      tweet_keyword_vector <- as.data.frame(flatten_Tweet_list(df[[i]]))
      word_matrix<- rbind(word_matrix,tweet_keyword_vector)
    }
  }
  return(word_matrix)
}


keywords_matrix<- create_Keyword_matrix(keyword_arr)
