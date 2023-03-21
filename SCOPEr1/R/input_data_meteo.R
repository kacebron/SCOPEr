#' Modifies input values for Meteorological parameters within input_data_default.csv
#'
#' This function lets you modify input values for meteorological parameters inside input_data_default.csv contains.
#'
#' @param path filepath of the filenames.csv
#' @param z measurement height of meteorological data (m)
#' @param Rin broadband incoming shortwave radiation (0.4-2.5 um) (W m-2)
#' @param Ta air temperature (deg C)
#' @param Rli broadband incoming longwave radiation (2.5-50 um) (W m-2)
#' @param p air pressure (hPa)
#' @param ea atmospheric vapour pressure (hPa)
#' @param u wind speed at height z (m s-1)
#' @param Ca atmospheric CO2 concentration (ppm)
#' @param Oa atmospheric O2 concentration (per mille)
#'
#' @return Default values are given based on default SCOPE values in github
#' @export
input_data_meteo <- function(path = "../SCOPE/input/input_data_default.csv",
                                z = 5,
                                Rin = 600,
                                Ta = 20,
                                Rli = 300,
                                p = 970,
                                ea = 15,
                                u = 2,
                                Ca = 410,
                                Oa = 209
){
  input_SCOPE <- read_file(path)
  input_SCOPE <- str_replace_all(input_SCOPE, c("(\\n)$" = "",
                                                "(?<=z,).+" = z,
                                                "(?<=Rin,).+" = Rin,
                                                "(?<=Ta,).+" = Ta,
                                                "(?<=Rli,).+" = Rli,
                                                "(?<=p,).+" = p,
                                                "(?<=ea,).+" = ea,
                                                "(?<=u,).+" = u,
                                                "(?<=Ca,).+" = Ca,
                                                "(?<=Oa,).+" = Oa
  )
  )
  write.table(input_SCOPE, file = '../SCOPE/input/input_data_default.csv',
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
