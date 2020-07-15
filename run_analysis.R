#"Getting and cleaning data - Final Project"
# Simon Ramirez

#libraries
rm(list = ls())
library(data.table)
library(tidyverse)

#Download data,  unzip file and create data.tables
file <- "Coursera_DS3_Final.zip"
if (!file.exists(file)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, file, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
      unzip(file) 
}

#create data.tables
activities <- fread("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <- fread("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
subject_test <- fread("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- fread("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- fread("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- fread("UCI HAR Dataset/train/y_train.txt", col.names = "code")
x_test <- fread("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- fread("UCI HAR Dataset/test/y_test.txt", col.names = "code")


#Following the five steps:
#1: Merges the training and the test sets to create one data set.
x_total <- rbind(x_train, x_test)
y_total <- rbind(y_train, y_test)
subject_total <- rbind(subject_train, subject_test)
df <- cbind(subject_total, y_total, x_total)

#2: Extracts only the measurements on the mean and standard deviation for each measurement.
tidy_df <- df %>% select(subject, code, contains("mean"), contains("std"))

#3: Uses descriptive activity names to name the activities in the data set.
tidy_df$code <- activities[tidy_df$code, 2]

#4: Appropriately labels the data set with descriptive variable names.

names(tidy_df)[2] = "activity"
names(tidy_df)<-gsub("Acc", "Accelerometer", names(tidy_df))
names(tidy_df)<-gsub("Gyro", "Gyroscope", names(tidy_df))
names(tidy_df)<-gsub("BodyBody", "Body", names(tidy_df))
names(tidy_df)<-gsub("Mag", "Magnitude", names(tidy_df))
names(tidy_df)<-gsub("^t", "Time", names(tidy_df))
names(tidy_df)<-gsub("^f", "Frequency", names(tidy_df))
names(tidy_df)<-gsub("tBody", "TimeBody", names(tidy_df))
names(tidy_df)<-gsub("-mean()", "Mean", names(tidy_df), ignore.case = TRUE)
names(tidy_df)<-gsub("-std()", "STD", names(tidy_df), ignore.case = TRUE)
names(tidy_df)<-gsub("-freq()", "Frequency", names(tidy_df), ignore.case = TRUE)
names(tidy_df)<-gsub("angle", "Angle", names(tidy_df))
names(tidy_df)<-gsub("gravity", "Gravity", names(tidy_df))


#5: From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.

grouped_tidy_df <- tidy_df %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(grouped_tidy_df, "grouped_tidy_df.csv", row.name=FALSE)
