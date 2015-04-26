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

names(x_test) = features[[2]]
names(x_train) = features[[2]]
names(y_test) = "Activity"
names(y_train) = "Activity"
names(subject_test) = "Subject"
names(subject_train) = "Subject"

replace_fun = function(x) { return (as.character(activity_labels[[2]][x]))} #replace a number n with nth element of activity_labels column 
y_test = data.frame(sapply(y_test, replace_fun)) 
y_train = data.frame(sapply(y_train, replace_fun))

merge_test = cbind(subject_test, y_test, x_test)
merge_train = cbind(subject_train, y_train, x_train)
total = rbind(merge_train, merge_test)
total_unique = total[!duplicated(names(total))] #remove columns with duplicate names

library(dplyr)
measurements = select(total_unique, Subject, Activity, contains("mean()"), contains ("std()"))
result = aggregate(measurements[, 3:dim(measurements)[2]], by = list(measurements$Subject, measurements$Activity), FUN = mean)
names(result)[1:2] = c("Subject", "Activity")
result = arrange(result, Subject)
write.table(result, "tidy_dataset.txt", row.name=FALSE)
