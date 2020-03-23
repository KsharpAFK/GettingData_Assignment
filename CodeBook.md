The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

--Merges the training and the test sets to create one data set
X is created by merging x_train and x_test using rbind() function
Y is created by merging y_train and y_test using rbind() function
Subject is created by merging subject_train and subject_test using rbind() function
Merged_Data is created by merging Subject, Y and X using cbind() function

--Extracts only the measurements on the mean and standard deviation for each measurement
Measurements is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

--Use descriptive activity names
Entire numbers in code column of the Measurements replaced with activity taken from second column of the activities variable

--SubmissionData is created by sumarizing Measurements taking the means of each variable for each activity and each subject, after groupped by subject and activity and saved as SubmissionData.txt