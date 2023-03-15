#' Runs SCOPE.m in R
#'
#' This function runs SCOPE.m in R language. Copy and paste the location of the file SCOPE.m enclosed in open-close quotations.
#'
#' @param filepath is the location of the directory where SCOPE.m is stored.
#' @return The default value is "../../SCOPE/SCOPE.m". If this does not work, this means either you modify the name of your SCOPE model (*which is not recommended*) or your current working directory is somewhere else in the universe. In any case, just copy and paste the original filepath of SCOPE.m enclosed in quotations in case the default value does not work.
#' @export
run_scope <- function(filepath = "../../SCOPE/SCOPE.m"){
  matlabr::run_matlab_script(filepath,
                  verbose = TRUE,
                  desktop = FALSE,
                  splash = FALSE,
                  display = FALSE,
                  wait = TRUE,
                  single_thread = FALSE)
}
