#' converts doy to fraction of a day
#' @param doy Day of year with fraction
#' @export
#'
# Function to Convert DoY to fraction of a day
doy_to_fract <- function(doy) {
  # convert to fraction of a day
  fract <- round(round(doy, 4) - floor(doy), 4)
  return(fract)
}
