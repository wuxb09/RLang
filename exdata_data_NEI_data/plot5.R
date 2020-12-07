NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
motorLogic <- grepl("Motorcycles|Motor Vehicles", SCC$Short.Name)
motorScc <- SCC[motorLogic, ]$SCC
motorRel <- NEI[NEI$SCC %in% motorScc, ]
motorRelBaltimore <- subset(motorRel, motorRel$fips=="24510")
p1 <- with(motorRelBaltimore, tapply(Emissions, year, sum))
plot(names(p1), p1, type='l', xlab='year', ylab='total emmissions')