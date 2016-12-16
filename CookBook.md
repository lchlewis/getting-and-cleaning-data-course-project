# CookBook.md

The R scripts "run_analysis.R" performs the following 5 steps:

**1. Merges the training and the test sets to create one data set** 

Explaination: Use the rbind() function to merge the data sets


x_mergedata <- rbind(x_train, x_test)

y_mergedata <- rbind(y_train, y_test) 

subject_mergedata <- rbind(subject_train, subject_test)


**2. Extracts only the measurements on the mean and standard deviation for each measurement**

Explaination: Use the grep() function to extract mean and standard deviation measurements to mean_and_std_measurement


mean_and_std_measurement <- grep("-(mean|std)\\(\\)", features[, 2])

x_mergedata <- x_mergedata[, mean_and_std_measurement]

names(x_mergedata) <- features[mean_and_std_measurement, 2]


**3. Uses descriptive activity names to name the activities in the data set**

y_mergedata[, 1] <- activity[y_mergedata[, 1], 2]

names(y_mergedata) <- "activity"


**4. Appropriately labels the data set with descriptive variable names**

names(subject_mergedata) <- "subject"


**5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**

Explaination: Use cbind() to combine data frame by column; Use ddply() from the plyr package to manipulate the data frame; Use colMeans() to calculate column means for a data frame; Use write.table() to write the data frame into file 


complete_data <- cbind(x_mergedata, y_mergedata, subject_mergedata)

tidy_average_data <- ddply(complete_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(tidy_average_data, "tidy_average_data.txt", row.name=FALSE)
