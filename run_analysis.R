# Getting Data and Clean : Course Project 


library(reshape2)


# Reading the data :  

# Train Data : 

x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
sub_train <- read.table("./train/subject_train.txt")


# Test Data : 

x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
sub_test <- read.table("./test/subject_test.txt")


# Merge the data :

x_data <- rbind(x_train, x_test)
xse_data
y_data <- rbind(y_train, y_test)
y_data
s_data <- rbind(sub_train, sub_test)
s_data



# Load features and activity labels : 


features <- read.table("./features.txt")
features


# Load activity labels : 

a_label <- read.table("./activity_labels.txt")
a_label

a_label[,2] <- as.character(a_label[,2])


# Extract feature cols and names named mean and std

selectedCols <- grep("-(mean|std).*", as.character(features[,2]))
selectedColNames <- features[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)
View(selectedCols)



# Extract data by cols and using descriptive names 



x_data <- x_data[selectedCols]          #aik tarha se subset bana dia ha selected column ko. aur selected coloumn ko utha kar x_data mae dal dia ha
allData <- cbind(s_data, y_data, x_data)
colnames(allData) <- c("Subject", "Activity", selectedColNames)

allData$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
allData$Subject <- as.factor(allData$Subject)                           


# generate tidy dataset : 

meltData <- melt(allData, id = c("Subject","Activity"))
tidydata <- dcast(meltData, Subject + Activity ~ variable, mean)
tidydata


write.table(tidydata, "./tidy_data.txt", row.names = FALSE, quote = FALSE)
