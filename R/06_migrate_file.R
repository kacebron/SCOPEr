#' This function migrates all files to the SCOPE folder
#'
#' The migrate_file() function is a utility function that copies
#' files from the SCOPEr library to your local copy of SCOPE. The
#' function takes no arguments, and the file paths are hard-coded
#' within the function. The files to be copied include a set of
#' CSV files and a dataset folder. The function checks whether the
#' files have been successfully copied by comparing their modification
#' time to the current time, and issues appropriate messages
#' depending on the result of the check. Run this function before
#' running the run_scope()
#' @export
#'
migrate_file <- function() { # nolint

  # Get system.file path
  sys_path <- system.file(package = "SCOPEr")

  # Set the path to the set_parameter_filenames.csv
  orig_set_paramFile <- file.path(sprintf("%s/extdata", sys_path), # nolint
    "set_parameter_filenames.csv")
  new_set_paramFile <- file.path("./SCOPE", "set_parameter_filenames.csv") # nolint

  # Set the path to the setoptions.csv
  orig_setoptions <- file.path(sprintf("%s/extdata", sys_path),
    "setoptions.csv")
  new_setoptions <- file.path("./SCOPE/input", "setoptions.csv")

  # Set the path to the filenames.csv
  orig_filenames <- file.path(sprintf("%s/extdata", sys_path), "filenames.csv")
  new_filenames <- file.path("./SCOPE/input", "filenames.csv")

  # Set the path to the input_data_default.csv
  orig_input_data_default <- file.path(sprintf("%s/extdata", sys_path),
    "input_data_default.csv")
  new_input_data_default <- file.path("./SCOPE/input", "input_data_default.csv")

  # Set the path to the input_data_latin_hypercube.csv
  orig_input_hypercube <- file.path(sprintf("%s/extdata", sys_path),
    "input_data_latin_hypercube.csv")
  new_input_hypercube <- file.path("./SCOPE/input",
    "input_data_latin_hypercube.csv")

  # Set the path to the dataset folder ts
  orig_dataset <- file.path(sprintf(".%s/extdata/dataset %s",
    sys_path, dir_name)) # nolint
  new_dataset <- file.path("./SCOPE/input")

  # Copy the file to the new folder
  file.copy(from = orig_set_paramFile, to = new_set_paramFile, overwrite = TRUE)
  file.copy(from = orig_setoptions, to = new_setoptions, overwrite = TRUE)
  file.copy(from = orig_filenames, to = new_filenames, overwrite = TRUE)
  file.copy(from = orig_input_data_default, to = new_input_data_default,
    overwrite = TRUE)
  file.copy(from = orig_input_hypercube, to = new_input_hypercube,
    overwrite = TRUE)
  file.copy(from = orig_dataset, to = new_dataset, recursive = TRUE)

  # Check if file exists
  if (file.exists(new_set_paramFile) &&
      file.exists(new_setoptions) &&
      file.exists(new_filenames) &&
      file.exists(new_input_data_default) &&
      file.exists(new_dataset)) {

    # Get the file modification time
    file_mod_time_paramFile <- file.info(new_set_paramFile)$mtime # nolint
    file_mod_time_setoptions <- file.info(new_setoptions)$mtime
    file_mod_time_filenames <- file.info(new_filenames)$mtime
    file_mod_time_input_data_default <- file.info(new_input_data_default)$mtime # nolint
    file_mod_time_dataset <- file.info(new_dataset)$mtime

    # Get the current time
    current_time <- Sys.time()

    # Define time threshold for "recently modified"
    time_threshold <- 60 * 60 # One hour ago

    # Check if the file was recently modified
    if (difftime(current_time, file_mod_time_paramFile,
          units = "secs") < time_threshold &&
        difftime(current_time, file_mod_time_setoptions,
          units = "secs") < time_threshold &&
        difftime(current_time, file_mod_time_filenames,
          units = "secs") < time_threshold &&
        difftime(current_time, file_mod_time_input_data_default,
          units = "secs") < time_threshold &&
        difftime(current_time, file_mod_time_dataset,
          units = "secs") < time_threshold) {
      message("All files have been successfully migrated to SCOPE folder.")
    } else {
      warning("Files has not been updated.")
    }

  } else {
    print("File not found.")
  }
}

# End