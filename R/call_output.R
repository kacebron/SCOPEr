#' This calls out the filepath of the type of SCOPE output you need for further analysis
#'
#' @export
call_output <- function(type){
  ls.dirs <- list.dirs(path = "../bcipanama/7_scope/scope_output")
  ls.file <- list.files(path = ls.dirs[3], full.names = TRUE)
  out <- ls.file[grep(pattern =type, ls.file)]
  return(out)
}
