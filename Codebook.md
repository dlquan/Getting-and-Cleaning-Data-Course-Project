---
title: "Codebook"
author: "Daniel Quan"
date: "Saturday, April 25, 2015"
output: html_document
---

The following data files were downloaded and read into a data frame
a. activity_labels 
b. features 
c. subject_train 
d. x_train 
e. y_train 
f. subject_test 
g. x_test 
h. y_test

Names were assign to the data frames. The names for x_test and x_train were obtained from the 2nd column of the features data frame, which contains the feature names. The name "Activity" was assigned to the y_test and y_train data frames, and the name "Subject" was assigned to subject_test and subject_train.  

I wrote a function replace_fun to return the nth element of the 2nd column of the activity_labels data frame (the six activity names) given a number n. Then I used sapply to apply this function to every element of y_test and y_train to convert the numbers in the data frames into the corresponding activity. 

I formed the final test and train data frames using cbind in the following order: Subject, Activity, x_train/x_test. Then, I merged the final test and train data frames by rbind to create a totally merged dataframe containing the test and train data, including subject, activity, and all measurements. I removed all columns with duplicate names to allow dplyr to run smoothly. 

I created a new data frame by selecting the Subject and Activity columns, and columns containing "mean()" or "std()". I chose only to select the final mean and standard deviation measurements, and excluded measurements that used a mean or standard deviation as a parameter. I used the aggregate function to group all the measurements (exluding Subject and Activity) by Subject and Activity, and obtained the mean of all the groups into a new data frame. After renaming the Subject and Activity columns, I arranged the data frame by Subject to make data for each subject and activity easier to view. This is the final data frame which is written into file. 

Variables:

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions." - description from given file features_info.txt

Subject - identifies the subject who performed the activity, range of 1-30
Activity - identifies the activity performed, one of six possible activities, obtained from activity_labels

The remaining variables are the mean() and std() of the following variables 17 measurements for a given Subject and Activity. For measurements containing the term "-XYZ", the mean() and std() were obtained once for each of the X, Y, and Z directions. There are 8 XYZ measurements so total number of measurement variables = 8*3 + (17-8) = 33. This means for mean() and std(), there are 66 measurements variables. 

mean(): Mean value
std(): Standard deviation

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

