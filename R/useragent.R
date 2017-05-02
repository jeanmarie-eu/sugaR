useragent <- function(ua=NULL){
  if(is.null(ua)) {
    versions <- c(
          sugaR = as.character(utils::packageVersion("sugaR")))
    res <- list(useragent = paste0(names(versions), "/", versions, collapse = " "))
  } else res <- list(useragent = ua)
}
