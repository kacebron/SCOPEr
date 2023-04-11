#' Loads variable parameters from the meteorological data for the time series input
#'
#' load_par_variable() prompts the user to select a CSV or RDS file containing meteorological data from an Eddy Covariance station. The user is then prompted to select specific columns from the data (namely, incoming radiation, air temperature and relative humidity). The function then performs some basic data cleaning operations including trimming the data based on initially set start and end times (which are not defined in the code provided), removing any rows with missing values, and renaming the selected columns to standard names. The cleaned dataframe is then returned. Overall, this function seems designed to help users load, clean and prepare meteorological data for further analysis.
#'
# Define a function to prompt user to select CSV file and choose columns
load_par_variable <- function() {

  # Prompt user to choose CSV file
  message("Locate the meteorological data from EC station")
  file_path <- file.choose()

  # Check file extension
  file_ext <- tools::file_ext(file_path)

  # Use if-else statement to read file
  if (file_ext == "csv" | file_ext == "txt") {
    # Read CSV file
    data <- read.csv(file_path, sep=",")
  } else if (file_ext == "Rds") {
    # Read RDS file
    data <- readRDS(file_path)
  } else {
    # Unknown file type
    stop("Unsupported file type")
  }

  # Notice
  message("please enter the following column names, and pay attention with capital letters")

  # Prompt user to select columns
  Rin_col <- as.character(readline("Enter column name for incoming radiation: "))
  Ta_col <- as.character(readline("Enter column name for air temperature: "))
  RH_col <- as.character(readline("Enter column name for relative humidity: "))
  Date_col <- as.character(readline("Enter column name for date: "))

  # Change column names based on user inputs
  data2 <- data[, c(Rin_col, Ta_col, RH_col, Date_col)]
  names(data2) <- c("Rin", "Ta", "RH", "Date")

  # Trim data based on global start and end times
  data_trimmed <- data2[data2$Date >= start_time & data2$Date <= end_time, ]

  # Remove rows with NA values
  data_trimmed <- na.omit(data_trimmed)

  return(data_trimmed)
}
