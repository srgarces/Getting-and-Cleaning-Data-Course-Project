

The run_analysis.R script does the follwing:

1. Load the data.table and tidyverse libraries, requires for the analysis

	2. Download data in a zip folder
	
	3. Unzip file 

	4. Create data.tables as follows:

	The id and name for activities: activities <- activity_labels.txt : 6 obs, 2 variables
	Name of the columns: features <- features.txt : obs, 2 variables
	subject_test <- test/subject_test.txt : 2947 obs, 1 variables
	subject_train <- train/subject_train.txt: 7352 obs, 1 variables
	recorderd train data: x_train <- train/X_train.txt: 7352 obs, 561 variables
	data labels for train data: y_train <- train/y_train.txt: 7352 obs, 1 variable
	recorderd train data: x_test <- test/X_test.txt: 2947 obs, 561 variables
	data labels for test data: y_test <- test/y_test.txt: 2947 obs, 1 variable

	5. Follow the 5 steps from instructions:
	5.1 Merges the training and the test sets to create one data set

	x_total (10299 obs, 561 variables) is created by merging x_train and x_test with rbind() 
	y_total (10299 obs, 1 variable) is created by merging y_train and y_test using rbind() 
	subject_total(10299 obs, 1 variable) is created by merging subject_train and subject_test with rbind()
	df (10299 obs, 563 variables) is created by merging subject_total, y_total and x_total with cbind()

	5.2. Extracts only the measurements on the mean and standard deviation for each measurement
	tidy_df (10299 obs, 88 variables) is created by selecting  subject, code and the the mean and std for each measurement from df

	5.3 Uses descriptive activity names to name the activities in the data set
	Numbers in tidy_df$code variable replaced with corresponding activity

	5.4. Appropriately labels the data set with descriptive variable names
	code column in tidy_df renamed
	replace parts of the names with full words to make them clearer. This is done with the gsub() and regular expressions

	5.5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	the data frame grouped_tidy_df (180 obs, 88 variables) is created by taking the means of each variable for each activity subject from tidy_df
	
	6. Finally, export grouped_tidy_df as a .csv file.

