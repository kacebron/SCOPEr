#' Load Reflectance Data
#'
#' This function loads reflectance data from a file,
#' combines it with year and DoY from aPAR.csv,
#' and returns a data frame.
#'
#' @param folder Character string specifying the folder
#' containing the data files (default is current directory).
#' @param start_time Character string specifying the
#' starting time in the format YYYY-DOY.
#' @param end_time Character string specifying the
#' ending time in the format YYYY-DOY.
#'
#' @return A data frame containing the combined reflectance data.
#'
#' @export
#'
load_refl_data <- function(folder = ".", start_time, end_time) {
  # Set the working directory to the specified folder
  setwd(folder)

  # Load the aPAR.csv file as a data frame, excluding the first row
  apar_data <- read.csv("aPAR.csv", header = TRUE)

  # Remove the first row that contains the units
  apar_data <- apar_data[-1, ]

  # Convert character columns to numeric
  char_columns <- c("iPAR", "iPARE", "LAIsunlit", "LAIshaded",
  "aPARtot", "aPARsun", "aPARsha", "aPARCabtot", "aPARCabsun",
  "aPARCabsha", "aPARCartot", "aPARCarsun", "aPARCarsha",
  "aPARtotE", "aPARsunE", "aPARshaE", "aPARCabtotE", "aPARCabsunE",
  "aPARCabshaE", "aPARCartotE","aPARCarsunE", "aPARCarshaE")

  apar_data[, char_columns] <- lapply(apar_data[, char_columns],
    function(x) as.numeric(gsub("[[:alpha:]]", "", x)))

   # Separate decimal numbers from the integers in 'DoY' column
   # and keep only the integers
  apar_data$DoY2 <- floor(apar_data$DoY)

  # Combine 'Year' and 'DoY' columns into a single column
  apar_data$DateTime <- paste0(apar_data$year, "-", apar_data$DoY2)

  # Find the row numbers of the matching start and end times
  start_row <- min(which(apar_data$DateTime == start_time))
  end_row <- max(which(apar_data$DateTime == end_time))

  apar_data_sub <- apar_data[apar_data$DateTime >= start_time &
    apar_data$DateTime <= end_time, ]

   # Read rows from start_row to end_row from apparent_reflectance.csv,
   # excluding the first row
  app_ref_data <- scan("apparent_reflectance.csv", skip = 2,
    nlines = end_row - start_row + 1, sep = ",")

  # Convert app_ref_data into a matrix with 2162 columns
  mat <- matrix(app_ref_data, ncol = 2162, byrow = TRUE)

  # Create column names by pasting 'lambda' and a sequence of
  # integers from 400 to 5000
  column_names <- c("year-DoY", paste("lambda", c(seq(400, 2400, 1),
    seq(2500, 15000, 100), seq(16000, 50000, 1000)) , sep = "_"))

  # Create a data frame by column binding the pasted year and DoY
  # vector and the app_ref_data
  combined_data <- cbind(paste(apar_data_sub$year, apar_data_sub$DoY,
    sep = "-"), mat)

  # Set the column names of the combined data frame
  colnames(combined_data) <- column_names[]

  # Return the combined data frame
  return(combined_data)
}
