NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
coalLogic <- grepl("Comb.*Coal", SCC$Short.Name)
coalScc <- SCC[coalLogic, ]$SCC
combCoal <- NEI[NEI$SCC %in% coalScc, ]
p1 <- with(combCoal, tapply(Emissions, year, sum))
plot(names(p1), p1, type='l', xlab='year', ylab='total emmissions')