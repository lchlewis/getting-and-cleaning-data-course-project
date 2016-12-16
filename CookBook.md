# Introduction

The R scripts "run_analysis.R" performs the following 5 steps:

**Merges the training and the test sets to create one data set** 
> x_data <- rbind(x_train, x_test)
> y_data <- rbind(y_train, y_test)
> subject_data <- rbind(subject_train, subject_test)

**Extracts only the measurements on the mean and standard deviation for each measurement**
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std_features]
names(x_data) <- features[mean_and_std_features, 2]

**Uses descriptive activity names to name the activities in the data set**
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"

**Appropriately labels the data set with descriptive variable names**
names(subject_data) <- "subject"

**From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
all_data <- cbind(x_data, y_data, subject_data)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "tidy_average_data.txt", row.name=FALSE)
