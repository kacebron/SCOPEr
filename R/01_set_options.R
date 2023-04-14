#' Modify setoptions.csv
#'
#' This function helps you modify setoptions.csv. It reads in a CSV file of options for SCOPE, modifies the values of those options based on the input parameters, and writes the updated options back to the CSV file. The function takes several parameters with default values, primarily `verify` and `simulation`, which control aspects of the SCOPE simulation. This function is intended to make it easy to customize the SCOPE simulation options without modifying the underlying MATLAB code directly.
#' For User's Comfort, run this code with arguments verify = FALSE
#'
#' @param verify (For User's Comfort) Lets you switch verification mode.
#' @param simulation Defines rules for input reading.
#' @param lite Switch in RTMo().
#' @param calc_fluor Calculation of fluorescence. This is a switch in SCOPE.m, calc_brdf().
#' @param calc_planck Calculate spectrum of thermal radiation with spectral emissivity instead of broadband. WARNING! This is only effective with calc_ebal==1.
#' @param calc_xanthophyllabs Calculate dynamic xanthopyll absorption (zeaxanthin) for simulating PRI (photochemical reflectance index). WARNING! only effective with calc_ebal==1.
#' @param soilspectrum Calculate soil reflectance or use from a file in ./input/soil_spectra. Switch in SCOPE.m
#' @param Fluorescence_model Switch in ebal().
#' @param applTcorr Correct Vcmax and rate constants for temperature. This is only effective with Fluorescence_model == 0 i.e. for biochemical(). This is a switch in ebal().
#' @param saveCSV (For User's Comfort) Switch in SCOPE.m, bin_to_csv().
#' @param mSCOPE Switch in SCOPE.m.
#' @param calc_directional Calculate BRDF and directional temperature for many angles specified in the file: directional. Warning! This is only effective with calc_ebal == 1. Be patient, this takes some time. This is a Switch in SCOPE.m, calc_brdf().
#' @param calc_vert_profiles Calculation of vertical profiles (per 60 canopy layers). Corresponding structure profiles. This is a Switch in SCOPE.m, RTMo() and ebal().
#' @param soil_heat_method Method of ground heat flux (G) calculation. In soil_heat_method 0 and 1 soil thermal inertia (GAM) is calculated from inputs. Switch in SCOPE.m, select_input(), ebal().
#' @param calc_rss_rbs soil resistance for evaporation from the pore space (rss) and soil boundary layer resistance (rbs). Switch in select_input().
#' @param MoninObukhov Switch in ebal().
#' @param save_spectral (For User's Comfort) Save files with full spectrum. May reach huge sizes in long time-series. Switch in create_output_files_binary().
#'
#' @return **MAIN**
#' @return **verify** Default value is TRUE which means the run will compare output to the verification dataset to test the integrity of your SCOPE copy. FALSE will switch off the verification mode. Note: You would need to switch off the verification mode if you want to do actual simulations.
#' @return **simulation** Default value is 0 which is equal to individual runs. Other options can be 1 (time series runs) or 2 (for look-up table).
#' @return **OTHERS**
#' @return **lite** By default, the value is TRUE which means it will execute Lite SCOPE with [nlayers x 1] sunlit leaves, sunlit leaf inclinations are not accounted for. FALSE will run in normal SCOPE execution with [13 x 36 x nlayers] sunlit leaves. This is equivalent to changing to 0 in the setoptions.csv file.
#' @return **calc_fluor** By default, the value is TRUE which means RTMf() is launched in SCOPE.m and calc_brdf() (if calc_directional). Total emitted fluorescence is calculated by SCOPE.m. If value is FALSE, no fluorescence output.
#' @return **calc_planck** By default, the value is TRUE which means RTMt_planck() is launched in SCOPE.m and calc_brdf() (if calc_directional).Calculation is done per each wavelength thus takes more time than Stefan-Boltzman. If value is FALSE, RTMt_sb() - broadband brightness temperature is calculated in accordance to Stefan-Boltzman’s equation.
#' @return **calc_xanthophyllabs** By default, the value is TRUE which means RTMz() is launched in SCOPE.m and calc_brdf() (if calc_directional). If FALSE, value is changed to 0.
#' @return **soilspectrum** By default, the value is FALSE which means it uses soil spectrum from the file with soil.spectrum default file is soilnew.txt, can be changed on the filenames sheet soil_file cell variable name is rsfile. If value is TRUE, it will simulate soil spectrum with the BSM model (BSM()). Parameters are fixed in code.
#' @return **fluorescence_model** By default, the value is FALSE which means it will run empirical, with sigmoid for Kn: biochemical() (Berry-Van der Tol). If value is TRUE, it will use biochemical_MD12() (von Caemmerer-Magnani).
#' @return **applTcorr** By default the value is TRUE which means it will do correction in accordance to Q10 rule. If FALSE, it will change the value to 0 (no description in SCOPE's github).
#' @return **saveCSV** By default, the value is TRUE which means it will convert .bin files to .csv with bin_to_csv(), delete .bin files. If value is FALSE, it will leave .bin files in output folder.
#' @return **mSCOPE** By default, the value is FALSE which means it will do a traditional single layer SCOPE. If changed to TRUE, it will run a multilayer mSCOPE (see details here: https://scope-model.readthedocs.io/en/master/mSCOPE.html#mscope).
#' @return **calc_directional** Default value is FALSE. If TRUE, struct directional is loaded from the file directional. calc_brdf() is launched in SCOPE.m.
#' @return **calc_vert_profiles** Default value is FALSE which means profiles are not calculated. If TRUE, Photosynthetically active radiation (PAR) per layer is calculated in RTMo(). Energy, temperature and photosynthesis fluxes per layer are calculated in ebal(). Fluorescence fluxes are calculated in RTMf() if (calc_fluor).
#' @return **soil_heat_method** Default value is 2 which means as constant fraction (0.35) of soil net radiation. Change to 0 and it will do standard calculation of thermal inertia from soil characteristic. 1 means empirically calibrated formula from soil moisture content. Soil_Inertia1() in select_input().
#' @return **calc_rss_rbs** Default value is FALSE which means it will use resistance rss and rbs as provided in inputdata soil. If value is TRUE, it will calculate rss from soil moisture content and correct rbs for LAI calc_rssrbs().
#' @return **MoninObukhov** Default value is TRUE which means it will apply Monin-Obukhov atmospheric stability correction. If FALSE, it will not apply Monin-Obukhov atmospheric stability correction.
#' @return **save_spectral** Default value is TRUE which will save, FALSE it will not save.
#' @export
set_options <- function(verify = TRUE,
                        simulation = 0,
                        lite = TRUE,
                        calc_fluor = TRUE,
                        calc_planck = TRUE,
                        calc_xanthophyllabs = TRUE,
                        soilspectrum = FALSE,
                        fluorescence_model = FALSE,
                        applTcorr = TRUE,
                        saveCSV = TRUE,
                        mSCOPE = FALSE,
                        calc_directional = FALSE,
                        calc_vert_profiles = FALSE,
                        soil_heat_method = 2,
                        calc_rss_rbs = FALSE,
                        MoninObukhov = TRUE,
                        save_spectral = TRUE
                        ){
  setoptions_csv <- system.file("extdata", "setoptions.csv", package = "SCOPEr")
  set_options <- readr::read_file(setoptions_csv)
  set_options <- stringr::str_replace_all(set_options,
                                 c("(\\n)$" = "",
                                   ".(?=,verify)" = ifelse(verify == TRUE, "1", "0"),
                                   ".(?=,simulation)" = simulation,
                                   ".(?=,lite)" = ifelse(lite == TRUE, "1", "0"),
                                   ".(?=,calc_fluor)" = ifelse(calc_fluor == TRUE, "1", "0"),
                                   ".(?=,calc_planck)" = ifelse(calc_planck == TRUE, "1", "0"),
                                   ".(?=,calc_xanthophyllabs)" = ifelse(calc_xanthophyllabs == TRUE, "1", "0"),
                                   ".(?=,soilspectrum)" = ifelse(soilspectrum == TRUE, "1", "0"),
                                   ".(?=,Fluorescence_model)" = ifelse(fluorescence_model == TRUE, "1", "0"),
                                   ".(?=,applTcorr)" = ifelse(applTcorr == TRUE, "1", "0"),
                                   ".(?=,saveCSV)" = ifelse(saveCSV == TRUE, "1", "0"),
                                   ".(?=,mSCOPE)" = ifelse(mSCOPE == TRUE, "1", "0"),
                                   ".(?=,calc_directional)" = ifelse(calc_directional == TRUE, "1", "0"),
                                   ".(?=,calc_vert_profiles)" = ifelse(calc_vert_profiles == TRUE, "1", "0"),
                                   ".(?=,soil_heat_method)" = soil_heat_method,
                                   ".(?=,calc_rss_rbs)" = ifelse(calc_rss_rbs == TRUE, "1", "0"),
                                   ".(?=,MoninObukhov)" = ifelse(MoninObukhov == TRUE, "1", "0"),
                                   ".(?=,save_spectral)" = ifelse(save_spectral == TRUE, "1", "0")
                                   ))
  utils::write.table(set_options, file = setoptions_csv, sep=",",
              col.names = FALSE, row.names = FALSE, quote = FALSE)

  # Prompt users to enter start & end time (and span) if its a time series experiment
  if (simulation == 1) {
    print("You set to simulate time-series runs")
    start_time <<- as.POSIXct(strftime(readline("Enter start time (YYYY-MM-DD HH:MM): "), format = "%Y-%m-%d %H:%M"))
    end_time <<- as.POSIXct(strftime(readline("Enter end time (YYYY-MM-DD HH:MM): "), format = "%Y-%m-%d %H:%M"))
    span <<- readline("Enter span (%d unit): ")
  } else if (simulation == 2) {
    print("You set to simulate look-up table")
  } else {
    # No response if simulation is not 1 or 2
    print("You set to simulate individual run")
  }
}

# span function that converts any units of time into minutes. This is needed to average the meteo data based on the resolution we need.

convert_to_minutes <- function(span) {
  # span: character string containing time and unit (e.g. "3 hours")

  # use regular expressions to extract numeric value and unit
  time <- as.numeric(gsub("[^[:digit:].]", "", span))
  unit <- gsub("[[:digit:]. ]", "", span)

  # convert time to minutes based on unit
  if (unit == "hour") {
    minutes <- time * 60
  } else if (unit == "day") {
    minutes <- time * 24 * 60
  } else if (unit == "week") {
    minutes <- time * 7 * 24 * 60
  } else if (unit == "month") {
    minutes <- time * 30.44 * 24 * 60
  } else if (unit == "year") {
    minutes <- time * 365.25 * 24 * 60
  } else {
    stop("Invalid unit. Please enter 'hour', 'day', 'week', 'month', or 'year'.")
  }

  return(minutes)
}
