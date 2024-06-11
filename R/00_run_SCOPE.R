#' Runs SCOPE.m in R
#'
#' This function runs SCOPE.m in R language.
#'
#' @param SCOPE_path filepath where SCOPE.m is located
#'
#' @importFrom matlabr run_matlab_script
#'
#' @return The function accepts a string parameter, path, that represents the directory path where SCOPE.m is located. If the path is not specified, the function prompts the user to choose the file location interactively. Once the path is determined, the function saves it to an R environment variable named SCOPE_PATH, which can be used in subsequent function calls to avoid re-locating SCOPE.m.
#'
#' @return Additionally, the function creates an R session hook that removes the SCOPE_PATH variable when the R session is terminated, ensuring that the path is not persisted across different sessions.
#'
#' @return This function can be called with a directory path as an argument, or without arguments to prompt the user to select the file interactively. Once the path is determined, the function saves it to the SCOPE_PATH variable in the global environment. The on.exit() hook ensures that the SCOPE_PATH variable is removed when the R session is terminated.
#'
#' @export


run_scope <- function(SCOPE_path = ".././SCOPE/SCOPE.m") {

  # Prompt the user to select the SCOPE.m file path
  if (exists("SCOPE_path")) {
    message("File path for SCOPE.m has already been set!")
  } else {
    # If the file path hasn't been set, use file.choose() to select a file
    current_dir <- getwd()
    message(sprintf("Please locate SCOPE.m in your file directory from %s", current_dir)) # nolint
    SCOPE_path <- file.choose()
    # Store the file path in a variable within the session
    assign("SCOPE_path", SCOPE_path, envir = .GlobalEnv)
    message(paste("File path set to", SCOPE_path))
  }
  # Get the selected file path from the file_path variable
  SCOPE_path <- SCOPE_path

  # Run the SCOPE.m script using the run_matlab_script() function
  matlabr::run_matlab_script(SCOPE_path,
    verbose = TRUE,
    desktop = FALSE,
    splash = FALSE,
    display = FALSE,
    wait = TRUE,
    single_thread = FALSE)
}

# This code should remove the file path of SCOPE when you terminate your session
#on.exit(rm("SCOPE_path", envir = .GlobalEnv))
