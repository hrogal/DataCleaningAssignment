## Set up the working directory and download the zipped file
setwd("~/DataAnalyst/Coursera/projects/DataCleaning/")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              "phone.zip")
unzip("phone.zip")

## Read the data files
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt",col.names = "activity",
                    colClasses = "factor")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt",col.names = "activity",
                   colClasses = "factor")
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors = TRUE)
feature_labels<-read.table("UCI HAR Dataset/features.txt")

## Use the feature labels to label the columns of the data features
colnames(x_test)<-feature_labels$V2
colnames(x_train)<-feature_labels$V2
colnames(subject_test)<-"subject"
colnames(subject_train)<-"subject"

## Label the activity types with text descriptions
levels(y_test$activity)<-activity_labels$V2
levels(y_train$activity)<-activity_labels$V2

## The feature labels contain the 561 different variables (labels only) collected 
## or calculated for the activity monitor. We are concerned with the means and
## standard deviations for each measure.
mean_index<-grepl("mean()",feature_labels$V2)
std_index<-grepl("std()",feature_labels$V2)
mean_std_idx<-mean_index | std_index

## Subset the variables to only the means or std
x_test<-x_test[,mean_std_idx]
x_train<-x_train[,mean_std_idx]

## Combine the subjects, activities, and features for the test and training sets
test<-cbind(subject_test,y_test,x_test)
train<-cbind(subject_train,y_train,x_train)

## Combine the test and training sets 
data<-rbind(test,train)

## Use dplyr to create a tidy txt file with means for each feature, by each
## subject and activity
library(dplyr)
tidydata<- data %>% group_by(subject,activity) %>% summarise_each(funs(mean))
write.table(tidydata,file = "tdata.txt",row.name=FALSE)

