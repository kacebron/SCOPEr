#' Function to convert umol CO2 m-2 s-1 to g C halfhour-1
#' @param actot canopy photosynthesis
#' @param area_m2 area of a leaf (1m2 is default)
#' @export
convert_photo_to_gpp <- function(actot, area_m2) {
  # Conversion factors
  umol_to_mol <- 1e-6
  molar_mass_C <- 12.01 # g/mol
  seconds_per_halfhour <- 60 * 30

  # Convert umolCO2/m2/s to gC/s
  rate_gC_per_s <- actot * umol_to_mol * molar_mass_C * area_m2

  # Convert gC/s to gC/day
  rate_gC_per_halfhour <- rate_gC_per_s * seconds_per_halfhour

  return(rate_gC_per_halfhour)
}
