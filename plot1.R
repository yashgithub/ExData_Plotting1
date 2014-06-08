# Before running this script, move household_power_consumption.txt file in R working directory

# Load household power consumption data in R
EPC = read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Filter data for dates 01/02/2007 and 02/02/2007
EPC2Days = EPC[as.Date(EPC$Date, "%d/%m/%Y") == as.Date("2007-02-01", "%Y-%m-%d") | as.Date(EPC$Date, "%d/%m/%Y") == as.Date("2007-02-02", "%Y-%m-%d"),]

# Ser graphics device to PNG
png("plot1.png", width = 480, height = 480)

# construct the plot
with(EPC2Days, hist(Global_active_power, main = "Global Active Power", col = c("red"), xlab = "Global Active Power (kilowatts)"))
dev.off()