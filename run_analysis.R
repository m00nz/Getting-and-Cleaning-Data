## Set new local working directory
setwd("C:/local/r/Getting and cleaning data/assignment/UCI HAR Dataset/")

## 1. Read the data set, activity labels, into a table
activity_labels  <- read.table("activity_labels.txt", sep = "", colClasses = list("numeric","character"), col.names = c("activity_num","activity_name"))

## 1.1. Create lookup table for the for the activity labels
activity_names <- activity_labels$activity_name #* put labels into column values
names(activity_names) <- as.numeric(1:length(unique(activity_labels$activity_num))) #* put labels into column names

## 2. Read the data set, features, into a data frame
features <- read.table("features.txt", sep = "", colClasses = c("numeric","character"))

## 2.1. Extract the column names from the features data frame
column_names <- features[,2]

## 3. Creating a function, "my_data_import" for importing the data, and combining into a single data set
my_data_import <- function(subject_data, subject_cols, x_data, x_cols, y_data, y_cols, label_names) {

	## 3.1 Retrieve the subject data
	s <- read.table(subject_data, sep = "", colClasses = c("numeric"), col.names = subject_cols)

	## 3.2. Retrieve the x data (training data set)
	x <- read.table(x_data, sep = "", colClasses = rep("numeric", 561), col.names = x_cols)

	## 3.3. Retrieve the y data (training labels)
	y <- read.table(y_data, sep = "", colClasses = c("numeric"), col.names = y_cols)
	
	## 3.4. Add labels to y activity
	#* create data frame using the numbers as keys, then the label from the new activity name table
	y_with_label <- data.frame(activity_num = y$activity_num, activity_name = (label_names[y$activity_num])) 
	
	## 3.5. Bind the subject data, to the activity labels
	combined_data <- cbind(s, y_with_label)

	## 3.6. Determine mean and standard deviation columns
	columns_to_keep <- grep("mean|std", column_names, value = FALSE, ignore.case = TRUE)
	
	## 3.7. Extract mean and standard deviation columns
	x_mean_std <- x[,columns_to_keep]
	
	## 3.8 Bind the training data set (with only the mean and standard deviation columns)
	final_data <- cbind(combined_data, x_mean_std)
	
	## 3.9. Return the cleaned data
	return(final_data)
}

## 4. Run the test data through the "my_data_import" function, returning a data frame
test_data <- my_data_import("test/subject_test.txt", c("subject"),
							"test/X_test.txt", column_names,
							"test/y_test.txt", c("activity_num"),
							activity_names)

## 5. Run the train data through the "my_data_import" function, returning a data frame
train_data <- my_data_import("train/subject_train.txt", c("subject"), 
							 "train/X_train.txt", column_names,
							 "train/y_train.txt", c("activity_num"),
							 activity_names)
							 
## 6. Combine test and train data into a single data frame
training_data <- rbind(test_data, train_data)

## 7. Load the dplyr library
library(dplyr)

## 8. Using  dplyr library : group data by activity name, subject, then summarise each column, using the mean.
tidy_data <- group_by(training_data, activity_name, subject) %>%
				summarise_each(funs(mean))
				
## Export tidy_data 
write.table(tidy_data, file="tidy_data.txt", row.name=FALSE)
