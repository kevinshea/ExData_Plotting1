## script to create line graph of 
## Global Active Power over time (date + time of day)
library(data.table)
library(lubridate)

print("reading data...")
household_consumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
household_consumption_subset <- household_consumption[household_consumption$Date == "1/2/2007" | household_consumption$Date == "2/2/2007", ]

print("preparing plot...")
## probably easier way to create this new column with fewer lines of code
household_consumption_subset[, 1] <- as.character(household_consumption_subset[, 1])
household_consumption_subset[, 2] <- as.character(household_consumption_subset[, 2])
household_table <- data.table(household_consumption_subset)
household_table[, Date_Time:=dmy_hms(paste(Date, Time))]

# set up columns, margins, and font size
par(mfrow = c(2,2))
par(mar = c(4, 4, 3, 2))
par(cex = .70)

# 1. plot top left chart - Global Active Power by day/time
plot(household_table$Date_Time, household_table$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# 2. plot top right chart - Voltage by day/time
plot(household_table$Date_Time, household_table$Voltage, type="l", xlab="datetime", ylab="Voltage")

# 3. plot bottom left chart - Sub_metering by day/time
plot(household_table$Date_Time, household_table$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(household_table$Date_Time, household_table$Sub_metering_2, type="l", col="red")
points(household_table$Date_Time, household_table$Sub_metering_3, type="l", col="blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, cex=0.75, bty="n")

# 4. plot bottom right chart - Global reactive power by day/time
plot(household_table$Date_Time, household_table$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# save file
dev.copy(png, file="plot4.png")
dev.off()
print("created plot4.png in working directory")

