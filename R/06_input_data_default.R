#' General function to modify input_data_default.csv
#'
#' The input_dat_default.csv contains input values for leaf (PROSPECT and biochemistry), canopy, soil, meteorology, aerodynamics, time series and angles. This function helps you modify input values for all modules.
#' @param Cab Total Chla + Chlb
#' @param Cca Total Carotenoid content
#' @param Cdm Leaf dry matter
#' @param Cw Leaf water equivalent
#' @param Cs Leaf senescent material fraction
#' @param Cant Leaf anthocyanin content
#' @param Cp Protein
#' @param Cbc ?
#' @param N leaf thickness parameters
#' @param rho_thermal broadband thermal reflectance
#' @param tau_thermal broadband thermal transmittance
#' @param Vcmax25 maximum carboxylation efficiency (at optimum temperature of 25 deg C, former Vcmo)
#' @param BallBerrySlope slope of Ball-Berry stomatal conductance (former m)
#' @param BallBerry0 intercept of Ball-Berry stomatal conductance model
#' @param Type Photochemical pathway: 0 => C3; 1 => C4
#' @param kV Extinction coefficient for Vcmax in the vertical (maximum at the top). 0 for uniform Vcmax
#' @param Rdparam Respiration = Rdparam * Vcmax
#' @param Kn0 Kn0: parameter for empirical Kn (NPQ) model
#' @param Knalpha alpha parameter for empirical Kn (NPQ) model
#' @param Knbeta beta parameter for empirical Kn (NPQ) model
#' @param Tyear mean annual temperature
#' @param beta fraction of photons partitioned to PSII
#' @param kNPQs rate constant of sustained thermal dissipation
#' @param qLs fraction of cuntional reaction centers
#' @param stressfactor optional input: stress factor to reduce Vcmax (for example soil moisture, leaf age)
#' @param fqe fluorescence quantum yield efficiency at photosynstem level
#' @param spectrum spectrum number (column in the database soil_file)
#' @param rss soil resistance for evaporation from the pore space
#' @param rs_thermal broadband soil reflectance in the thermal range (1 - emissivity)
#' @param cs specific heat capacity of the soil
#' @param rhos specific mass of the soil
#' @param lambdas heat conductivity of the soil
#' @param SMC volumetric soil moisture content in the root zone
#' @param BSMBrightness BSM model parameter for soil brightness
#' @param BSMlat BSM model parameter (lat)
#' @param BSMlon BSM model parameter (long)
#' @param LAI leaf area idex
#' @param hc vegetation height
#' @param LIDFa leaf inclination
#' @param LIDFb variation in leaf inclination
#' @param leafwidth leaf width
#' @param Cv ?
#' @param crowndiameter default to 1
#' @param z measurement height of meteorological data (default to 5)
#' @param Rin broadband shortwave radiation
#' @param Ta air temperature
#' @param Rli broadband incoming longwave radiation
#' @param p air pressure
#' @param ea atmospheric vapour pressure
#' @param u wind speed at height z
#' @param Ca atmospheric CO2 concentration
#' @param Oa atmospheric O2 concentration
#' @param zo roughness length for momentum of the canopy
#' @param d displacement height
#' @param Cd leaf drag coefficient
#' @param rb leaf boundary resistance
#' @param CR Drag coefficient for isolated tree
#' @param CD1 fitting paramter
#' @param Psicor Roughness layer correction
#' @param CSSOIL Drag coefficient for soil
#' @param rbs soul boundary layer resistance (from Aerodynamic)
#' @param rwc within canopy layer resistance
#' @param startDOY Julian day start of simulations
#' @param endDOY Julian day end of simulations
#' @param LAT latitude
#' @param LON longitude
#' @param timezn east of Greenwich
#' @param tts solar zenith angle
#' @param tto observer zenigh angle
#' @param psi azimuthal difference between solar and observation angle; relative azimuth angle
#'
#' @export
input_data_default <- function(Cab = 40,
                               Cca = 10,
                               Cdm = 0.012,
                               Cw = 0.009,
                               Cs = 0,
                               Cant = 1,
                               Cp = 0,
                               Cbc = 0,
                               N = 1.5,
                               rho_thermal = 0.01,
                               tau_thermal = 0.01,
                               Vcmax25 = 60,
                               BallBerrySlope = 8,
                               BallBerry0 = 0.01,
                               Type = 0,
                               kV = 0.64,
                               Rdparam = 0.015,
                               Kn0 = 2.48,
                               Knalpha = 2.83,
                               Knbeta = 0.114,
                               Tyear = 15,
                               beta = 0.51,
                               kNPQs = 0,
                               qLs = 1,
                               stressfactor = 1,
                               fqe = 0.01,
                               spectrum = 1,
                               rss = 500,
                               rs_thermal = 0.06,
                               cs = 1180,
                               rhos = 1800,
                               lambdas = 1.55,
                               SMC = 25,
                               BSMBrightness = 0.5,
                               BSMlat = 25,
                               BSMlon = 45,
                               LAI = 3,
                               hc = 2,
                               LIDFa = -0.35,
                               LIDFb = -0.15,
                               leafwidth = 0.1,
                               Cv = 1,
                               crowndiameter = 1,
                               z = 5,
                               Rin = 600,
                               Ta = 20,
                               Rli = 300,
                               p = 970,
                               ea = 15,
                               u = 2,
                               Ca = 410,
                               Oa = 209,
                               zo = 0.25,
                               d = 1.34,
                               Cd = 0.3,
                               rb = 10,
                               CR = 0.35,
                               CD1 = 20.6,
                               Psicor = 0.2,
                               CSSOIL = 0.01,
                               rbs = 10,
                               rwc = 0,
                               startDOY = 20060618,
                               endDOY = 20300101,
                               LAT = 51.55,
                               LON = 5.55,
                               timezn = 1,
                               tts = 30,
                               tto = 0,
                               psi = 0){
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
                                                "(?<=tau_thermal,).+" = tau_thermal,
                                                "(?<=Vcmax25,).+" = Vcmax25,
                                                "(?<=BallBerrySlope,).+" = BallBerrySlope,
                                                "(?<=BallBerry0,).+" = BallBerry0,
                                                "(?<=Type,).+" = Type,
                                                "(?<=kV,).+" = kV,
                                                "(?<=Rdparam,).+" = Rdparam,
                                                "(?<=Kn0,).+" = Kn0,
                                                "(?<=Knalpha,).+" = Knalpha,
                                                "(?<=Knbeta,).+" = Knbeta,
                                                "(?<=Tyear,).+" = Tyear,
                                                "(?<=\\nbeta,).+" = beta,
                                                "(?<=kNPQs,).+" = kNPQs,
                                                "(?<=qLs,).+" = qLs,
                                                "(?<=stressfactor,).+" = stressfactor,
                                                "(?<=fqe,).+" = fqe,
                                                "(?<=spectrum,).+" = spectrum,
                                                "(?<=rss,).+" = rss,
                                                "(?<=rs_thermal,).+" = rs_thermal,
                                                "(?<=cs,).+" = cs,
                                                "(?<=rhos,).+" = rhos,
                                                "(?<=lambdas,).+" = lambdas,
                                                "(?<=SMC,).+" = SMC,
                                                "(?<=BSMBrightness,).+" = BSMBrightness,
                                                "(?<=BSMlat,).+" = BSMlat,
                                                "(?<=BSMlon,).+" = BSMlon,
                                                "(?<=LAI,).+" = LAI,
                                                "(?<=hc,).+" = hc,
                                                "(?<=LIDFa,).+" = LIDFa,
                                                "(?<=LIDFb,).+" = LIDFb,
                                                "(?<=leafwidth,).+" = leafwidth,
                                                "(?<=Cv,).+" = Cv,
                                                "(?<=crowndiameter,).+" = crowndiameter,
                                                "(?<=z,).+" = z,
                                                "(?<=Rin,).+" = Rin,
                                                "(?<=Ta,).+" = Ta,
                                                "(?<=Rli,).+" = Rli,
                                                "(?<=\\np,).+" = p,
                                                "(?<=ea,).+" = ea,
                                                "(?<=u,).+" = u,
                                                "(?<=Ca,).+" = Ca,
                                                "(?<=Oa,).+" = Oa,
                                                "(?<=zo,).+" = zo,
                                                "(?<=d,).+" = d,
                                                "(?<=Cd,).+" = Cd,
                                                "(?<=rb,).+" = rb,
                                                "(?<=CR,).+" = CR,
                                                "(?<=CD1,).+" = CD1,
                                                "(?<=Psicor,).+" = Psicor,
                                                "(?<=CSSOIL,).+" = CSSOIL,
                                                "(?<=rbs,).+" = rbs,
                                                "(?<=rwc,).+" = rwc,
                                                "(?<=startDOY,).+" = startDOY,
                                                "(?<=endDOY,).+" = endDOY,
                                                "(?<=LAT,).+" = LAT,
                                                "(?<=LON,).+" = LON,
                                                "(?<=timezn,).+" = timezn,
                                                "(?<=tts,).+" = tts,
                                                "(?<=tto,).+" = tto,
                                                "(?<=psi,).+" = psi
  ))
  utils::write.table(input_SCOPE, file = input_data_default_csv,
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
