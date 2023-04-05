#' Creates input for time series
#'
#' This function uses start and end times, a grain of resolution, and constant
#' and variable parameter values to create the time series input file for SCOPE
#' time series function. NOTE: Berkeley time format is YYYYMMDDHHMM but this
#' function only takes input as "%Y-%m-%d %H:%M"
#'
#' @param start_time POSIXct object in "%Y-%m-%d %H:%M" format -- this is the first instance for SCOPE to model.
#' @param end_time POSIXct object in "%Y-%m-%d %H:%M" format -- this is the last instance for SCOPE to model.
#' @param span character string that can be read by seq.POSIXct e.g. "1 hour" or "30 min" --  Should be divisible into the difference between start.time and end.time.
#' @param run_nighttime logical determining whether SCOPE should run simulations where Rin >= 0 (i.e., at night).
#' @param par_constant a numeric vector of length C -- SCOPE input parameter values that will be repeated for every time step. C is the number of constant variables.
#' @param par_variable T x V matrix -- SCOPE input parameter values change over some or all time steps. T is number of time steps and V is number of varying variables.
#' @param dir_name character string -- name of directory to save the input file.
#' @param filename the base.name of the input file to be saved (omitting the '.csv').
#' @param par_constant_type 1=aero; 2=angles; 3=biochem; 4=canopy; 5=meteo; 6=PROSPECT; 7=soil; 8=timeseries
#' @export
#'

create_ts_input <- function(start_time, end_time, span = "30 min",
                          run_nightTime = FALSE, par_constant_type,
                          par_variable_EC_names = c("Rs", "tair", "RH"),
                          par_variable_SCOPE_names = c("Rin", "Ta", "RH"),
                          par_variable = NULL, dir_name = ".",
                          filename = "input") {
  if (is.null(par_constant_type)) {
    stop("par_constant_type not defined")
  }

  par_constant <- readRDS(file = sprintf("./inst/extdata/par_constant/%s.RDs", par_constant_type))

  bci_ec_flux <- readRDS(file="./inst/extdata/ec_data/bci_ec_flux.Rds")

  if (is.null(par_variable)) {
    par_variable <- bci_ec_flux[(bci_ec_flux$date >= start_time & bci_ec_flux$date <= end_time &                                   !is.na(bci_ec_flux$date)), par_variable_EC_names]
    colnames(par_variable) <- par_variable_SCOPE_names
  }

  st <- as.POSIXct(strftime(start_time, format = "%Y-%m-%d %H:%M"))
  et <- as.POSIXct(strftime(end_time, format = "%Y-%m-%d %H:%M"))
  t_seq <- seq(st, et, by = span)
  t <- strftime(t_seq, format = "%Y%m%d%H%M")

  par_constant_mat <- matrix(par_constant, nrow = length(t),
                             ncol = length(par_constant), byrow = TRUE)
  input_df <- cbind(t, par_constant_mat, par_variable)
  colnames(input_df) <- c("t", names(par_constant), names(par_variable))

  if(run_nightTime == FALSE) {
    input_df <- input_df[which(input_df$Rin > 0), ]
  }
  dir.create(sprintf("./inst/extdata/dataset %s", dir_name))

  utils::write.csv(as.data.frame(input_df), sprintf("./inst/extdata/dataset %s/%s.csv", dir_name, filename),
            row.names = FALSE, quote = FALSE)
}
