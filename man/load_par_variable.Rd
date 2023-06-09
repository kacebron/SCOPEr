% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/03a_load_par_variable.R
\name{load_par_variable}
\alias{load_par_variable}
\title{Loads variable parameters from the meteorological data for the time series input}
\usage{
load_par_variable()
}
\description{
load_par_variable() prompts the user to select a CSV or RDS file containing meteorological data from an Eddy Covariance station. The user is then prompted to select specific columns from the data (namely, incoming radiation, air temperature and relative humidity). The function then performs some basic data cleaning operations including trimming the data based on initially set start and end times (which are not defined in the code provided), removing any rows with missing values, and renaming the selected columns to standard names. The cleaned dataframe is then returned. Overall, this function seems designed to help users load, clean and prepare meteorological data for further analysis.
}
