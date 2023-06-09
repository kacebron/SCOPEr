% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/05h_input_data_ts.R
\name{input_data_ts}
\alias{input_data_ts}
\title{Modifies input values for timeseries parameters within input_data_default.csv}
\usage{
input_data_ts(
  startDOY = 20060618,
  endDOY = 20300101,
  LAT = 51.55,
  LON = 5.55,
  timezn = 1
)
}
\arguments{
\item{startDOY}{Julian day (decimal) start of simulations}

\item{endDOY}{Julian day (decimal) end of simulations}

\item{LAT}{Latitude (decimal deg)}

\item{LON}{Longitude (decimal deg)}

\item{timezn}{east of Greenwich (hours)}

\item{path}{filepath of the filenames.csv}
}
\value{
Default values are given based on default SCOPE values in github
}
\description{
This function lets you modify input values for timeseries parameters inside input_data_default.csv contains.
}
