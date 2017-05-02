#' sugaR
#'
#' sugaR
#' @param name name of the service
#' @param auth_type authentication type: "none", "basic", ...
#' @param endpoint endpoint in case auth_type is oauth1 or oauth2
#' @param cachePath path of the cache folder
#' @keywords sugaR
#' @export
#' @examples
#' \dontrun{
#' tmp  <- sugaR()
#' }
sugaR <- function(name,auth_type,endpoint=NULL,cachePath="~\\"){

  sugaR_object(name,auth_type,endpoint,cachePath)

}


sugaR_object <- function(name,auth_type,endpoint,cachePath){

   h_default <- function(){
     return(list(verb       = NULL,
                 headers    = headers(option="accept",encode="json"), #", text/xml, application/xml, */*"
                 options    = useragent(),
                 body       = NULL,
                 auth_token = NULL))
   }

   h_setup <- h_default()
   cachefile <- NULL
   object <- local({

     authenticate <- function(...,CACHE=FALSE,SAVE=FALSE){
       if (CACHE) cachefile <<- cache.filePath(cachePath=cachePath,name=name)
        h_setup$options <<-updateByLast(h_setup$options,authentic(app_name=name,type=auth_type,endpoint=endpoint,CACHE=CACHE,cachefile=cachefile,...))
        if (SAVE) {
          cachefile <<- cache.filePath(cachePath=cachePath,name=name)
          cache.save(cachefile=cachefile,...)
        }
        invisible()
     }


     verb <- function(verb){
       verb_p <- toupper(as.character(verb))
       h_setup$verb <<- switch(verb_p,
         "GET"   = "GET",
         "POST"  = "POST",
         stop("Verb not taken into account: ", verb)
         )
        invisible()
     }

     header <- function(option,encode){
       h_setup$headers <<- updateByLast(h_setup$headers, headers(option=option, encode=encode))
       invisible()
     }

     body <- function(body_post,encode=NULL){
       h_setup$headers <<- updateByLast(h_setup$headers, headers(option="content-type", encode=encode))
       h_setup$body <<- body_(body=body_post,encode=encode)
       invisible()
     }

     userAgent <- function(ua=NULL){
       h_setup$options <<- updateByLast(h_setup$options,useragent(ua))
       invisible()
     }

     info <- function(){
        return(list(app_name    = name,
                    handle_list = h_setup))
     }

     clearCache <- function(){
       if (!is.null(cachefile)) cache.clear(cachefile)
       cachefile <<- NULL
       invisible()
     }

     reset <- function(){
       h_setup <<- list(verb       = NULL,
                       headers    = NULL,
                       options    = useragent(),
                       body       = NULL,
                       auth_token = NULL)
       invisible()
     }

     environment()
   })
   lockEnvironment(object, TRUE)
   structure(object, class=c("sugaR", class(object)))

}
