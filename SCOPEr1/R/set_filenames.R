#' Modify filenames.csv
#' 
#' This function helps you modify filenames.csv
#' 
#' Arguments
#' simulation_name    Here you can input a string of character to create a simulation name
#' dataset_dir        Here you can specify the directory of the dataset for the input files
#' meteo_ec_csv       Here you can specify the name of the .csv file that contains the meteorological information to be used in time series runs
#' tts                Here you can specify a value for the solar zenith angle. NOTE: this must be equal to blank if timezone, latitude and longitude are specified in the input.filename
#' @export
set_filenames <- function(simulation_name, dataset_dir, meteo_ec_csv, tts){
  filenames <- read_file("../SCOPE/input/filenames.csv")
  filenames <- str_replace_all(filenames, 
                               c("(\\n)$" = "",
                                 "(?<=Simulation_Name,).+" = simulation_name,
                                 "(?<=Dataset_dir,).+" = dataset_dir,
                                 "(?<=meteo_ec_csv,)(?! ).+" = paste0((meteo_ec_csv),".csv"),
                                 "(?<=tts,).+" = tts
                               ))
  write.table(filenames, file='../SCOPE/input/filenames.csv', sep=",", 
              col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}