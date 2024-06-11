#' Function to merge date and time
#' @param date Date
#' @param time Time
#' @param format format
#' @param tz timezone
#' @export
format_datetime <- function(date, time, format = "%Y-%m-%d %H:%M", tz = "America/Panama") { # nolint
  datetime <- paste(date, time, sep = " ")
  datetime <- as.POSIXct(datetime, format = format, tz = tz)
  return(datetime)
}
