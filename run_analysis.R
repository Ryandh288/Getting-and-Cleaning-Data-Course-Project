##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Ryan Honomichl
## 7/2016

#  run_analysis.R File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################


## Clean up workspace and load relevant packages

rm(list=ls())

library(utils)

library(data.table)

library(reshape2)


## Download data and unzip files.Set Working directory

setwd("C:/Users/Ryan Honomichl/Dropbox/Coursera/Getting and Cleaning Data/project")

if(!file.exists("./project")) dir.create("./project")

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileUrl,destfile="./project/Dataset.zip")

unzip(zipfile="./project/Dataset.zip",exdir="./project")


## Input feature names and activity labels and convert to character class

a.labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

a.labels[,2] <- as.character(a.labels[,2])

f.names <- read.table("UCI HAR Dataset/features.txt", header = FALSE)

f.names[,2] <- as.character(f.names[,2])


## Extract only the measurements on the mean and standard deviation for each measurement. 

f.mean.std <- grep(".*mean.*|.*std.*", f.names[,2])

f.mean.std.labels <- f.names[f.mean.std,2]


## Merge the training and the test sets to create one data set.

###Training data

training.set <- read.table("UCI HAR Dataset/train/X_train.txt")[f.mean.std]

training.act <- read.table("UCI HAR Dataset/train/Y_train.txt")

training.sub <- read.table("UCI HAR Dataset/train/subject_train.txt")

final.train <- cbind(training.sub, training.act, training.set)


###Test data

test.set <- read.table("UCI HAR Dataset/test/X_test.txt")[f.mean.std]

test.act <- read.table("UCI HAR Dataset/test/Y_test.txt")

test.sub <- read.table("UCI HAR Dataset/test/subject_test.txt")

final.test <- cbind(test.sub, test.act, test.set)

merged.data <- rbind(final.train, final.test)

colnames(merged.data) <- c("subject", "activity", f.mean.std.labels)


## Appropriately label the data set with descriptive activity names. 

names(merged.data)<-gsub("Acc", "Accelerometer", names(merged.data))

names(merged.data)<-gsub("Gyro", "Gyroscope", names(merged.data))

names(merged.data)<-gsub("BodyBody", "Body", names(merged.data))

names(merged.data)<-gsub("Mag", "Magnitude", names(merged.data))

names(merged.data)<-gsub("^t", "Time", names(merged.data))

names(merged.data)<-gsub("^f", "Frequency", names(merged.data))

names(merged.data)<-gsub("tBody", "TimeBody", names(merged.data))

names(merged.data)<-gsub("-mean()", "Mean", names(merged.data), ignore.case = TRUE)

names(merged.data)<-gsub("-std()", "STD", names(merged.data), ignore.case = TRUE)

names(merged.data)<-gsub("-freq()", "Frequency", names(merged.data), ignore.case = TRUE)

names(merged.data)<-gsub("angle", "Angle", names(merged.data))

names(merged.data)<-gsub("gravity", "Gravity", names(merged.data))


## turn activities & subjects into factors

merged.data$activity <- factor(merged.data$activity, 
                                levels = a.labels[,1], 
                                labels = a.labels[,2])

merged.data$subject <- as.factor(merged.data$subject)


## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

melted.data <- melt(merged.data, id = c("subject", "activity"))

finaldata.mean <- dcast(melted.data, subject + activity ~ variable, mean)

write.table(finaldata.mean, "GACDtidy.txt", row.names = FALSE, quote = FALSE)
