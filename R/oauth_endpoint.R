oauth_endpoint <- function(request_url,authorize_url,access_url,...){
  lapply(as.list(match.call())[-1],function(x) stopifnot(is.character(x)))
  return(list(request   = request_url,
               authorize = authorize_url,
               access    = access_url,
               ...))
}
