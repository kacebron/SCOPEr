#' Modifies input values for aerodynamic parameters within input_data_default.csv
#'
#' This function lets you modify input values for aerodynamic parameters inside input_data_default.csv contains.
#'
#' @param path filepath of the filenames.csv
#' @param zo roughness length for momentum of the canopy (m)
#' @param d displacement height (m)
#' @param Cd leaf drag coefficient
#' @param rb leaf boundary resistance (s m-1)
#' @param CR Verhoef et al. (1997) Drag coefficient for isolated tree
#' @param CD1 Verhoef et al. (1997) fitting parameter
#' @param Psicor Verhoef et al. (1997) Roughness layer correction
#' @param CSSOIL Drag coefficient for soil Verhoef et al. (1997) (from Aerodynamic)
#' @param rbs soil boundary layer resistance (from Aerodynamic) (s m-1)
#' @param rwc within canopy layer resistance
#'
#' @return Default values are given based on default SCOPE values in github
#' @examples input_data_aero(zo = 0.3)
#' @export
input_data_aero <- function(zo = 0.25,
                            d = 1.34,
                            Cd = 0.3,
                            rb = 10,
                            CR = 0.35,
                            CD1 = 20.6,
                            Psicor = 0.2,
                            CSSOIL = 0.01,
                            rbs = 10,
                            rwc = 0
){
  path <- file.choose()
  input_SCOPE <- readr::read_file(path)
  input_SCOPE <- stringr::str_replace_all(input_SCOPE, c("(\\n)$" = "",
                                                "(?<=zo,).+" = zo,
                                                "(?<=d,).+" = d,
                                                "(?<=Cd,).+" = Cd,
                                                "(?<=rb,).+" = rb,
                                                "(?<=CR,).+" = CR,
                                                "(?<=CD1,).+" = CD1,
                                                "(?<=Psicor,).+" = Psicor,
                                                "(?<=CSSOIL,).+" = CSSOIL,
                                                "(?<=rbs,).+" = rbs,
                                                "(?<=rwc,).+" = rwc
  )
  )
  utils::write.table(input_SCOPE, file = path,
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
