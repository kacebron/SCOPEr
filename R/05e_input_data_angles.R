#' Modifies input values for solar angle within input_data_default.csv
#'
#' This function lets you modify input values for solar angle parameters inside input_data_default.csv contains.
#'
#' @param path filepath of the filenames.csv
#' @param tts solar zenith angle (deg)
#' @param tto observer zenith angle (deg)
#' @param psi azimuthal difference between solar and observation angle; relative azimuth angle (deg)
#'
#' @return Default values are given based on default SCOPE values in github
#' @examples input_data_angles(tts = 35)
#' @export
input_data_angles <- function(tts = 30,
                              tto = 0,
                              psi = 0
){
  path <- "./inst/extdata/input_data_default.csv"
  input_SCOPE <- readr::read_file(path)
  input_SCOPE <- stringr::str_replace_all(input_SCOPE, c("(\\n)$" = "",
                                                "(?<=tts,).+" = tts,
                                                "(?<=tto,).+" = tto,
                                                "(?<=psi,).+" = psi
  )
  )
  utils::write.table(input_SCOPE, file = path,
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
