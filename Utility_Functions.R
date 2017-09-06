library(digest)


#UTILITY FUNCTIONS TO CLEAN UP THE DATA

# sets CERT Global to make a CA Cert go away
# http://stackoverflow.com/questions/15347233/ssl-certificate-failed-for-twitter-in-r
housekeeping <- function(){
  options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
  Sys.setlocale(locale="C") # error: input string 1 is invalid in this locale
  options(warn=-1) # careful - turns off warnings
}

try.tolower <- function(x){
  y = NA
  try_error = tryCatch(tolower(x), error=function(e) e)
  if (!inherits(try_error, "error"))
    y = tolower(x)
  return(y)
}
## Clean up junk from text
clean.text <- function(tweet_data){
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

# Encryption function
#write encrypted data to a file
write.aes <- function(df,filename, key) {
  require(digest)
  zz <- textConnection("out","w")
  write.csv(df,zz, row.names=F)
  close(zz)
  out <- paste(out,collapse="\n")
  raw <- charToRaw(out)
  raw <- c(raw,as.raw(rep(0,16-length(raw)%%16)))
  aes <- AES(key,mode="ECB")
  aes$encrypt(raw)
  writeBin(aes$encrypt(raw),filename)
}
# read encypted data frame from file
read.aes <- function(filename,key) {
  require(digest)
  dat <- readBin(filename,"raw",n=1000)
  aes <- AES(key,mode="ECB")
  raw <- aes$decrypt(dat, raw=TRUE)
  txt <- rawToChar(raw[raw>0])
  read.csv(text=txt, stringsAsFactors = F)
}

key <- as.raw( sample(1:16, 16))
save(key,file = "key.RData")
