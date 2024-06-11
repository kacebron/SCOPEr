#' Function to Convert DoY to time of day
#' @param doy day of year fraction
#' @export
doy_to_time <- function(doy) {
  # convert to fraction of a day
  fract <- round(round(doy, 4) - floor(doy), 4)
  # convert to hour
  hour <- floor(fract * 24)
  # convert to minute
  minute <- round(((fract * 24) - hour) * 60)
  # handle minute overflow using ifelse
  minute_overflow <- ifelse(minute >= 60, TRUE, FALSE)
  hour <- ifelse(minute_overflow, hour + 1, hour)
  minute <- ifelse(minute_overflow, 0, minute)
  # handle hour overflow
  hour <- ifelse(hour >= 24, 0, hour)
  # convert to time (hh:mm) format
  time <- sprintf("%02d:%02d", hour, minute)
  return(time)
}
