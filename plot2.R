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
plot(Feb$DateTime, Feb$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab="")

dev.copy(png, "plot2.png")
dev.off()
