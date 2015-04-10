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

## create the actual plot
plot(household_table$Date_Time, household_table$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.copy(png, file="plot2.png")
dev.off()
print("created plot2.png in working directory")