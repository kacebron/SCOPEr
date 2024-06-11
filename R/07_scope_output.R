#' Lists outputs from SCOPE simulations
#'
#' @param output_dir filepath of SCOPE output directory
#' @param except files to exclude (works with regex too)
#' @param subset files to subset
#' @export

# This function calls out all SCOPE output and arrange them in a dataframe.
# Subset is a regular expression, e.g. "DS|WS", "CLUSTER"
scope_output <- function(output_dir = "../.././SCOPE/output/", except, subset) {

  # List all results of model runs
  root <- list.files(path = output_dir, all.files = TRUE)

  # Weed out unwanted files
  root <- root[!root %in% c(".", "..", ".DS_Store", "verificationdata")]

  # Arguments for exemption
  if (missing(except)) {
    print("all files within SCOPE outpuf folder are included")
    # Exclude files
  } else {
    root <- root[!root %in% except]
  }

  # Arguments for subsetting
  if (missing(subset)) {
    print("subsetting is not defined")
    # subset
  } else {
    root <- root[grep(subset, root)]
  }

  # List of all types of output for each model run.
  out <- list.files(path = paste0(output_dir, "verificationdata/"),
                    all.files = TRUE)
  # Weed out unwanted files
  out <- out[!out %in% c(".", "..", ".DS_Store")]

  # Generating all combinations of model configurations and output types
  outputs_df <- expand.grid(root = root, out = out)

  # Creating filenames by combining paths and components
  outputs_df$filenames <- paste0(output_dir, outputs_df$root, "/",
                                 outputs_df$out)

  rm(list = c("out", "root"))

  return(outputs_df)
}
