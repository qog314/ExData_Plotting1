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
par(mar = c(3, 4, 2, 0.5), oma = c(2, 2, 0, 0))

plot(Feb$DateTime, Feb$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab= "")
points(Feb$DateTime, Feb$Sub_metering_2, type = "l", col = "red")
points(Feb$DateTime, Feb$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1, 1, 1), xjust = 1, yjust = 1, y.intersp = 1, inset = 0, 
       bty = "n", cex = 0.75)

dev.copy(png, "plot3.png")
dev.off()
