updateByLast <- function(...){
  x <- c(...)
  x[!duplicated(names(x), fromLast = TRUE)]
}
