# Before running this script, move household_power_consumption.txt file in R working directory

# Load package stringr
library(stringr)

# Load house hold power consumption data in R
EPC = read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Filter data for dates 01/02/2007 and 02/02/2007
EPC2Days = EPC[as.Date(EPC$Date, "%d/%m/%Y") == as.Date("2007-02-01", "%Y-%m-%d") | as.Date(EPC$Date, "%d/%m/%Y") == as.Date("2007-02-02", "%Y-%m-%d"),]

#Transform Time from text format to POSIXlt
EPCTR = transform(EPC2Days, Time = strptime(str_c(EPC2Days$Date, EPC2Days$Time, sep = " "), "%d/%m/%Y %H:%M:%S")) 

#Extract each Sub metering data in different data frames. 
#Add new column to identify sub meter. 
#Rename column names to have uniform column names across data frames.

Sub_metering_1 = EPCTR[, c("Time","Sub_metering_1")]
Sub_metering_1$SubMeterNo = rep(1, nrow(Sub_metering_1))
names(Sub_metering_1) = c("Time", "Value", "SubMeterNo")

Sub_metering_2 = EPCTR[, c("Time","Sub_metering_2")]
Sub_metering_2$SubMeterNo = rep(2, nrow(Sub_metering_2))
names(Sub_metering_2) = c("Time", "Value", "SubMeterNo")

Sub_metering_3 = EPCTR[, c("Time","Sub_metering_3")]
Sub_metering_3$SubMeterNo = rep(3, nrow(Sub_metering_3))
names(Sub_metering_3) = c("Time", "Value", "SubMeterNo")

# Row bind data for all sub meters
SubMeterReadings = rbind(Sub_metering_1,Sub_metering_2,Sub_metering_3)

# Ser graphics device to PNG
png("plot4.png", width = 480, height = 480)

par(mfrow =c (2,2))

# construct the plots
with(EPCTR, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "datetime"))

with(EPCTR, plot(Time, Voltage, type = "l", xlab = "datetime"))

with (SubMeterReadings, plot(Time, Value, type = "n", ylab = "Energy sub metering", xlab = "datetime"))
with(subset(SubMeterReadings, SubMeterNo == 1), points(Time, Value, col = "black", type = "l"))
with(subset(SubMeterReadings, SubMeterNo == 2), points(Time, Value, col = "red", type = "l"))
with(subset(SubMeterReadings, SubMeterNo == 3), points(Time, Value, col = "blue", type = "l"))
legend("topright", pch = "_", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(EPCTR, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()