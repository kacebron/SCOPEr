#' Creates input for time series
#'
#' This function uses start and end times, a grain of resolution, and constant
#' and variable parameter values to create the time series input file for SCOPE
#' time series function. NOTE: Berkeley time format is YYYYMMDDHHMM but this
#' function only takes input as "%Y-%m-%d %H:%M"
#'
#' @param par_variable a dataframe containing environmental variables
#' @param par_constant a dataframe containing leaf and canopy traits that are constant
#' @export
#'

create_matrix <- function(par_variable, par_constant) {
  t <- strftime(par_variable$Date, format = "%Y%m%d%H%M", tz = "America/Panama") # nolint
  par_constant_mat <- matrix(par_constant, nrow = length(t),
                             ncol = length(par_constant), byrow = TRUE)
  input_df <- cbind(t, par_constant_mat, par_variable)
  colnames(input_df) <- c("t", names(par_constant), names(par_variable))
  input_df <- input_df[, -which(names(input_df) == "Date")]
  dir.create(sprintf(".././SCOPE/input/dataset %s", dir_name))

  df <- as.data.frame(input_df)
  # Convert the list column to character
  df$Vcmax25 <- sapply(df$Vcmax25, paste, collapse = ",")
  df$Cab <- sapply(df$Cab, paste, collapse = ",")
  df$Cca <- sapply(df$Cca, paste, collapse = ",")
  df$Cdm <- sapply(df$Cdm, paste, collapse = ",")
  df$Cw <- sapply(df$Cw, paste, collapse = ",")
  df$Cant <- sapply(df$Cant, paste, collapse = ",")

  write.csv(df, file = sprintf(".././SCOPE/input/dataset %s/%s.csv",
                               dir_name, filename),
            row.names = FALSE, quote = FALSE)
}

# End
