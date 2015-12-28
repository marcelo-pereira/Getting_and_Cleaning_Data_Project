library(reshape2)
library(dplyr)

# Load the train and test data
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")

# Update column names based on the features.txt file
features <- read.table("features.txt")
colnames(X_train) <- features[,2]
colnames(X_test) <- features[,2]

# Add the type of data before merge test and training data
X_train <- cbind(TypeOfData = "training",X_train)
X_test <- cbind(TypeOfData = "test",X_test)

# Merge the training dataset with the activity and subject number 
Y_train <- read.table("Y_train.txt")
subject_train <- read.table("subject_train.txt")
trainingDataSet <- cbind(subject_train,Y_train,X_train)
names(trainingDataSet)[1] <- "Subject"
names(trainingDataSet)[2] <- "Activity"

# Merge the test dataset with the activity and subject number 
Y_test <- read.table("Y_test.txt")
subject_test <- read.table("subject_test.txt")
testDataSet <- cbind(subject_test,Y_test,X_test)
names(testDataSet)[1] <- "Subject"
names(testDataSet)[2] <- "Activity"

# Merge the training and test datasets
mergedData <- rbind(trainingDataSet,testDataSet)

# Add descriptive activity names
activities <- read.table("activity_labels.txt")

mergedData["Activity"]=activities[match(as.character(unlist(mergedData[2])), 
                       as.character(activities[[1]])), 2]

# Extracts only the measurements related to the mean or standard deviation
requiredColumns <- grep ("mean|std|Subject|Activity|TypeOfData",names(mergedData))
cleanedData <- mergedData[,requiredColumns]


