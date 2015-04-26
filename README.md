---
title: "README"
author: "Daniel Quan"
date: "Saturday, April 25, 2015"
output: html_document
---
1. First part of script downloads and unzips the required data files using the url given on the course project description.
URL = https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

temp = tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
activity_labels = read.table(unzip(temp, "UCI HAR Dataset/activity_labels.txt"))
features = read.table(unzip(temp, "UCI HAR Dataset/features.txt"))
subject_train = read.table(unzip(temp, "UCI HAR Dataset/train/subject_train.txt"))
x_train = read.table(unzip(temp, "UCI HAR Dataset/train/X_train.txt"))
y_train = read.table(unzip(temp, "UCI HAR Dataset/train/y_train.txt"))
subject_test = read.table(unzip(temp, "UCI HAR Dataset/test/subject_test.txt"))
x_test = read.table(unzip(temp, "UCI HAR Dataset/test/X_test.txt"))
y_test = read.table(unzip(temp, "UCI HAR Dataset/test/y_test.txt"))

2. The datasets are given names, the names for x_test and x_train are taken from the 2nd column of the features dataset, which contains the corresponding feature names

names(x_test) = features[[2]]
names(x_train) = features[[2]]
names(y_test) = "Activity"
names(y_train) = "Activity"
names(subject_test) = "Subject"
names(subject_train) = "Subject"

3. A function is created and applied to the y(Activity) datasets to replace the number n with the nth element of the 2nd column of activity_labels (corresponding to one of six possible activities)

replace_fun = function(x) { return (as.character(activity_labels[[2]][x]))} #replace a number n with nth element of activity_labels column 
y_test = data.frame(sapply(y_test, replace_fun)) 
y_train = data.frame(sapply(y_train, replace_fun))

4. The merged test set is created by the column binding (Subject, Activity, test). The same binding order is used for the train set. Then two merged datasets are then merged by row binding the merged test set to the merged train set. Columns with duplicate names are removed because this causes trouble for dplyr select.

merge_test = cbind(subject_test, y_test, x_test)
merge_train = cbind(subject_train, y_train, x_train)
total = rbind(merge_train, merge_test)
total_unique = total[!duplicated(names(total))] #remove columns with duplicate names

5. A new dataframe is created with consists of the Subject, Activity, and all columns with names containing either "mean()" or "std()". I did not include measurements using the means, only the final mean measurements themselves. From the new dataframe, a new dataframe is created by aggregating the variables (excluding Subject and Activity) by Subject + Activity and obtaining the mean of the aggregate for each variable. The Subject and Activity columns are renamed approriately. The dataframe is arranged by Subject and written into a txt file.  

library(dplyr)
measurements = select(total_unique, Subject, Activity, contains("mean()"), contains ("std()"))
result = aggregate(measurements[, 3:dim(measurements)[2]], by = list(measurements$Subject, measurements$Activity), FUN = mean)
names(result)[1:2] = c("Subject", "Activity")
result = arrange(result, Subject)
write.table(result, "tidy_dataset.txt", row.name=FALSE)
