#' Function to Convert DoY and Year to Julian Date
#' @param doy day of year with fraction
#' @export
doy_to_date <- function(doy, year) {
  date <- as.Date(paste(year, doy, sep = "-"), format = "%Y-%j")

  return(date)
}
