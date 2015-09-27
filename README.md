#GETTING AND CLEANING DATA COURSE PROJECT#

Download the DATA for the project from this URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To reproduce the steps described below, and to use the run_analysis.R file, you need to download the above zip file, decompress the file, and have the run_analysis.R file in the top level folder of the unzipped package.

Overall Process

The five steps to complete the Course Project are:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


It should run in a folder of the Samsung data (the zip had this folder: UCI HAR Dataset) The script assumes it has in it's working directory the following files and folders:

activity_labels.txt
features.txt
test/
train/

run_analysis.R steps:

Step 1:

Read all the test and training files: y_test.txt, subject_test.txt and X_test.txt.
Combine the files to a data frame in the form of subjects, labels, the rest of the data.

Step 2:

Read the features from features.txt and extract only the mean and standard deviation.
A new data frame is then created that includes subjects, labels and the described features.

Step 3:

Read the activity labels from activity_labels.txt and enter the name of activity into datatable.

Step4:
Make a column list (includig "subjects" and "label" at the start)
Create a new data frame by finding the mean for each combination of subject and label. It's done by aggregate() function

Step 5:

Write the new tidy set into a text file called tidy2.txt, formatted similarly to the original files.
