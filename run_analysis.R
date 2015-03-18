library(sqldf)
library(dplyr)

featuresfile <- './UCI HAR Dataset/features.txt'
actlabelfile <- './UCI HAR Dataset/activity_labels.txt'

xtrainfile<- './UCI HAR Dataset/train/X_train.txt'
ytrainfile <- './UCI HAR Dataset/train/y_train.txt'
subjecttrainfile <- './UCI HAR Dataset/train/subject_train.txt'

xtestfile <- './UCI HAR Dataset/test/X_test.txt'
ytestfile <- './UCI HAR Dataset/test/y_test.txt'
subjecttestfile <- './UCI HAR Dataset/test/subject_test.txt'

tidyfile <-'./tidy.txt'

#Read features to get colnames
d <- read.table(file=featuresfile)
colnames<- d[, 2]

#read activities and labels
actlabel<-read.table(file=actlabelfile)

#Read train data with feature names as colnames
xtrain<- read.table(file= xtrainfile, strip.white=T, col.names=colnames)

#read subject train
subjectstrain <- read.table(file=subjecttrainfile, col.names='subject')

#Read ytrain data
ytrain<-read.table(file=ytrainfile)

# Interpret activity code with textual descriptions
ytraindes <- sqldf("select * from ytrain, actlabel where ytrain.V1 = actlabel.V1")
activity <- ytraindes[, 3]

#combine them columnwisely
trainsubactivity <- cbind(xtrain, subjectstrain, activity)

#Read test data with feature names as colnames
xtest<- read.table(file=xtestfile, strip.white=T, col.names=colnames)

# Read subject test
subjectstest <- read.table(file=subjecttestfile, col.names='subject')

#Read ytest data
ytest<-read.table(file=ytestfile)

# Interpret activity code with textual descriptions
ytestdes <- sqldf("select * from ytest, actlabel where ytest.V1 = actlabel.V1")
activity <- ytestdes[, 3]

#combine them columnwisely
testsubactivity <- cbind(xtest, subjectstest, activity)

#combine train and test into one data set
wholedata <- rbind(trainsubactivity, testsubactivity)

# Extract only measurements on the mean and std
b <- grepl("mean|std", colnames)
extract <- wholedata[, b]

# Step 5:  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- aggregate(. ~ activity + subject, data = extract, mean)
tidy<- tidy [with(tidy, order(activity)), ]
write.table(tidy, file=tidyfile, row.name=FALSE)
