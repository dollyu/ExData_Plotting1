library("data.table")

setwd("/home/dugi/coursera/Course4_week1")

#Read in data
powerData <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Fixing numeric data because it is stored in scientific notation
powerData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date so can filter & graph by time of day
powerData[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# keep date range --> 2007-02-01 and 2007-02-02
powerData <- powerData[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = powerData[, dateTime]
     , y = powerData[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()