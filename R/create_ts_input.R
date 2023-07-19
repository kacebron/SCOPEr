#' Creates input for time series
#'
#' This function uses start and end times, a grain of resolution, and constant
#' and variable parameter values to create the time series input file for SCOPE
#' time series function. NOTE: Berkeley time format is YYYYMMDDHHMM but this
#' function only takes input as "%Y-%m-%d %H:%M"
#'
#' @param start_time POSIXct object in "%Y-%m-%d %H:%M" format --
#' this is the first instance for SCOPE to model.
#' @param end_time POSIXct object in "%Y-%m-%d %H:%M" format --
#' this is the last instance for SCOPE to model.
#' @param span character string that can be read by seq.POSIXct
#' e.g. "1 hour" or "30 min" --  Should be divisible into the
#' difference between start.time and end.time.
#' @param run_nighttime logical determining whether SCOPE should
#' run simulations where Rin >= 0 (i.e., at night).
#' @param par_constant a numeric vector of length C -- SCOPE input
#' parameter values that will be repeated for every time step. C
#' is the number of constant variables.
#' @param par_variable T x V matrix -- SCOPE input parameter values
#' change over some or all time steps. T is number of time steps
#' and V is number of varying variables.
#' @param dir_name character string -- name of directory to save the input file.
#' @param filename the base.name of the input file to be saved
#' (omitting the '.csv').
#' @param par_constant_type replace the _type with any of the
#' following: aero, angles, biochem, canopy, meteo, PROSPECT, soil, timeseries
#' @export
#'

create_ts_input <- function(start_time, end_time, span = "30 min",
  run_nightTime = FALSE, par_constant = NULL, # nolint
  par_variable = NULL, dir_name = ".",
  filename = "input") {

  #st <- as.POSIXct(strftime(start_time, format = "%Y-%m-%d %H:%M")) # nolint
  #et <- as.POSIXct(strftime(end_time, format = "%Y-%m-%d %H:%M")) # nolint
  t_seq <- seq(start_time, end_time, by = span)
  t <- strftime(t_seq, format = "%Y%m%d%H%M")

  dir_name <<- dir_name # this is needed for migrating files to SCOPE folder and set_filenames # nolint
  filename <<- filename # this is needed later for set_filenames

  # Matching t and date from par_variable (useful if there are NAs and finer screen of data) # nolint

  par_constant_mat <- matrix(par_constant, nrow = length(t),
                             ncol = length(par_constant), byrow = TRUE)
  input_df <- cbind(t, par_constant_mat, par_variable)
  colnames(input_df) <- c("t", names(par_constant), names(par_variable))
  input_df <- input_df[, -which(names(input_df) == "Date")]

  if (run_nightTime == FALSE) {
    input_df <- input_df[which(input_df$Rin > 0), ]
  }

  # Create path from system file
  path <- system.file(package = "SCOPEr")

  dir.create(sprintf("%s/extdata/dataset %s", path, dir_name))

  utils::write.csv(as.data.frame(input_df),
  sprintf("%s/extdata/dataset %s/%s.csv", path, dir_name, filename),
  row.names = FALSE, quote = FALSE)
}

# End