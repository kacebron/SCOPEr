#' Modifies input values for timeseries parameters within input_data_default.csv
#'
#' This function lets you modify input values for timeseries parameters inside input_data_default.csv contains.
#'
#' @param path filepath of the filenames.csv
#' @param startDOY Julian day (decimal) start of simulations
#' @param endDOY Julian day (decimal) end of simulations
#' @param LAT Latitude (decimal deg)
#' @param LON Longitude (decimal deg)
#' @param timezn east of Greenwich (hours)
#'
#' @return Default values are given based on default SCOPE values in github
#' @export
input_data_ts <- function(path = "../SCOPE/input/input_data_default.csv",
                                startDOY = 20060618,
                                endDOY = 20300101,
                                LAT = 51.55,
                                LON = 5.55,
                                timezn = 1
){
  input_SCOPE <- read_file(path)
  input_SCOPE <- str_replace_all(input_SCOPE, c("(\\n)$" = "",
                                                "(?<=startDOY,).+" = startDOY,
                                                "(?<=endDOY,).+" = endDOY,
                                                "(?<=LAT,).+" = LAT,
                                                "(?<=LON,).+" = LON,
                                                "(?<=timezn,).+" = timezn
  )
  )
  write.table(input_SCOPE, file = '../SCOPE/input/input_data_default.csv',
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
