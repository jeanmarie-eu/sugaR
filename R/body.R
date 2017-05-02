body_ <- function(body=NULL,encode = "raw"){ #c("form", "json", "multipart", "raw")

  if (is.null(body)) encode <- "none"
  if (is.raw(body))  encode <- "raw"
  if (is.character(body)) encode <- "char"
  res <- handle_body(raw_body(body=body,encode=encode))
  return(res)

}

raw_body <- function(body,encode){
  res <- switch(encode,
    "none" = raw(),
    "raw"  = body,
    "char" = charToRaw(paste(body, collapse = "\n")),
    "json" = charToRaw(paste(jsonlite::toJSON(body, auto_unbox = TRUE), collapse = "\n")),
    stop("Encode not recoognized: ", encode))
  return(res)
}


handle_body <- function(body) {
  stopifnot(is.raw(body))
  res <- list(
      postfieldsize = length(body),
      postfields = body
    )
  return(res)
}
