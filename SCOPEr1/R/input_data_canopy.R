#' Modifies module for canopy properties within input_data_default.csv
#'
#' This function lets you modify input values for canopy properties inside input_data_default.csv contains.
#'
#' @param path filepath of the filenames.csv
#' @param LAI leaf area index (m2 m-2)
#' @param hc vegetation height (m)
#' @param LIDFa leaf inclination
#' @param LIDFb variation in leaf inclination
#' @param leafwidth leaf width  (m)
#' @param Cv (no description in github)
#' @param crowndiameter crown diameter (no units in github)
#'
#' @return Default values are given based on default SCOPE values in github
#' @export
input_data_canopy <- function(path = "../SCOPE/input/input_data_default.csv",
                                LAI = 3,
                                hc = 2,
                                LIDFa = -0.35,
                                LIDFb = -0.15,
                                leafwidth = 0.1,
                                Cv = 1,
                                crowndiameter = 1
                                ){
  input_SCOPE <- read_file(path)
  input_SCOPE <- str_replace_all(input_SCOPE, c("(\\n)$" = "",
                                                "(?<=LAI,).+" = LAI,
                                                "(?<=hc,).+" = hc,
                                                "(?<=LIDFa,).+" = LIDFa,
                                                "(?<=LIDFb,).+" = LIDFb,
                                                "(?<=leafwidth,).+" = leafwidth,
                                                "(?<=Cv,).+" = Cv,
                                                "(?<=crowndiameter,).+" = crowndiameter
  )
  )
  write.table(input_SCOPE, file = '../SCOPE/input/input_data_default.csv',
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
