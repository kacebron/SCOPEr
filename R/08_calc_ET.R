#' Calculate evapotranspiration (ET) from latent heat of the canopy (lEctot) and average canopy temperature (tcave)
#'
#' @param lEctot Latent heat of the canopy in MJ/m^2
#' @param tcave Average canopy temperature in Celsius
#'
#' @return Evapotranspiration (ET) in meters
#'
#' @details This function calculates evapotranspiration (ET) using the Penman-Monteith equation, which takes into account the latent heat of the canopy and average canopy temperature.
#' The function converts the latent heat from MJ/m^2 to kg/m^2 and calculates ET based on the formula ET = lEctot_kg / (1000 * (tcave + 273.15)),
#' where lEctot_kg is the latent heat in kilograms per square meter and tcave is the average canopy temperature in Celsius.
#' The result is returned as evapotranspiration (ET) in meters.
#'
#' @examples
#' lEctot <- 1500  # Latent heat of the canopy in MJ/m^2
#' tcave <- 25     # Average canopy temperature in Celsius
#' ET <- calculate_ET(lEctot, tcave)
#' print(ET)
#'
#' @export
calculate_ET <- function(lEctot, tcave) {
  # Constants
  lambda <- 2.45  # Latent heat of vaporization (MJ/kg)

  # Convert lEctot from MJ/m^2 to kg/m^2
  lEctot_kg <- lEctot / lambda

  # Calculate ET (evapotranspiration)
  ET <- lEctot_kg / (1000 * (tcave + 273.15))  # ET in meters

  return(ET)
}
