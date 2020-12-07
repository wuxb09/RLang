NEI <- readRDS("summarySCC_PM25.rds")
NEI_baltimore <- group_by(NEI_baltimore, type, year)
NEI_baltimore_tot <- summarise(NEI_baltimore, total=sum(Emissions))
print(ggplot(NEI_baltimore_tot, aes(year,total, colour=type))+geom_point()+facet_grid(type ~ .))
