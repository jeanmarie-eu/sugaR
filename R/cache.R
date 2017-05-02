cache.get <- function(cachefile){
  if (file.exists(cachefile)) {
    tmp <-  rabarbRa::rabarbRa()
    tmp$import(filename=cachefile)
    param <- tmp$export(format="rda")
    return(param)
  } else stop("No cache exists.")
}

cache.save <- function(cachefile,...){
  param <- as.data.frame(as.list(match.call()[-c(1,2)])  )
  output  <- rabarbRa::rabarbRa()
  name_vec <-  names(param)
  output$create(names_array = name_vec)
  output$insert(param)
  output$export(cachefile)
}

cache.clear <- function(cachefile=NULL){
  if (file.exists(cachefile)) file.remove(cachefile)    
  invisible()
}

cache.filePath <- function(cachePath,name){
  cachedir <- normalizePath(file.path(cachePath,".sugaR"),mustWork = FALSE)
  dir.create(cachedir, showWarnings = FALSE, recursive = TRUE)
  return(normalizePath(file.path(cachedir,paste0(".",name)),mustWork = FALSE))
}
