#' convert solar radiation to PAR
#' @param solar_radiation solar radiation in Wm-2
#' @export
# Define the conversion function
convert_to_PAR <- function(solar_radiation) {
  conversion_factor <- 4.57  # µmol photon J^-1
  PAR <- solar_radiation * conversion_factor
  return(PAR)
}
