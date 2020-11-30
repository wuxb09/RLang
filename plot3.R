da <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                 colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

t <- subset(da, Date == "1/2/2007" | Date == "2/2/2007")
t$DT <- strptime(paste(t$Date, t$Time), "%d/%m/%Y %H:%M:%S")

png(file="plot3.png", width=480, height=480)
plot(t$DT, t$Sub_metering_1, type = "n", xlab= "", ylab="Energy Sub Metering")
points(t$DT, t$Sub_metering_1, type = "l")
points(t$DT, t$Sub_metering_2, type = "l", col="red")
points(t$DT, t$Sub_metering_3, type = "l", col="blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()