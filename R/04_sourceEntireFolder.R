#' finds all .R files within a folder and soruces them
#' @param folderName For looping the individual R script, this folder should contain either species or cluster .R to run individual case
#' @param verbose  shows the sourcing
#' @param showWarnings show warnings whether there are R files in the folder

sourceEntireFolder <- function(folderName, verbose = FALSE, showWarnings = TRUE) { # nolint
  files <- list.files(folderName, full.names = TRUE)

  # Grab only R files
  files <- files[grepl("\\.[rR]$", files)]

  if (!length(files) && showWarnings)
    warning("No R files in ", folderName)

  for (f in files) {
    if (verbose)
      cat("sourcing: ", f, "\n")
    ## TODO:  add caught whether error or not and return that
    try(source(f, local = FALSE, echo = FALSE), silent = !verbose)
  }
  return(invisible(NULL))
}
