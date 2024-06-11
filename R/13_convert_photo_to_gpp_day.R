#' Function to convert umol CO2 m-2 s-1 to g C day
#' @param actot Canopy photosynthesis
#' @param area_m2 area of a leaf
#' @export
convert_photo_to_gpp_day <- function(actot, area_m2) {
  # Conversion factors
  umol_to_mol <- 1e-6
  molar_mass_C <- 12.01 # g/mol
  seconds_to_day <- 60 * 60 * 24

  # Convert umolCO2/m2/s to gC/s
  rate_gC_per_s <- actot * umol_to_mol * molar_mass_C * area_m2

  # Convert gC/s to gC/day
  rate_gC_per_halfhour <- rate_gC_per_s * seconds_to_day

  return(rate_gC_per_halfhour)
}
