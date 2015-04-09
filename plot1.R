print("reading data...")
household_consumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

household_consumption_subset <- household_consumption[household_consumption$Date == "1/2/2007" | household_consumption$Date == "2/2/2007", ]
hist(household_consumption_subset2$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, file="plot1.png")
dev.off()
print("created plot1.png in local directory")