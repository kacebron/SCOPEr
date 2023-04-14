#' Modifies PROSPECT module within input_data_default.csv
#'
#' This function lets you modify input values for PROSPECT module inside input_data_default.csv contains.
#'
#' @param path filepath of the filenames.csv
#' @param Cab Chlorophyll a b content (ug cm-2)
#' @param Cca Carotenoid content. Usually 25% of Cab if options.Cca_function_of_Cab (ug cm-2)
#' @param Cdm Dry matter content (g cm-2)
#' @param Cw leaf water equivalent layer (cm)
#' @param Cs senescent material fraction
#' @param Cant Anthocyanins (ug cm-2)
#' @param Cp protein (ug cm-2)
#' @param Cbc ?
#' @param N leaf thickness parameters
#' @param rho_thermal broadband thermal reflectance
#' @param tau_thermal broadband thermal transmitance
#' @return Default values are given based on default SCOPE values in github
#' @export
input_data_PROSPECT <- function(Cab = 40,
                                Cca = 10,
                                Cdm = 0.012,
                                Cw = 0.009,
                                Cs = 0,
                                Cant = 1,
                                Cp = 0,
                                Cbc = 0,
                                N = 1.5,
                                rho_thermal = 0.01,
                                tau_thermal = 0.01){
  input_data_default_csv <- system.file("extdata", "input_data_default.csv", package = "SCOPEr")
  input_SCOPE <- readr::read_file(input_data_default_csv)
  input_SCOPE <- stringr::str_replace_all(input_SCOPE, c("(\\n)$" = "",
                                                "(?<=Cab,).+" = Cab,
                                                "(?<=Cca,).+" = Cca,
                                                "(?<=Cdm,).+" = Cdm,
                                                "(?<=Cw,).+" = Cw,
                                                "(?<=Cs,).+" = Cs,
                                                "(?<=Cant,).+" = Cant,
                                                "(?<=Cp,).+" = Cp,
                                                "(?<=Cbc,).+" = Cbc,
                                                "(?<=N,).+" = N,
                                                "(?<=rho_thermal,).+" = rho_thermal,
                                                "(?<=tau_thermal,).+" = tau_thermal
                                                )
                                 )
  utils::write.table(input_SCOPE, file = input_data_default_csv,
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
