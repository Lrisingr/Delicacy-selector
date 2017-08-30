#UTILITY FUNCTIONS TO CLEAN UP THE DATA 

try.tolower = function(x)
{ 
  y = NA
  try_error = tryCatch(tolower(x), error=function(e) e)
  if (!inherits(try_error, "error"))
    y = tolower(x)
  return(y) 
}
## Clean up junk from text 
clean.text <- function(tweet_data)
  {
  tweet_data = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", tweet_data)
  tweet_data = gsub("@\\w+", "", tweet_data)
  tweet_data = gsub("[[:punct:]]", "", tweet_data)
  tweet_data = gsub("[[:digit:]]", "", tweet_data)
  tweet_data = gsub("http\\w+", "", tweet_data)
  tweet_data = gsub("[ \t]{2,}", "", tweet_data)
  tweet_data = gsub("^\\s+|\\s+$", "", tweet_data)
  tweet_data = gsub("amp", "", tweet_data)
  tweet_data = sapply(tweet_data, try.tolower)
  tweet_data = tweet_data[tweet_data != ""]
  names(tweet_data) = NULL
  return(tweet_data)
}