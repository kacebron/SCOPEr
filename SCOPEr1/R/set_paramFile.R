#' Modify set_parameter_filenames.csv
#' 
#' This function helps you modify set_parameter_filenames.csv input file in 
#' matlab for SCOPE to run. It works in three steps: 
#' 1. It reads the set_parameter_filenames.csv file using read_file().
#' 2. It lets you change input file from the default value of 
#' "input_data_latin_hypercube.csv" to "input_data_default.csv" using the 
#' argument "input"
#' 3. It saves the changes using write.table().
#' @export
set_paramFile <- function(input){
  set_param <- read_file("../SCOPE/set_parameter_filenames.csv")
  set_param <- str_replace(set_param, str_split(set_param, ", ")[[1]][3], 
                           input)
  write.table(set_param, file="../SCOPE/set_parameter_filenames.csv", 
              sep = ",", col.names = FALSE, row.names = FALSE, quote = FALSE)
}