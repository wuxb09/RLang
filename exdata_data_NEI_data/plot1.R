NEI <- readRDS("summarySCC_PM25.rds")
p1 <- with(NEI, tapply(Emissions, year, sum))
plot(names(p1), p1, type='l', xlab='year', ylab='total emmissions')
