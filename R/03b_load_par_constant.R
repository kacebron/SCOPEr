#' Loads constant parameters for time series input
#'
#' The load_par_constant() function is designed to prompt the user to select a file containing constant parameters the timeseries input table. The function then reads the data from the selected file using the readRDS() function and returns the data as a variable.
#'
load_par_constant <- function() {

  # Prompt user to choose the constant parameter file
  message("Locate the constant parameter from Eddy Covariance")
  file_path <- file.choose()
  data <- readRDS(file_path)
}
