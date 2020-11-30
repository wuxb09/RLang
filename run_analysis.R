library("matrixStats")
library("dplyr")

### Train data
#acc
acc_x_train <- as.matrix(read.table("UCI\ HAR\ Dataset/train/Inertial\ Signals/body_acc_x_train.txt", colClasses="numeric"))
acc_x_train_mean = rowMeans(acc_x_train)
acc_x_train_sd = rowSds(acc_x_train)

acc_y_train <- as.matrix(read.table("UCI\ HAR\ Dataset/train/Inertial\ Signals/body_acc_y_train.txt", colClasses="numeric"))
acc_y_train_mean = rowMeans(acc_y_train)
acc_y_train_sd = rowSds(acc_y_train)

acc_z_train <- as.matrix(read.table("UCI\ HAR\ Dataset/train/Inertial\ Signals/body_acc_z_train.txt", colClasses="numeric"))
acc_z_train_mean = rowMeans(acc_z_train)
acc_z_train_sd = rowSds(acc_z_train)
#gyro
gyro_x_train <- as.matrix(read.table("UCI\ HAR\ Dataset/train/Inertial\ Signals/body_gyro_x_train.txt", colClasses="numeric"))
gyro_x_train_mean = rowMeans(gyro_x_train)
gyro_x_train_sd = rowSds(gyro_x_train)

gyro_y_train <- as.matrix(read.table("UCI\ HAR\ Dataset/train/Inertial\ Signals/body_gyro_y_train.txt", colClasses="numeric"))
gyro_y_train_mean = rowMeans(gyro_y_train)
gyro_y_train_sd = rowSds(gyro_y_train)

gyro_z_train <- as.matrix(read.table("UCI\ HAR\ Dataset/train/Inertial\ Signals/body_gyro_z_train.txt", colClasses="numeric"))
gyro_z_train_mean = rowMeans(gyro_z_train)
gyro_z_train_sd = rowSds(gyro_z_train)
#subject
sub_train = as.matrix(read.table("UCI_HAR_Dataset/train/subject_train.txt", colClasses="numeric"))
#y
y_train = as.matrix(read.table("UCI_HAR_Dataset/train/y_train.txt", colClasses="numeric"))

### Test data
#acc
acc_x_test <- as.matrix(read.table("UCI\ HAR\ Dataset/test/Inertial\ Signals/body_acc_x_test.txt", colClasses="numeric"))
acc_x_test_mean = rowMeans(acc_x_test)
acc_x_test_sd = rowSds(acc_x_test)

acc_y_test <- as.matrix(read.table("UCI\ HAR\ Dataset/test/Inertial\ Signals/body_acc_y_test.txt", colClasses="numeric"))
acc_y_test_mean = rowMeans(acc_y_test)
acc_y_test_sd = rowSds(acc_y_test)

acc_z_test <- as.matrix(read.table("UCI\ HAR\ Dataset/test/Inertial\ Signals/body_acc_z_test.txt", colClasses="numeric"))
acc_z_test_mean = rowMeans(acc_z_test)
acc_z_test_sd = rowSds(acc_z_test)

#gyro
gyro_x_test <- as.matrix(read.table("UCI\ HAR\ Dataset/test/Inertial\ Signals/body_gyro_x_test.txt", colClasses="numeric"))
gyro_x_test_mean = rowMeans(gyro_x_test)
gyro_x_test_sd = rowSds(gyro_x_test)


gyro_y_test <- as.matrix(read.table("UCI\ HAR\ Dataset/test/Inertial\ Signals/body_gyro_y_test.txt", colClasses="numeric"))
gyro_y_test_mean = rowMeans(gyro_y_test)
gyro_y_test_sd = rowSds(gyro_y_test)

gyro_z_test <- as.matrix(read.table("UCI\ HAR\ Dataset/test/Inertial\ Signals/body_gyro_z_test.txt", colClasses="numeric"))
gyro_z_test_mean = rowMeans(gyro_z_test)
gyro_z_test_sd = rowSds(gyro_z_test)
#subject
sub_test = as.matrix(read.table("UCI_HAR_Dataset/test/subject_test.txt", colClasses="numeric"))
#y
y_test = as.matrix(read.table("UCI_HAR_Dataset/test/y_test.txt", colClasses="numeric"))


###merge train with test
#acc
acc_x_mean <- c(c(acc_x_train_mean), c(acc_x_test_mean))
acc_x_sd <- c(c(acc_x_train_sd), c(acc_x_test_sd))
acc_y_mean <- c(c(acc_y_train_mean), c(acc_y_test_mean))
acc_y_sd <- c(c(acc_y_train_sd), c(acc_y_test_sd))
acc_z_mean <- c(c(acc_z_train_mean), c(acc_z_test_mean))
acc_z_sd <- c(c(acc_z_train_sd), c(acc_z_test_sd))
#gyro
gyro_x_mean <- c(c(gyro_x_train_mean), c(gyro_x_test_mean))
gyro_x_sd <- c(c(gyro_x_train_sd), c(gyro_x_test_sd))
gyro_y_mean <- c(c(gyro_y_train_mean), c(gyro_y_test_mean))
gyro_y_sd <- c(c(gyro_y_train_sd), c(gyro_y_test_sd))
gyro_z_mean <- c(c(gyro_z_train_mean), c(gyro_z_test_mean))
gyro_z_sd <- c(c(gyro_z_train_sd), c(gyro_z_test_sd))
#subject
subject <- c(c(sub_train),c(sub_test))
#y
activity <- c(c(y_train),c(y_test))

###create data frame
dataset1 <- data.frame("acc_x_mean"=acc_x_mean, "acc_x_sd"=acc_x_sd, "acc_y_mean"=acc_y_mean, "acc_y_sd"=acc_y_sd,
                       "acc_z_mean"=acc_z_mean, "acc_z_sd"=acc_z_sd, "gyro_x_mean"=gyro_x_mean, "gyro_x_sd"=gyro_x_sd, 
                       "gyro_y_mean"=gyro_y_mean, "gyro_y_sd"=gyro_y_sd, "gyro_z_mean"=gyro_z_mean, "gyro_z_sd"=gyro_z_sd,
                       "subject"=subject, "activity"=activity)

###group the dataset1 by subject and activity
tmp <- group_by(dataset1, subject, activity)
dataset2 <- summarise(tmp, 
                      mean_acc_x_mean=mean(acc_x_mean), mean_acc_x_sd=mean(acc_x_sd), 
                      mean_acc_y_mean=mean(acc_y_mean), mean_acc_y_sd=mean(acc_y_sd),
                      mean_acc_z_mean=mean(acc_z_mean), mean_acc_z_sd=mean(acc_z_sd), 
                      mean_gyro_x_mean=mean(gyro_x_mean), mean_gyro_x_sd=mean(gyro_x_sd), 
                      mean_gyro_y_mean=mean(gyro_y_mean), mean_gyroc_y_sd=mean(gyro_y_sd),
                      mean_gyro_z_mean=mean(gyro_z_mean), mean_gyro_z_sd=mean(gyro_z_sd))


###change the activity to descriptive names
dataset2$activity <- as.character(dataset2$activity)
dataset2$activity <- sub("1", "WALKING", dataset2$activity)
dataset2$activity <- sub("2", "WALKING_UPSTAIRS", dataset2$activity)
dataset2$activity <- sub("3", "WALKING_DOWNSTAIRS", dataset2$activity)
dataset2$activity <- sub("4", "SITTING", dataset2$activity)
dataset2$activity <- sub("5", "STANDING", dataset2$activity)
dataset2$activity <- sub("6", "LAYING", dataset2$activity)


###Save dataset2 into file
write.table(dataset2, "samsung.txt", row.name=FALSE)