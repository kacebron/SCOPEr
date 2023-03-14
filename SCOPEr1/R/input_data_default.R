#' Modifies input_data_default.csv
#'
#' The input_dat_default.csv contains input values for leaf (PROSPECT and biochemistry), canopy, soil, meteorology, aerodynamics, time series and angles. This function helps you modify input values for each trait.
#' At the moment, the function contains leaf biochemical traits and those that are essential for PROSPECT module to run (e.g. Cdm, Cab, Cca, Cw, Cant), indluding LAI, LAT, LON and timezone
#' @export
input_data_default <- function(Cdm, Cab, Cca, Vcmax25, Cw, Cant, Rdparam, LAI, LAT,
                               LON, timezn){
  input_SCOPE <- read_file("../SCOPE/input/input_data_default.csv")
  input_SCOPE <- str_replace_all(input_SCOPE, c("(\\n)$" = "",
                                                "(?<=Cdm,).+" = Cdm,
                                                "(?<=Cab,).+" = Cab,
                                                "(?<=Cca,).+" = Cca,
                                                "(?<=Vcmax25,).+" = Vcmax25,
                                                "(?<=Cw,).+" = Cw,
                                                "(?<=Cant,).+" = Cant,
                                                "(?<=Rdparam,).+" = Rdparam,
                                                "(?<=LAI,).+" = LAI,
                                                "(?<=LAT,).+" = LAT,
                                                "(?<=LON,).+" = LON,
                                                "(?<=timezn,).+" = timezn
  ))
  write.table(input_SCOPE, file = '../SCOPE/input/input_data_default.csv',
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
