if (!file.exists("POWER.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "POWER.zip")
    unzip("POWER.zip")
    file.remove("POWER.zip")
}
consumption <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE)
consumption$Date <- as.Date(consumption$Date, format = "%d/%m/%Y")
Feb <- subset(consumption, (Date == "2007-02-01" | Date == "2007-02-02"))
Feb$DateTime <- as.POSIXct(paste(Feb$Date, Feb$Time), 
                           format = "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2, 2), mar = c(4, 4, 3, 0.5))

plot(Feb$DateTime, Feb$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab="")

plot(Feb$DateTime, Feb$Voltage, type = "l", ylab = "Voltage", 
     xlab = "datetime")

plot(Feb$DateTime, Feb$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab= "")
points(Feb$DateTime, Feb$Sub_metering_2, type = "l", col = "red")
points(Feb$DateTime, Feb$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1, 1, 1), xjust = 1, cex = 0.75, y.intersp = 0.5, yjust = 0, inset = 0,
       bty = "n")

plot(Feb$DateTime, Feb$Global_reactive_power, type = "l", xlab = "datetime",
     ylab="gloval_reactive_power")
axis(2, c(0.1, 0.2, 0.3, 0.4, 0.5))

dev.copy(png, "plot4.png")
dev.off()
