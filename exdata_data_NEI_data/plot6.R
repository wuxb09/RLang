NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
motorLogic <- grepl("Motorcycles|Motor Vehicles", SCC$Short.Name)
motorScc <- SCC[motorLogic, ]$SCC
motorRel <- NEI[NEI$SCC %in% motorScc, ]
motorRel <- subset(motorRel, motorRel$fips=="24510" | motorRel$fips=="06037")
motorRel <- group_by(motorRel, fips, year)
motorRel <- summarise(motorRel, total=sum(Emissions))
rng = range(motorRel$total)
print(ggplot(motorRel, aes(year,total, colour=fips))+geom_point()+ylim(rng[1], rng[2])+facet_grid(fips ~ .))
