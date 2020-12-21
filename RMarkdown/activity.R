#1
da <- read.csv('activity.csv')
da$date <- as.Date(da$date, "%Y-%m-%d")

#1, Calculate the total number of steps taken per day
ra <- group_by(da, date)
ta <- summarise(ra, total=sum(steps))

#2,  histogram of the total number of steps taken each day
hist(ta$total, xlab="Total steps per day")



#3, mean and median of the total number of steps taken per day
print(summary(ta$total))


#4, time series plot of the 5-minute interval (x-axis) and 
#the average number of steps taken, averaged across all days (y-axis)
plot(ta$date, ta$total/12/24, type='l')

#5, Which 5-minute interval, on average across all the days in the dataset, 
#contains the maximum number of steps?
ta$date[which.max(ta$total)]

#6, Calculate and report the total number of missing values in the dataset
sum(is.na(ra$steps))

#7.Devise a strategy for filling in all of the missing values in the dataset
# Create a new dataset that is equal to the original dataset 
#but with the missing data filled in.
pa <- ra
pa$steps[is.na(pa$steps)] <- 0

#8, histogram of the total number of steps taken each day
# mean and median of the total number of steps taken per day
pa <- group_by(pa, date)
qa <- summarise(pa, total=sum(steps))
hist(qa$total, xlab="Total steps per day")
print(summary(qa$total))

#9, Create a new factor variable in the dataset with 
#two levels – “weekday” and “weekend” indicating whether a given date 
#is a weekday or weekend day
qa$day <- factor(weekdays(qa$date) == "Saturday" | 
                   weekdays(qa$date) == "Sunday", 
                 levels=c(FALSE, TRUE), labels=c("weekday", "weekend"))

#10,
par(mfrow=c(2,1))
s1 <- subset(qa, as.integer(qa$day) == 1)
s2 <- subset(qa, as.integer(qa$day) == 2)

plot(s1$date, s1$total/12/24, type='l', xlab="Weekday", ylab="Averaged steps")
plot(s2$date, s2$total/12/24, type='l', xlab="Weekend", ylab="Averaged steps")

