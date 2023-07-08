#' Modify filenames.csv
#'
#' This function helps you modify filenames.csv
#'
#' @param simulation_name Lets you change the simulation name.
#' @param dataset_dir Lets you specify the directory of the
#' dataset containing the input files for time series simulations
#' @param meteo_ec_csv Lets you specify the name of the .csv file
#' that contains the meteorological information to be used in time
#' series runs (more of this in the create_ts_input() function)
#' @param tts Solar zenith angle
#' @param RH relative humidity
#' @param VPD vapor pressure deficit
#' @param tto Observer zenith angle
#' @param psi Relative azimuth angle: the azimuthal difference
#' between solar and observation angle.
#' @param Ta Air temperature
#' @param LAI leaf area index (m-2 m-2)
#' @param hc  vegetation height (m)
#' @param LIDFa leaf inclination
#' @param LIDFb variation in leaf inclination
#' @param Cab Chlorophyll a b content (ug cm-2)
#' @param Car Carotenoid content. Usually 25% of Cab if
#' options.Cca_function_of_Cab (ug cm-2)
#' @param Cdm dry matter content
#' @param Cw leaf water equivalent layer (cm)
#' @param Cs senescent material fraction
#' @param Cant Anthocyanins (ug cm-2)
#' @param Vcmax25 maximum carboxylation capacity (at optimum
#' temperature of 25C, former Vcmo) (umol m-2 s-1)
#' @param BallBerrySlope slope of Ball-Berry stomatal
#' conductance model (former m)
#' @param z measurement height of meteorological data
#' @param Rin broadband incoming shortwave radiation (0.4-2.5 um) (W m-2)
#' @param Rli broadband incoming longwave radiation (2.5-50 um) (W m-2)
#' @param p air pressure (hPa)
#' @param ea atmospheric vapour pressure (hPa)
#' @param u wind speed at height z (m s-1)
#' @param Ca atmospheric CO2 concentration (ppm)
#' @param BSMBrightness BSM model parameter for soil brightness
#' @param BSMlat BSM model parameter ‘lat’
#' @param BSMlon BSM model parameter ‘long’
#' @param SMC volumetric soil moisture content in the root zone
#' @param t Julian day (decimal)
#'
#' @examples set_filenames(simulation_name = "test")
#'
#' @return **tts** Lets you specify the column name for the solar
#' zenith angle if th value is TRUE. Place a FALSE value if
#' latitude and longitude are specified in the input.filename.csv
#'
#' @export
set_filenames <- function(
  simulation_name,
  dataset_dir,
  meteo_ec_csv,
  t = TRUE,
  Rin = TRUE, # nolint
  Rli = FALSE, # nolint
  p = FALSE,
  Ta = TRUE, # nolint
  u = FALSE,
  ea = FALSE,
  RH = TRUE, # nolint
  VPD = FALSE, # nolint
  tts = TRUE,
  tto = TRUE,
  psi = TRUE,
  Cab = TRUE, # nolint
  Cca = TRUE, # nolint
  Cdm = TRUE, # nolint
  Cw = TRUE, # nolint
  Cs = TRUE, # nolint
  Cant = TRUE, # nolint
  SMC = FALSE, # nolint
  BSMBrightness = FALSE, # nolint
  BSMlat = FALSE, # nolint
  BSMlon = FALSE, # nolint
  LAI = TRUE, # nolint
  hc = FALSE,
  LIDFa = TRUE, # nolint
  LIDFb = TRUE, # nolint
  z = FALSE,
  Ca = FALSE, # nolint
  Vcmax25 = TRUE, # nolint
  BallBerrySlope = TRUE) { # nolint

  filenames_csv <- system.file("extdata", "filenames.csv", package = "SCOPEr")
  filenames <- readr::read_file(filenames_csv)
  filenames <- stringr::str_replace_all(filenames,
    c("(\\n)$" = "",
    "(?<=Simulation_Name,).+" = simulation_name,
    "(?<=Dataset_dir,).+" = dataset_dir,
    "(?<=meteo_ec_csv,)(?! ).+" = paste0((meteo_ec_csv), ".csv"),
    "(?<=\\nt,)((t){1,}|)" = ifelse(t == TRUE, "t", ""),
    "(?<=Rin,)((Rin){1,}|)" = ifelse(Rin == TRUE, "Rin", ""),
    "(?<=Rli,)((Rli){1,}|)" = ifelse(Rli == TRUE, "Rli", ""),
    "(?<=p,)((p){1,}|)" = ifelse(p == TRUE, "p", ""),
    "(?<=Ta,)((Ta){1,}|)" = ifelse(Ta == TRUE, "Ta", ""),
    "(?<=u,)((u){1,}|)" = ifelse(u == TRUE, "u", ""),
    "(?<=ea,)((ea){1,}|)" = ifelse(ea == TRUE, "ea", ""),
    "(?<=RH,)((RH){1,}|)" = ifelse(RH == TRUE, "RH", ""),
    "(?<=VPD,)((VPD){1,}|)" = ifelse(VPD == TRUE, "VPD", ""),
    "(?<=tts,)((tts){1,}|)" = ifelse(tts == TRUE, "tts", ""),
    "(?<=tto,)((tto){1,}|)" = ifelse(tto == TRUE, "tto", ""),
    "(?<=psi,)((psi){1,}|)" = ifelse(psi == TRUE, "psi", ""),
    "(?<=Cab,)((Cab){1,}|)" = ifelse(Cab == TRUE, "Cab", ""),
    "(?<=Cca,)((Cca){1,}|)" = ifelse(Cca == TRUE, "Cca", ""),
    "(?<=Cdm,)((Cdm){1,}|)" = ifelse(Cdm == TRUE, "Cdm", ""),
    "(?<=Cw,)((Cw){1,}|)" = ifelse(Cw == TRUE, "Cw", ""),
    "(?<=Cs,)((Cs){1,}|)" = ifelse(Cs == TRUE, "Cs", ""),
    "(?<=Cant,)((Cant){1,}|)" = ifelse(Cant == TRUE, "Cant", ""),
    "(?<=SMC,)((SMC){1,}|)" = ifelse(SMC == TRUE, "SMC", ""),
    "(?<=BSMBrightness,)((BSMBrightness){1,}|)" =
      ifelse(BSMBrightness == TRUE, "BSMBrightness", ""),
    "(?<=BSMlat,)((BSMlat){1,}|)" = ifelse(BSMlat == TRUE, "BSMlat", ""),
    "(?<=BSMlon,)((BSMlon){1,}|)" = ifelse(BSMlon == TRUE, "BSMlon", ""),
    "(?<=LAI,)((LAI){1,}|)" = ifelse(LAI == TRUE, "LAI", ""),
    "(?<=hc,)((hc){1,}|)" = ifelse(hc == TRUE, "hc", ""),
    "(?<=LIDFa,)((LIDFa){1,}|)" = ifelse(LIDFa == TRUE, "LIDFa", ""),
    "(?<=LIDFb,)((LIDFb){1,}|)" = ifelse(LIDFb == TRUE, "LIDFb", ""),
    "(?<=z,)((z){1,}|)" = ifelse(z == TRUE, "z", ""),
    "(?<=Ca,)((Ca){1,}|)" = ifelse(Ca == TRUE, "Ca", ""),
    "(?<=Vcmax25,)((Vcmax25){1,}|)" = ifelse(Vcmax25 == TRUE, "Vcmax25", ""),
    "(?<=BallBerrySlope,)((BallBerrySlope){1,}|)" =
      ifelse(BallBerrySlope == TRUE, "BallBerrySlope", "")
))
utils::write.table(filenames, file = filenames_csv, sep = ",",
  col.names = FALSE, row.names = FALSE, quote = FALSE, na = "")
}

# End