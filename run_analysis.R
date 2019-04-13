library(plyr)
library(dplyr)

# Download data set
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "dataset.zip", method = "curl")

# Read Data
testX = read.table("./UCI HAR Dataset/test/X_test.txt", header = F)
testY = read.table("./UCI HAR Dataset/test/y_test.txt", header = F)
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt")

trainX = read.table(".UCI HAR Dataset/train/X_train.txt", header = F)
trainY = read.table("./UCI HAR Dataset/train/y_train.txt", header = F)
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt")

activity_labels = read.table("~/Dropbox/GetAndCleanData/dataset/activity_labels.txt")

# Merges the training and the test sets to create one data set.
X = rbind(testX, trainX)
Y = rbind(testY, trainY)
subject = rbind(subject_test, subject_train)

# Assign column name
columnName = read.table("~/Dropbox/GetAndCleanData/dataset/features.txt")[, 2]
colnames(X) <- columnName

# Extracts only the measurements on the mean and standard deviation for each measurement.
filterX = X[,grepl( "mean|std" , names( X ) ) ]

# Uses descriptive activity names to name the activities in the data set
label <- mapvalues(factor(Y[,1]), from=activity_labels[,1], to=as.character(activity_labels[,2]))

# Appropriately labels the data set with descriptive variable names.
filterX = cbind(filterX, label)

write.table(filterX, "./table.txt", row.name=FALSE)

