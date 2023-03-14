#' Modify setoptions.csv
#' 
#' This function helps you modify setoptions.csv
#' Arguments
#' verify       Verifies the results to test the code for the first time. Uses 
#'              binary to switch on (1) and off (0) the mode.
#' simulate     Defines rules for input reading. Values can be 0 (individual runs),
#'              1 (time series runs), or 2 (look-up table)
#' ...
#' NOTE: more arguments can be added here based on the actual list of parameters
#' inside setoptions.csv
#' @export
set_options <- function(verify, simulate){
  set_options <- readr::read_file("../SCOPE/input/setoptions.csv")
  set_options <- stringr::str_replace_all(set_options, 
                                 c("(\\n)$" = "",
                                   ".(?=,verify)" = verify,
                                   ".(?=,simulation)" = simulate))
  utils::write.table(set_options, file = "../SCOPE/input/setoptions.csv", sep=",",  
              col.names = FALSE, row.names = FALSE, quote = FALSE)
}
