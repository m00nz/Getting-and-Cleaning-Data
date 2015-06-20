---
title: "Getting and cleaning data"
author: "N. DeVan"
date: "2015-06-20"
output:
  html_document:
    keep_md: yes
---

## Project Description
The run_analysis.r is process the raw data received from recording the wearable data, and outputs the tidy data to a file, 'tidy_data.txt'

##Study design and data processing

###Collection of the raw data
The data was received during the "Human Activity Recognition Using Smartphones Dataset" experiment.

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


##Creating the tidy datafile

###Guide to create the tidy data file
1. Download the data from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Extract the data to your working directory. A new folder will be created named "UCI HAR Dataset"
3. Open run_analysis.r, edit the working directory to the new folder, "UCI HAR Dataset"
4. Run the run_analysis.R
5. tidy_data.txt will output to the working directory

###Cleaning of the data
The following steps are followed while processing the data.

 1. Read the data set, activity labels, into a table
	1.1. Create lookup table for the for the activity labels
 2. Read the data set, features, into a data frame
	2.1. Extract the column names from the features data frame
 3. Create a function, "my_data_import" for importing the data, and combining into a single data set
	The function accepts the following parameters:
	
	Argument|Description
	------------|-----------------------------------------------
	subject_data|the location of the subject data 
	subject_cols|the column names to use for the subject data 
	x_data|the location of the x data         
	x_cols|the column names to use for the x data        
	y_data|the location of the y data         
	y_cols|the column names to use for the y data        
	label_names|the lookup table for the action names 
	
	3.1. Retrieve the subject data
	3.2. Retrieve the x data (training data set)
	3.3. Retrieve the y data (training labels)
	3.4. Add labels to y activity. Creates data frame using the numbers as keys, then the label from the new activity name table
	3.5. Bind the subject data, to the activity labels
	3.6. Determine the mean and standard deviation columns
	3.7. Extract mean and standard deviation columns
	3.8. Bind the training data set (with only the mean and standard deviation columns)
	3.9. Return the cleaned data
	
 4. Run the test data through the "my_data_import" function
 5. Run the train data through the "my_data_import" function
 6. Combine test and train data into a single data frame
 7. Load the dplyr library
 8. Using  dplyr library : group data by activity name, subject, then summarise each column, using the mean.


##Description of the variables in the tidy_data.txt file
The tidy_data has 180 observations, 
 - 6 activities
 - 30 subjects

The tidy_data has 89 variables,
 - activity_name
 - subject
 - activity_num
 - mean measurements (86 variables)
	- The remaining variables each contain the mean one type of measurement. 
	- For additional details about the measurements, please refer to the original codebook "features_info.txt" for additional information
 
###activity_name
Contains the name of the activity. 
It is of "character" class. 
There are 6 possible variables:
"WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"
 
###subject
Contains the subject identifier. 
It is of "numeric" class. 
There were 30 subjects in the study
 
###activity_num
Contains the number associated to the activity
It is of "numeric" class. 
There are 6 possible variables, and map directly to the activity_name:
1 "WALKING"
2 "WALKING_UPSTAIRS"
3 "WALKING_DOWNSTAIRS"
4 "SITTING"
5 "STANDING"
6 "LAYING"

###mean measurements
- The remaining 86 variables each contain the mean one type of measurement. 
- For additional details about the measurements, please refer to the original codebook "features_info.txt" for additional information
- Measurements which were not the mean or standard deviation have been removed.

##Sources
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
