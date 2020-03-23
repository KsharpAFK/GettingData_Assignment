# The following script will prepare the given raw data into a tidy dataset


# check to see if data is present in directory or else download the data and create the file

filename <- "Coursera_GCD.zip"

# Check if archieve already exists.
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method="curl")
}  

# Check if folder exists
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

# Initialize all the data tables

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



# Merge the train and test data sets

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_data <- cbind(Subject, Y, X)

# Extract mean and standard deviation measurements, apply descriptive names to activities and variables

Measurements <- Merged_data %>% select(subject, code, contains("mean"), contains("std"))

Measurements$code <- activities[Measurements$code, 2]

names(Measurements)[2] = "activity"
names(Measurements)<-gsub("Acc", "Accelerometer", names(Measurements))
names(Measurements)<-gsub("Gyro", "Gyroscope", names(Measurements))
names(Measurements)<-gsub("BodyBody", "Body", names(Measurements))
names(Measurements)<-gsub("Mag", "Magnitude", names(Measurements))
names(Measurements)<-gsub("^t", "Time", names(Measurements))
names(Measurements)<-gsub("^f", "Frequency", names(Measurements))
names(Measurements)<-gsub("tBody", "TimeBody", names(Measurements))
names(Measurements)<-gsub("-mean()", "Mean", names(Measurements), ignore.case = TRUE)
names(Measurements)<-gsub("-std()", "STD", names(Measurements), ignore.case = TRUE)
names(Measurements)<-gsub("-freq()", "Frequency", names(Measurements), ignore.case = TRUE)
names(Measurements)<-gsub("angle", "Angle", names(Measurements))
names(Measurements)<-gsub("gravity", "Gravity", names(Measurements))



#create a second independent tidy data set with the average of each variable
#for each activity and each subject


Data <- Measurements %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(Data, "SubmissionData.txt", row.name=FALSE)
