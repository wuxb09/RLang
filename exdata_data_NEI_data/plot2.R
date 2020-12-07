NEI <- readRDS("summarySCC_PM25.rds")
p1 <- with(subset(NEI, NEI$fips=="24510"), tapply(Emissions, year, sum))
plot(names(p1), p1, type='l', xlab='year', ylab='total emmissions of Baltimore City')
