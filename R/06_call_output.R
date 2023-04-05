#' This calls out the filepath of the type of SCOPE output you need for further analysis
#'
#' @param path file path of the directory where output is located.
#' @param type type of output you want to analyse. See SCOPE description in github for details
#' @return The default file path assumes that the output from SCOPE is successfully transferred in bcipanama repository. 
#' @return List of output are as follows: aPAR, apparent_reflectance, Eout_spectrum, Esky, Esun, fluorescence_hemis, fluorescence_ReabsCorr, fluorescence_scalars, fluorescence, fluxes, Lo_spectrum_inclF, Lo_spectrum, Parameters (folder not a .csv), pars_and_input_short, radiation, rdd, rdo, reflectance, resistances, rsd, rso, sigmaF, vegetation, wlF, and wlS
#' @examples call_output(path = "../bcipanama/7_scope/scope_output", type=fluxes)
#' @export
call_output <- function(path, type){
  ls.dirs <- list.dirs(path)
  ls.file <- list.files(path = ls.dirs[3], full.names = TRUE)
  out <- ls.file[grep(pattern =type, ls.file)]
  return(out)
}
