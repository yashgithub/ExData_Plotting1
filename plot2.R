# Before running this script, move household_power_consumption.txt file in R working directory

# Load package stringr
library(stringr)

# Load household power consumption data in R
EPC = read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Filter data for dates 01/02/2007 and 02/02/2007
EPC2Days = EPC[as.Date(EPC$Date, "%d/%m/%Y") == as.Date("2007-02-01", "%Y-%m-%d") | as.Date(EPC$Date, "%d/%m/%Y") == as.Date("2007-02-02", "%Y-%m-%d"),]

#Transform Time from text format to POSIXlt
EPCTR = transform(EPC2Days, Time = strptime(str_c(EPC2Days$Date, EPC2Days$Time, sep = " "), "%d/%m/%Y %H:%M:%S")) 

# Ser graphics device to PNG
png("plot2.png", width = 480, height = 480)

# construct the plot
with (EPCTR, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "datetime"))

dev.off()