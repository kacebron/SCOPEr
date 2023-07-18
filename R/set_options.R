#' Modify setoptions.csv
#'
#' This function helps you modify setoptions.csv. It reads in a CSV
#' file of options for SCOPE, modifies the values of those options
#' based on the input parameters, and writes the updated options back
#' to the CSV file. The function takes several parameters with default
#' values, primarily `verify` and `simulation`, which control aspects
#' of the SCOPE simulation. This function is intended to make it easy
#' to customize the SCOPE simulation options without modifying the
#' underlying MATLAB code directly.
#'
#' For User's Comfort, run this code with arguments verify = FALSE
#'
#' @param verify Lets you switch verification mode.
#' @param simulation Defines rules for input reading.
#'
#' @return **MAIN**
#' @return **verify** Default value is TRUE which means the run will
#' compare output to the verification dataset to test the integrity of
#' your SCOPE copy. FALSE will switch off the verification mode.
#' Note: You would need to switch off the verification mode if you
#' want to do actual simulations.
#' @return **simulation** Default value is 0 which is equal to
#' individual runs. Other options can be 1 (time series runs) or 2
#' (for look-up table).
#' @export
#'
set_options <- function(
    verify = TRUE,
    simulation = 0) {
  setoptions_csv <- "~/Documents/1_postdoc_projects/1_serc_nasa_roses/02_projects/SCOPE/input/setoptions.csv"
  set_options <- readr::read_file(setoptions_csv)
  set_options <- stringr::str_replace_all(set_options,
                                          c("(\\n)$" = "",
                                            ".(?=,verify)" = ifelse(verify == TRUE, "1", "0"),
                                            ".(?=,simulation)" = simulation
                                          ))
  utils::write.table(set_options, file = setoptions_csv, sep = ",",
                     col.names = FALSE, row.names = FALSE, quote = FALSE)
}

# End
