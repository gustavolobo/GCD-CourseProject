## Read all the files needed to memory
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
features <- read.table(("./UCI HAR Dataset/features.txt"))
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")
yTest <- read.table("./UCI HAR Dataset/test/Y_test.txt")

## Merge the train and test sets in order to create just one
subjectTrainTest <- rbind(subjectTrain, subjectTest)
xTrainTest <- rbind(xTrain, xTest)
yTrainTest <- rbind(yTrain, yTest)

## The column name of the subjects will be 'subject'
colnames(subjectTrainTest) <- "subject"

## The column name of the activities description will be 'activity'
colnames(yTrainTest) <- "activity"

## Uses descriptive activity names
for(i in seq(nrow(activity_labels))) {
  yTrainTest$activity[yTrainTest$activity == activity_labels$V1[i]] <- activity_labels$V2[i]
}

## Set the column names
colnames(xTrainTest) <- features$V2

## Select the columns to keep (the ones with 'mean()' and 'std()')
columnsToKeep <- vector()
for(i in seq(colnames(xTrainTest))) {
  columnName <- colnames(xTrainTest)[i]
  if(grepl("mean()", columnName, fixed = TRUE) | grepl("std()", columnName, fixed = TRUE)){
    columnsToKeep <- c(columnsToKeep, columnName)
  }
}
xTrainTest <- subset(xTrainTest, select = columnsToKeep)

## Uses descriptive variable names
colnames(xTrainTest) <- gsub("Acc", "Accelerometer", colnames(xTrainTest))
colnames(xTrainTest) <- gsub("Gyro", "Gyroscope", colnames(xTrainTest))
colnames(xTrainTest) <- gsub("mean", "Mean", colnames(xTrainTest))
colnames(xTrainTest) <- gsub("std", "StandardDeviation", colnames(xTrainTest))
colnames(xTrainTest) <- gsub("Mag", "Magnitude", colnames(xTrainTest))
colnames(xTrainTest) <- gsub("-", "", colnames(xTrainTest))
colnames(xTrainTest) <- gsub("\\(", "", colnames(xTrainTest))
colnames(xTrainTest) <- gsub("\\)", "", colnames(xTrainTest))

# Bind all the columns together
tidyDataSet <- cbind(subjectTrainTest, yTrainTest, xTrainTest)

## Exports the tidy dataset to a file
write.table(tidyDataSet, "./tidyDataSet.txt", row.names = FALSE)