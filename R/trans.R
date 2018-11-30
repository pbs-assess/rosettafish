data.test <- data.frame(english = c("A","B","C","D","E","F"),
                   french = c("AA", "BB", "CC", "DD", "EE", "FF"),
                   stringsAsFactors = FALSE)

data <- read.csv("data/terms.csv", header = TRUE, stringsAsFactors = FALSE)

en2fr <- function(x, translate = TRUE){
  if(!translate)
    return(x)
  trans(x, FALSE)
}

fr2en <- function(x, translate = TRUE){
  if(!translate)
    return(x)
  trans(x, TRUE)
}

trans <- function(x, from.french = FALSE){
  if(from.french){
    col <- "french"
    col2 <- "english"
  }else{
    col <- "english"
    col2 <- "french"
  }
  
  from <- data[,col, drop = TRUE]
  to <- data[,col2, drop = TRUE]

  j <- match(x, from)
  v <- to[j]
  v[is.na(j)] <- x[is.na(j)]
  v
}


