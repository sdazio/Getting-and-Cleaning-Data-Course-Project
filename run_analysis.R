library(reshape2)

# Zip file, data directory and file names
zipFileName <- "getdata_dataset.zip"
zipFileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
dataDirectory <- "UCI HAR Dataset"

activityLabelsFile <- "UCI HAR Dataset/activity_labels.txt"

featureLabelsFile <- "UCI HAR Dataset/features.txt"

trainingDataFile <- "UCI HAR Dataset/train/X_train.txt"
trainingActivitiesFile <- "UCI HAR Dataset/train/Y_train.txt"
trainingSubjectsFile <- "UCI HAR Dataset/train/subject_train.txt"

testDataFile <- "UCI HAR Dataset/test/X_test.txt"
testActivitiesFile <- "UCI HAR Dataset/test/Y_test.txt"
testSubjectsFile <- "UCI HAR Dataset/test/subject_test.txt"

## Download and unzip the dataset:
if (!file.exists(zipFileName)){
  download.file(zipFileURL, zipFileName, method="curl")
}  

## Unzip data directory
if (!file.exists(dataDirectory)) { 
  unzip(zipFileName) 
}

# Load activity labels + features
activityLabels <- read.table(activityLabelsFile)
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table(featureLabelsFile)
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
selectedFeatures <- grep(".*mean.*|.*std.*", features[,2])
selectedFeatures.names <- features[selectedFeatures,2]
selectedFeatures.names = gsub('-mean', 'Mean', selectedFeatures.names)
selectedFeatures.names = gsub('-std', 'Std', selectedFeatures.names)
selectedFeatures.names <- gsub('[-()]', '', selectedFeatures.names)


# Load the datasets
train <- read.table(trainingDataFile)[selectedFeatures]
trainActivities <- read.table(trainingActivitiesFile)
trainSubjects <- read.table(trainingSubjectsFile)
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table(testDataFile)[selectedFeatures]
testActivities <- read.table(testActivitiesFile)
testSubjects <- read.table(testSubjectsFile)
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", selectedFeatures.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

# Create the tidy data set
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
