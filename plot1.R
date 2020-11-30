da <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                 colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

t <- subset(da, Date == "1/2/2007" | Date == "2/2/2007")
t$DT <- strptime(paste(t$Date, t$Time), "%d/%m/%Y %H:%M:%S")

png(file="plot1.png", width=480, height=480)
hist(t$Global_active_power,main="Global Active Power", xlab="Global Active Power(kilowatts)",col="red")
dev.off()
