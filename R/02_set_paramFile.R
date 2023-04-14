#' Modify set_parameter_filenames.csv
#'
#' This function helps you modify set_parameter_filenames.csv input file.
#'
#' @param input Change the name of the .csv file where input data will be grabbed by SCOPE.
#'
#' @return **input** By default, the value of this argument is "input_data_latin_hypercube.csv" which is also the default setting in SCOPE. Change this to "input_data_default.csv" if you want to simulate individual runs or time series experiments. Note: You can also changed the default values inside the input_data_default.csv using the function input_data_default().
#' @export
#'
set_paramFile <- function(input = "input_data_latin_hypercube.csv"){
  set_paramfile_csv <- system.file("extdata", "set_parameter_filenames.csv", package = "SCOPEr")
  set_param <- readr::read_file(set_paramfile_csv)
  set_param <- stringr::str_replace(set_param, stringr::str_split(set_param, ", ")[[1]][3],
                           input)
  utils::write.table(set_param, file=set_paramfile_csv,
              sep = ",", col.names = FALSE, row.names = FALSE, quote = FALSE)
}
