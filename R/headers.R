headers <- function(option,encode){
   res <- formatFile(option=option, encode=encode)
   return(res)
}

formatFile <- function(option="accept", encode=NULL){
  res <- switch(option,
    "accept"       = list(Accept = contentType(encode)),
    "content-type" = list('Content-Type' = contentType(encode)),
    stop("Option not recognize:", option))
 return(res)
}

contentType <- function(encode=NULL){
  if(is.null(encode)) {
    res <- ""
  } else res <- paste0("application/",encode)
  return(res)
}
