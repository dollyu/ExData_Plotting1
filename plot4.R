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

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# plot 1 (upper left)
plot(powerData[, dateTime], powerData[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# plot 2 (upper right)
plot(powerData[, dateTime],powerData[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# plot 3 (lower left)
plot(powerData[, dateTime], powerData[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerData[, dateTime], powerData[, Sub_metering_2], col="red")
lines(powerData[, dateTime], powerData[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# plot 4 (lower right)
plot(powerData[, dateTime], powerData[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()