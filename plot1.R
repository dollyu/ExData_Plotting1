library("data.table")

setwd("/home/dugi/coursera/Course4_week1")

#Read in data
powerData <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Fixing numeric data because it is stored in scientific notation
powerData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making date to date type
powerData[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# keep date range --> 2007-02-01 and 2007-02-02
powerData <- powerData[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(powerData[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()