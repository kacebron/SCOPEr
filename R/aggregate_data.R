#' Aggregate data based on span
#'
#' aggregate_data is a function that aggregates time-series data based on a specified time span. It takes a dataframe of time-series data, and a time span (in minutes) as arguments and returns an aggregated dataframe. The function groups the data based on the specified time span and calculates the mean of each group for the data columns.
#'
#' @param data_trimmed: A dataframe of time-series data with columns named Date, Time, Measurement_1, Measurement_2, and so on.
#' @param span: A numeric value that represents the time span in minutes. It specifies the time interval for grouping the data.
#'
#' @return The function converts the span value to minutes and determines the grouping for the data based on the time span. If the time span is less than or equal to 30 minutes, no aggregation is performed, and the original data is returned. If the time span is greater than 30 minutes, the data is aggregated based on the specified time span.
#'
#' The function uses the aggregate function to group the data and calculate the mean of each group for the data columns. The function then converts the Date column of the aggregated dataframe to the appropriate date format based on the grouping interval.
#'
#' @return The function returns an aggregated dataframe with the same columns as the input dataframe, but with the data aggregated based on the specified time span.
#'
#' @export
# function to aggregate data based on time span
aggregate_data <- function(data_trimmed, span) {

  # convert span to minutes
  span_in_minutes <- convert_to_minutes(span)

  # convert Date to as.POSIXct (critical for aggregating hourly)
  data_trimmed$Date <- as.POSIXct(data_trimmed$Date, format="%Y-%m-%d %H:%M:%S")

  # determine grouping based on span
  if (span_in_minutes <= 30) {
    # do not aggregate data
    agg_data <- data_trimmed
  } else if (span_in_minutes <= 60) {
    # aggregate data every hour
    agg_data <- stats::aggregate(data_trimmed[,1:4], by=list(group_hour=format(data_trimmed$Date, "%Y-%m-%d %H")), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_hour, format="%Y-%m-%d %H")
    agg_data$group_hour <- NULL
  } else if (span_in_minutes <= 120) {
    # aggregate data every 2 hours
    data_trimmed$group_2hour <- format(as.POSIXct(floor(as.numeric(data_trimmed$Date)/(2*60*60))*2*60*60, origin="1970-01-01"),"%Y-%m-%d %H:%M:%S")
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_2hour=data_trimmed$group_2hour), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_2hour, format="%Y-%m-%d %H:%M:%S")
    agg_data$group_2hour <- NULL
  } else if (span_in_minutes <= 180) {
    # aggregate data every 3 hours
    data_trimmed$group_3hour <- format(as.POSIXct(floor(as.numeric(data_trimmed$Date)/(3*60*60))*3*60*60, origin="1970-01-01"),"%Y-%m-%d %H:%M:%S")
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_3hour=data_trimmed$group_3hour), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_3hour, format="%Y-%m-%d %H:%M:%S")
    agg_data$group_3hour <- NULL
  } else if (span_in_minutes <= 240) {
    # aggregate data every 4 hours
    data_trimmed$group_4hour <- format(as.POSIXct(floor(as.numeric(data_trimmed$Date)/(4*60*60))*4*60*60, origin="1970-01-01"),"%Y-%m-%d %H:%M:%S")
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_4hour=data_trimmed$group_4hour), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_4hour, format="%Y-%m-%d %H:%M:%S")
    agg_data$group_4hour <- NULL
  } else if (span_in_minutes <= 300) {
    # aggregate data every 5 hours
    data_trimmed$group_5hour <- format(as.POSIXct(floor(as.numeric(data_trimmed$Date)/(5*60*60))*5*60*60, origin="1970-01-01"),"%Y-%m-%d %H:%M:%S")
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_5hour=data_trimmed$group_5hour), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_5hour, format="%Y-%m-%d %H:%M:%S")
    agg_data$group_5hour <- NULL
  } else if (span_in_minutes <= 360) {
    # aggregate data every 6 hours
    data_trimmed$group_6hour <- format(as.POSIXct(floor(as.numeric(data_trimmed$Date)/(6*60*60))*6*60*60, origin="1970-01-01"),"%Y-%m-%d %H:%M:%S")
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_6hour=data_trimmed$group_6hour), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_6hour, format="%Y-%m-%d %H:%M:%S")
    agg_data$group_6hour <- NULL
  } else if (span_in_minutes <= 420) {
    # aggregate data every 7 hours
    data_trimmed$group_7hour <- format(as.POSIXct(floor(as.numeric(data_trimmed$Date)/(7*60*60))*7*60*60, origin="1970-01-01"),"%Y-%m-%d %H:%M:%S")
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_7hour=data_trimmed$group_7hour), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_7hour, format="%Y-%m-%d %H:%M:%S")
    agg_data$group_7hour <- NULL
  } else if (span_in_minutes <= 480) {
    # aggregate data every 8 hours
    data_trimmed$group_8hour <- format(as.POSIXct(floor(as.numeric(data_trimmed$Date)/(8*60*60))*8*60*60, origin="1970-01-01"),"%Y-%m-%d %H:%M:%S")
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_8hour=data_trimmed$group_8hour), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_8hour, format="%Y-%m-%d %H:%M:%S")
    agg_data$group_8hour <- NULL
  } else if (span_in_minutes <= 1440) {
    # aggregate data every day
    agg_data <- stats::aggregate(data_trimmed[,1:4], by=list(group_day=format(data_trimmed$Date, "%Y-%m-%d")), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_day, format="%Y-%m-%d")
    agg_data$group_day <- NULL
  } else if (span_in_minutes <= 43200) {
    # aggregate data every week
    agg_data <- stats::aggregate(data_trimmed[,1:4], by=list(group_week=zoo::as.yearqtr(data_trimmed$Date, "%Y-%m-%d") + as.integer(format(data_trimmed$Date, "%W"))/100), mean)
    agg_data$Date <- as.Date(paste(substr(as.character(agg_data$group_week), 1, 4), "-", substr(as.character(agg_data$group_week), 6, 6), "-01"), "%Y-%m-%d")
    agg_data$group_week <- NULL
  } else if (span_in_minutes <= 525600) {
    # aggregate data every month
    agg_data <- stats::aggregate(data_trimmed[,1:4], by=list(group_month=format(data_trimmed$Date, "%Y-%m")), mean)
    agg_data$Date <- as.POSIXct(paste0(agg_data$group_month, "-01"), format="%Y-%m-%d")
    agg_data$group_month <- NULL
  } else {
    # aggregate data every year
    agg_data <- stats::aggregate(data_trimmed[,1:4], by=list(group_year=format(data_trimmed$Date, "%Y")), mean)
    agg_data$Date <- as.POSIXct(paste0(agg_data$group_year, "-01-01"), format="%Y-%m-%d")
    agg_data$group_year <- NULL
  }

  # return the aggregated data
  return(agg_data)
}
