library(jsonlite)
library(rjson)
library(RJSONIO)

format.JSON<- function(readFrom, writeTo){
  raw <- readLines(readFrom,encoding="UTF-8")
# get rid of the "/* 0 */" lines
json <- grep("^/\\* [0-9]* \\*/", raw, value = TRUE, invert = TRUE)
# add missing comma after }
n <- length(json)
json[-n] <- gsub("^}$", "},", json[-n])
# add brakets at the beginning and end
JSON.complete<- c("[", json, "]")
write(JSON.complete,file = writeTo,append = TRUE)

}

readFrom = "Tweet_Data/NLU_response.txt"
writeTo = "Tweet_Data/Final_JSON.json"
format.JSON(readFrom, writeTo)

jsontoDF<- jsonlite::fromJSON(txt = writeTo)
jsontoDF<-subset(jsontoDF,is.na(jsontoDF$code))

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
 word_matrix <- data.frame()
 word_matrix_1 <- data.frame()
create_Keyword_matrix<- function(df){
  
  for(i in 1:length(df)){
    if( !is.null(df[[i]]) & length(df[[i]])!=0){
      tweet_keyword_vector <- as.data.frame(flatten_Tweet_list(df[[i]]))
      word_matrix<- rbind(word_matrix,tweet_keyword_vector)
      word_matrix_1<- rbindlist(word_matrix_1,tweet_keyword_vector, fill=TRUE,use.names = FALSE)
    }
    
  }
  return(word_matrix_1)
}

keywords_matrix<- create_Keyword_matrix(flattended.keywordarr)

