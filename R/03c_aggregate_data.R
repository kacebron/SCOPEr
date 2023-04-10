# function to aggregate data based on time span
aggregate_data <- function(data_trimmed, span) {

  # convert span to minutes
  span_in_minutes <- convert_to_minutes(span)

  # determine grouping based on span
  if (span_in_minutes <= 30) {
    # do not aggregate data
    agg_data <- data_trimmed
  } else if (span_in_minutes <= 60) {
    # aggregate data every hour
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_hour=format(data_trimmed$Date, "%Y-%m-%d %H")), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_hour, format="%Y-%m-%d %H")
    agg_data$group_hour <- NULL
  } else if (span_in_minutes <= 1440) {
    # aggregate data every day
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_day=format(data_trimmed$Date, "%Y-%m-%d")), mean)
    agg_data$Date <- as.POSIXct(agg_data$group_day, format="%Y-%m-%d")
    agg_data$group_day <- NULL
  } else if (span_in_minutes <= 43200) {
    # aggregate data every week
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_week=as.yearqtr(data_trimmed$Date, "%Y-%m-%d") + as.integer(format(data_trimmed$Date, "%W"))/100), mean)
    agg_data$Date <- as.Date(paste0(substr(as.character(agg_data$group_week),1,7), "-01"))
    agg_data$group_week <- NULL
  } else if (span_in_minutes <= 525600) {
    # aggregate data every month
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_month=format(data_trimmed$Date, "%Y-%m")), mean)
    agg_data$Date <- as.POSIXct(paste0(agg_data$group_month, "-01"), format="%Y-%m-%d")
    agg_data$group_month <- NULL
  } else {
    # aggregate data every year
    agg_data <- aggregate(data_trimmed[,1:4], by=list(group_year=format(data_trimmed$Date, "%Y")), mean)
    agg_data$Date <- as.POSIXct(paste0(agg_data$group_year, "-01-01"), format="%Y-%m-%d")
    agg_data$group_year <- NULL
  }

  # return the aggregated data
  return(agg_data)
}
