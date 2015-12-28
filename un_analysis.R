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

# Merge the training dataset with the activity number 
Y_train <- read.table("Y_train.txt")
trainingDataSet <- cbind(Y_train,X_train)

# Merge the test dataset with the activity number 
Y_test <- read.table("Y_test.txt")
testDataSet <- cbind(Y_test,X_test)

# Merge the training and test datasets
mergedData <- rbind(trainingDataSet,testDataSet)

# Add descriptive activity names
activities <- read.table("activity_labels.txt")

mergedData["V1"]=activities[match(as.character(unlist(mergedData[1])), 
                       as.character(activities[[1]])), 2]
write.table(mergedData,file="mergedData.csv",row.name=FALSE) 
