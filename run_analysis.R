# The following script will prepare the given raw data into a tidy dataset



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
