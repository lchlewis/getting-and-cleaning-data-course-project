<body>
<p># CookBook.md</p>
<p>The R scripts &quot;run_analysis.R&quot; performs the following 5 steps:</p>
<p>&nbsp;</p>
<p><strong>**1. Merges the training and the test sets to create one data set** </strong></p>
<p><em>Explaination: Use the rbind() function to merge the data sets by rows</em><br />
</p>
<ul>
  <li>x_mergedata &lt;- rbind(x_train, x_test)</li>
  <li>y_mergedata &lt;- rbind(y_train, y_test) </li>
  <li>subject_mergedata &lt;- rbind(subject_train, subject_test)</li>
</ul>
<p><br />
</p>
<p><strong>**2. Extracts only the measurements on the mean and standard deviation for each measurement**</strong></p>
<p><em>Explaination: Use the grep() function to extract mean and standard deviation measurements to mean_and_std_measurement</em><br />
</p>
<ul>
  <li>mean_and_std_measurement &lt;- grep(&quot;-(mean|std)\\(\\)&quot;, features[, 2])</li>
  <li>x_mergedata &lt;- x_mergedata[, mean_and_std_measurement]</li>
  <li>names(x_mergedata) &lt;- features[mean_and_std_measurement, 2]</li>
</ul>
<p><br />
</p>
<p><strong>**3. Uses descriptive activity names to name the activities in the data set**</strong></p>
<ul>
  <li>y_mergedata[, 1] &lt;- activity[y_mergedata[, 1], 2]</li>
  <li>names(y_mergedata) &lt;- &quot;activity&quot;</li>
</ul>
<p><br />
</p>
<p><strong>**4. Appropriately labels the data set with descriptive variable names**</strong></p>
<ul>
  <li>names(subject_mergedata) &lt;- &quot;subject&quot;</li>
</ul>
<p><br />
</p>
<p><strong>**5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**</strong></p>
<p><em>Explaination: Use cbind() to combine data frame by column; Use ddply() from the plyr package to manipulate the data frame; Use colMeans() to calculate column means for a data frame; Use write.table() to write the data frame into file </em><br />
</p>
<ul>
  <li>complete_data &lt;- cbind(x_mergedata, y_mergedata, subject_mergedata)</li>
  <li>tidy_average_data &lt;- ddply(complete_data, .(subject, activity), function(x) colMeans(x[, 1:66]))</li>
  <li>write.table(tidy_average_data, &quot;tidy_average_data.txt&quot;, row.name=FALSE)<br />
  </li>
</ul>
</body>
