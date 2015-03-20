# CodeBook for course project "Getting and Cleaning Data"

## Explanation
The original data were collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the original data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Features in the tidy.txt data set
*	subject: subject id
*	activity: activity
*	part: tBodyAcc, tGravityAcc, fBodyAccJerk etc
*   method: mean or std
*	axis: x, y, z
*   value: mean of each variable for each activity and each subject

Steps followed to derive tidy.txt
-----------------------------------

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates an independent tidy data set with the average of each variable for each activity and each subject.
The dimension of the final tidy data set is 11880 * 6. 
11,880 observations = 30 subjects x 6 activities X 66 measurements

This dataset satisfy the criteria for tidy data set
* Each variable forms a column
* Each observation forms a row
* Each table/file stores data about one kind of observation



