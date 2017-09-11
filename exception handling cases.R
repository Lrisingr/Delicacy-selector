df.lst <- list(A=data.frame(a=c(1,2),b=c(5,4),d=c(2,3),e=c(1,1),f=c(1,2),g=c(1,2)),
               B=data.frame(a=c(1,2),b=c(3,2),d=c(2,3)),
               C=data.frame(a=c(1,2),b=c(4,3),d=c(1,2),e=c(1,3))
)

max(sapply(df.lst,ncol))

col <- unique(unlist(sapply(df.lst, names)))
col

### Fill the missing columns with NA
df.lst <- lapply(df.lst, function(df) {
  df[, setdiff(col, names(df))] <- NA
  df
})

### Then Bind it
do.call(rbind, df.lst)


df.2nd<- keyword_arr

max(sapply(df.2nd,ncol))
library(dplyr)
df.3rd<- bind_rows(df.2nd)

col <- unique(unlist(sapply(df.2nd, names)))
col

### Fill the missing columns with NA
df.2nd <- lapply(df.2nd, function(df) {
  df[, setdiff(col, names(df))] <- NA
  df
})

### Then Bind it
do.call(rbind, df.2nd)
