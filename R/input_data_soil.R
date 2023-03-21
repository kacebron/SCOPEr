#' Modifies module for soil properties within input_data_default.csv
#'
#' This function lets you modify input values for soil properties inside input_data_default.csv contains.
#'
#' @param path filepath of the filenames.csv
#' @param spectrum spectrum number (column in the database soil_file)
#' @param rss soil resistance for evaporation from the pore space (s m-1)
#' @param rs_thermal broadband soil reflectance in the thermal range [1 - emissivity]
#' @param cs specific heat capacity of the soil (J kg-1 K-1)
#' @param rhos specific mass of the soil (kg m-3)
#' @param lambdas heat conductivity of the soil (J m-1 K-1)
#' @param SMC volumetric soil moisture content in the root zone
#' @param BSMBrightness BSM model parameter for soil brightness
#' @param BSMlat BSM model parameter 'lat'
#' @param BSMlon BSM model parameter 'long'
#'
#' @return Default values are given based on default SCOPE values in github
#' @export
input_data_soil <- function(path = "../SCOPE/input/input_data_default.csv",
                                spectrum = 1,
                                rss = 500,
                                rs_thermal = 0.06,
                                cs = 1180,
                                rhos = 1800,
                                lambdas = 1.55,
                                SMC = 25,
                                BSMBrightness = 0.5,
                                BSMlat = 25,
                                BSMlon = 45
                                ){
  input_SCOPE <- read_file(path)
  input_SCOPE <- str_replace_all(input_SCOPE, c("(\\n)$" = "",
                                                "(?<=spectrum,).+" = spectrum,
                                                "(?<=rss,).+" = rss,
                                                "(?<=rs_thermal,).+" = rs_thermal,
                                                "(?<=cs,).+" = cs,
                                                "(?<=rhos,).+" = rhos,
                                                "(?<=lambdas,).+" = lambdas,
                                                "(?<=SMC,).+" = SMC,
                                                "(?<=BSMBrightness,).+" = BSMBrightness,
                                                "(?<=BSMlat,).+" = BSMlat,
                                                "(?<=BSMlon,).+" = BSMlon
  )
  )
  write.table(input_SCOPE, file = '../SCOPE/input/input_data_default.csv',
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
