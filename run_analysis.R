library("data.table")
library("reshape2")

## load the test data
xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")
stest <- read.table("test/subject_test.txt")

## load the train data
xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt")
strain <- read.table("train/subject_train.txt")


label <- read.table("activity_labels.txt")[,2]

feature <- read.table("features.txt")[,2]

target <- grepl("mean|std", feature)

## Appropriately labels the data set with descriptive variable names
names(xtest) <- feature
names(xtrain) <- feature

## Extracts only the measurements on the mean and standard deviation for each measurement. 
meanStd1 <- xtest[,target]
meanStd2 <- xtrain[,target]

## name the column in order to combine data later
names(ytest)<-c("activity","label")
names(stest)<-"subject"
names(ytrain)<-c("activity","label")
names(strain)<-"subject"

## Uses descriptive activity names to name the activities in the data set
for (i in 1:nrow(ytest)){
    ytest[i,2]<-label[ytest[i,1]]
}

for (i in 1:nrow(ytrain)){
  ytrain[i,2]<-label[ytrain[i,1]]
}


 
## Merges the training and the test sets to create one data set.
data1 <- cbind(stest, ytest, xtest)
data2 <- cbind(strain, ytrain, xtrain)
data <- rbind(data1, data2)
data <- setorder(data,cols="subject")

## The following code was inspired by the work of 
## http://datasciencecoursera.blogspot.com/2015/09/getting-and-cleaning-data-course-project.html
## especially the two function melt() and dcast() in reshape package
idLabel <- c("subject", "activity", "label")
dataLabel <- setdiff(names(data), idLabel)
meltData <- melt(data, id.vars = idLabel, measure.vars = dataLabel)

## From the data set in step 4, creates a second, independent
## tidy data set with the average of each variable for each activity and each subject.
tidy<-dcast(meltData, subject + label ~ variable, mean)
write.table(tidy, file = "finaldata.txt",row.names = FALSE)
