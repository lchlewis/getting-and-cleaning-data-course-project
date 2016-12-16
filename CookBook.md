<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<p># CookBook.md</p>
<p>The R scripts &quot;run_analysis.R&quot; performs the following 5 steps:</p>
<p>**1. Merges the training and the test sets to create one data set** </p>
<p>Explaination: Use the rbind() function to merge the data sets<br />
</p>
<p>x_mergedata &lt;- rbind(x_train, x_test)</p>
<p>y_mergedata &lt;- rbind(y_train, y_test) </p>
<p>subject_mergedata &lt;- rbind(subject_train, subject_test)</p>
<p><br />
</p>
<p>**2. Extracts only the measurements on the mean and standard deviation for each measurement**</p>
<p>Explaination: Use the grep() function to extract mean and standard deviation measurements to mean_and_std_measurement<br />
</p>
<p>mean_and_std_measurement &lt;- grep(&quot;-(mean|std)\\(\\)&quot;, features[, 2])</p>
<p>x_mergedata &lt;- x_mergedata[, mean_and_std_measurement]</p>
<p>names(x_mergedata) &lt;- features[mean_and_std_measurement, 2]<br />
</p>
<p>**3. Uses descriptive activity names to name the activities in the data set**</p>
<p>y_mergedata[, 1] &lt;- activity[y_mergedata[, 1], 2]</p>
<p>names(y_mergedata) &lt;- &quot;activity&quot;<br />
</p>
<p>**4. Appropriately labels the data set with descriptive variable names**</p>
<p>names(subject_mergedata) &lt;- &quot;subject&quot;<br />
</p>
<p>**5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**</p>
<p>Explaination: Use cbind() to combine data frame by column; Use ddply() from the plyr package to manipulate the data frame; Use colMeans() to calculate column means for a data frame; Use write.table() to write the data frame into file <br />
</p>
<p>complete_data &lt;- cbind(x_mergedata, y_mergedata, subject_mergedata)</p>
<p>tidy_average_data &lt;- ddply(complete_data, .(subject, activity), function(x) colMeans(x[, 1:66]))</p>
<p>write.table(tidy_average_data, &quot;tidy_average_data.txt&quot;, row.name=FALSE)<br />
</p>
</body>
</html>
