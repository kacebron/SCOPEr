args_PROSPECT <- list(Cab = 40,
                      Cca = 10,
                      Cdm = 0.012,
                      Cw = 0.009,
                      Cs = 0,
                      Cant = 1,
                      Cp = 0,
                      Cbc = 0,
                      N = 1.5,
                      rho_thermal = 0.01,
                      tau_thermal = 0.01)
args_leaf_biochem <- list(Vcmax25 = 60,
                          BallBerrySlope = 8,
                          BallBerry0 = 0.01,
                          Type = 0,
                          kV = 0.64,
                          Rdparam = 0.015,
                          Kn0 = 2.48,
                          Knalpha = 2.83,
                          Knbeta = 0.114)
args_leaf_biochem_magnani <- list(Tyear = 15,
                                  beta = 0.51,
                                  kNPQs = 0,
                                  qLs = 1,
                                  stressfactor = 1)
args_soil <- list(spectrum = 1,
                  rss = 500,
                  rs_thermal = 0.06,
                  cs = 1180,
                  rhos = 1800,
                  lambdas = 1.55,
                  SMC = 25,
                  BSMBrightness = 0.5,
                  BSMlat = 25,
                  BSMlon = 45)
args_canopy <- list(LAI = 3,
                    hc = 2,
                    LIDFa = -0.35,
                    LIDFb = -0.15,
                    leafwidth = 0.1,
                    Cv = 1,
                    crowndiameter = 1)
args_meteo <- list(z = 5,
                   Rin = 600,
                   Ta = 20,
                   Rli = 300,
                   p = 970,
                   ea = 15,
                   u = 2,
                   Ca = 410,
                   Oa = 209)
args_aerodynamic <- list(zo = 0.25,
                         d = 1.34,
                         Cd = 0.3,
                         rb = 10,
                         CR = 0.35,
                         CD1 = 20.6,
                         Psicor = 0.2,
                         CSSOIL = 0.01,
                         rbs = 10,
                         rwc = 0)
args_timeseries <- list(startDOY = 20060618,
                        endDOY = 20300101,
                        LAT = 51.55,
                        LON = 5.55,
                        timezn = 1)
args_angles <- list(tts = 30,
                    tto = 0,
                    psi = 0)
path = "../../SCOPE/input/input_data_default.csv"

input_SCOPE <- readr::read_file(path)

string <- sprintf("'(?<=%s,).+'", names(c(args_PROSPECT,
                                          args_leaf_biochem,
                                          args_leaf_biochem_magnani,
                                          args_soil,
                                          args_canopy,
                                          args_meteo,
                                          args_aerodynamic,
                                          args_timeseries,
                                          args_angles)))
change_string <- paste(string, "=", names(c(args_PROSPECT,
                                            args_leaf_biochem,
                                            args_leaf_biochem_magnani,
                                            args_soil,
                                            args_canopy,
                                            args_meteo,
                                            args_aerodynamic,
                                            args_timeseries,
                                            args_angles)))
pattern_changed <- change_string %>%
  str_c(collapse = ",")

pattern_changed2 <- paste0("c(",pattern_changed,")")

input_SCOPE %>%
  str_replace_all(pattern_changed2)

input_SCOPE <- stringr::str_replace_all(input_SCOPE, print(pattern_changed, quote=FALSE))
}

utils::write.table(input_SCOPE, file = path,
            sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
