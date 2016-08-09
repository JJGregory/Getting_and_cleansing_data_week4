#download the raw data

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists("data")) {
  dir.create("data")
}

setwd(file.path(getwd(),"data"))

f<-(file.path(getwd(),"Data.zip"))

download.file(url,f)
datedownloaded<-date

#unzip the downloaded file
unzip("./data/Data.zip",exdir = "./data")


#read in the relevant tables

trainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
testData <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
trainLabels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
testLabels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
activityName <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
featureNames <- read.table("./data/UCI HAR Dataset/features.txt")
trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#label the test and training data with appropriate variable names

names(testData) = featureNames$V2
names(trainData) = featureNames$V2


#Convert labels to descriptions of movements

trainLabels$V1 <- activityName[trainLabels$V1,2]
names(trainLabels)[1] = "Activity"
testLabels$V1 <- activityName[testLabels$V1,2]
names(testLabels)[1] = "Activity"


#Add the subject IDs and activity labels into testDAta and trainData, give the inserted variables appropriate names

testData <- cbind(testSubject,testData,testLabels)
names(testData)[1] = c("Subject_ID")
trainData <- cbind(trainSubject, trainData, trainLabels)
names(trainData)[1] = "Subject_ID"

#Merge the two data sets

allData <- rbind(testData, trainData)

#find the columnns containing means and standard deviations use x\\(\\) to escape the group  - "()" - metacharacter

findCol <- grep("mean\\(\\)|std\\(\\)",names(allData))

#filter all data down to the columns containing means,  standard deviations, subject ID, or activity label

allData2 <-allData[,c(1,findCol,563)]


#Create a second, independent tidy data set with the average of each variable for each activity and each subject

featureAverage<-aggregate(.~Subject_ID + Activity, data = allData2,FUN=mean)



#write to a file called tidyData

write.table(featureAverage,"./data/tidyData.txt",row.names = FALSE)
