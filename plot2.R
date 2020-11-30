da <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                 colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

t <- subset(da, Date == "1/2/2007" | Date == "2/2/2007")
t$DT <- strptime(paste(t$Date, t$Time), "%d/%m/%Y %H:%M:%S")

png(file="plot2.png", width=480, height=480)
plot(t$DT, t$Global_active_power, type = "l", xlab= "", ylab="Global Active Power(kilowatts)")
dev.off()