#' Modifies Leaf biochemical module within input_data_default.csv
#'
#' This function lets you modify input values for leaf biochemistry module inside input_data_default.csv contains.
#'
#' @param path filepath of the filenames.csv
#' @param Vcmax25 maximum carboxylation capacity (at optimum temperature of 25C, former Vcmo) (umol m-2 s-1)
#' @param BallBerrySlope slope of Ball-Berry stomatal conductance model (former m)
#' @param BallBerry0 intercept of Ball-Berry stomatal conductance model
#' @param Type Photochemical pathway: 0 => ‘C3’, 1 => ‘C4’
#' @param kV extinction coefficient for Vcmax in the vertical (maximum at the top). 0 for uniform Vcmax
#' @param Kn0 parameter for empirical Kn (NPQ) model: Kn = Kno * (1+beta).*x.^alpha./(beta + x.^alpha);
#' @param Knalpha alpha parameter for empirical Kn (NPQ) model: Kn = Kno * (1+beta).*x.^alpha./(beta + x.^alpha)
#' @param Knbeta beta parameter for empirical Kn (NPQ) model: Kn = Kno * (1+beta).*x.^alpha./(beta + x.^alpha)
#' @param Tyear mean annual temperature (deg C)
#' @param beta fraction of photons partitioned to PSII (0.507 for C3, 0.4 for C4; Yin et al. 2006 [10]; Yin and Struik 2012 [11])
#' @param kNPQs rate constant of sustained thermal dissipation (Porcar-Castell 2011 [3])
#' @param qLs fraction of functional reaction centres (Porcar-Castell 2011 [3])
#' @param stressfactor optional input: stress factor to reduce Vcmax (for example soil moisture, leaf age)
#' @param fqe fluorescence quantum yield efficiency at photosystem level
#'
#' @return Default values are given based on default SCOPE values in github
#' @export
input_data_leafBiochem <- function(path = "../SCOPE/input/input_data_default.csv",
                                Vcmax25 = 60,
                                BallBerrySlope = 8,
                                BallBerry0 = 0.01,
                                Type = 0,
                                kV = 0.64,
                                Rdparam = 0.015,
                                Kn0 = 2.48,
                                Knalpha = 2.83,
                                Knbeta = 0.114,
                                Tyear = 15,
                                beta = 0.51,
                                kNPQs = 0,
                                qLs = 1,
                                stressfactor = 1,
                                fqe = 0.01
                                ){
  input_SCOPE <- read_file(path)
  input_SCOPE <- str_replace_all(input_SCOPE, c("(\\n)$" = "",
                                                "(?<=Vcmax25,).+" = Vcmax25,
                                                "(?<=BallBerrySlope,).+" = BallBerrySlope,
                                                "(?<=BallBerry0,).+" = BallBerry0,
                                                "(?<=Type,).+" = Type,
                                                "(?<=kV,).+" = kV,
                                                "(?<=Rdparam,).+" = Rdparam,
                                                "(?<=Kn0,).+" = Kn0,
                                                "(?<=Knalpha,).+" = Knalpha,
                                                "(?<=Knbeta,).+" = Knbeta,
                                                "(?<=Tyear,).+" = Tyear,
                                                "(?<=beta,).+" = beta,
                                                "(?<=kNPQs,).+" = kNPQs,
                                                "(?<=qLs,).+" = qLs,
                                                "(?<=stressfactor,).+" = stressfactor,
                                                "(?<=fqe,).+" = fqe
                                                )
                                 )
  write.table(input_SCOPE, file = '../SCOPE/input/input_data_default.csv',
              sep=",", col.names=FALSE, row.names = FALSE, quote=FALSE, na="")
}
