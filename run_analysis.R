# Download data set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Load the plyr package
library(plyr)

# 1. Merge the training and test sets to create one data set
###############################################################################
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

# merge 'x' training and testing data set
x_mergedata <- rbind(x_train, x_test)

# merge 'y' training and testing data set
y_mergedata <- rbind(y_train, y_test)

# merge 'subject' training and testing data set
subject_mergedata <- rbind(subject_train, subject_test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################
features <- read.table("features.txt")

# extract only measurements on the mean and standard deviation
mean_and_std_measurement <- grep("-(mean|std)\\(\\)", features[, 2])

# get the subset from x_data and write back
x_mergedata <- x_mergedata[, mean_and_std_measurement]

# change column names 
names(x_mergedata) <- features[mean_and_std_measurement, 2]

# 3. Use descriptive activity names to name the activities in the data set
###############################################################################
activity <- read.table("activity_labels.txt")

# get the subset from y_data and write back
y_mergedata[, 1] <- activity[y_mergedata[, 1], 2]

# add column name
names(y_mergedata) <- "activity"

# 4. Appropriately label the data set with descriptive variable names
###############################################################################

# add column name
names(subject_mergedata) <- "subject"

# combine all the data in a single data set
complete_data <- cbind(x_mergedata, y_mergedata, subject_mergedata)

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
###############################################################################
tidy_average_data <- ddply(complete_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(tidy_average_data, "tidy_average_data.txt", row.name=FALSE)
