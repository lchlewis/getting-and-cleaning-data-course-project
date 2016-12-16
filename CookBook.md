# CookBook.md

The R scripts "run_analysis.R" performs the following 5 steps:

**Merges the training and the test sets to create one data set** 
> x_mergedata <- rbind(x_train, x_test); y_mergedata <- rbind(y_train, y_test); subject_mergedata <- rbind(subject_train, subject_test)

**Extracts only the measurements on the mean and standard deviation for each measurement**
> mean_and_std_measurement <- grep("-(mean|std)\\(\\)", features[, 2]); x_mergedata <- x_mergedata[, mean_and_std_measurement]; names(x_mergedata) <- features[mean_and_std_measurement, 2]

**Uses descriptive activity names to name the activities in the data set**
> y_mergedata[, 1] <- activity[y_mergedata[, 1], 2]; names(y_mergedata) <- "activity"

**Appropriately labels the data set with descriptive variable names**
> names(subject_mergedata) <- "subject"

**From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
> complete_data <- cbind(x_mergedata, y_mergedata, subject_mergedata); tidy_average_data <- ddply(complete_data, .(subject, activity), function(x) colMeans(x[, 1:66])); write.table(tidy_average_data, "tidy_average_data.txt", row.name=FALSE)
