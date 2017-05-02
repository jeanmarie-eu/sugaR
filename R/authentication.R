
authentic <- function(app_name=NULL,type="none",endpoint=NULL,CACHE=FALSE,cachefile=NULL,user=NULL,password=NULL,key=NULL,secret=NULL){
  stopifnot(is.character(type))
  if (type != "none") {
     if ((CACHE) && (!is.null(cachefile))) {
       param <- cache.get(cachefile)
       for (i in names(param)) {assign(i,as.character(param[i]))}
     }
     res <- auth_(app_name=app_name,type=type,endpoint,user=user,password=password,key=key,secret=secret)
  } else res <- NULL
  return(res)

}

auth_ <- function(app_name,type,endpoint,user,password,key,secret){
  res <- switch(type,
    "basic"        = auth_basic(type="basic",user,password),
    "digest"       = auth_basic(type="digest",user,password),
    "gssnegotiate" = auth_basic(type="gssnegotiate",user,password),
    "ntlm"         = auth_basic(type="ntlm",user,password),
    "digest_ie"    = auth_basic(type="digest_ie",user,password),
    "any"          = auth_basic(type="any",user,password),
    #"oauth1"       = auth_oauth1(auth,app_name,endpoint,key,secret),
    #"oauth2"       = auth_oauth2(auth,app_name,endpoint,key,secret),
    stop("Type of authentication not recognized: ",type )
  )
  return(res)
}

auth_basic <- function(type,user,password) {
  stopifnot(is.character(type))
  stopifnot(is.character(user))
  stopifnot(is.character(password))
  httpauth <- switch(type,
    "basic"        = 1,
    "digest"       = 2,
    "gssnegotiate" = 4,
    "ntlm"         = 8,
    "digest_ie"    = 16,
    "any"          = -17,
    stop("type of basic authentication not recognized: ", type))
  res <- list(httpauth=httpauth,userpwd=paste0(user,":",password))
  return(res)
}
