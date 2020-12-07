da <- read.csv('activity.csv')
da$date <- as.Date(da$date, "%Y-%m-%d")
ra <- group_by(da, date)
ta <- summarise(ra, total=sum(steps))
hist(ta$total, xlab="Total steps per day")
print(summary(ta$total))

