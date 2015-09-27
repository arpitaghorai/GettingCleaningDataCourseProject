# 1. -- Merge training and test sets to create one data set.

# Read subject files
SubjectTrain <- tbl_df(read.table(file.path(path, "train", "subject_train.txt")))
SubjectTest  <- tbl_df(read.table(file.path(path, "test" , "subject_test.txt" )))

# Read activity files
ActivityTrain <- tbl_df(read.table(file.path(path, "train", "Y_train.txt")))
ActivityTest <- tbl_df(read.table(file.path(path, "test", "Y_test.txt")))

# Read data files
dataTrain <- tbl_df(read.table(file.path(path, "train", "X_train.txt" )))
dataTest <- tbl_df(read.table(file.path(path, "test", "X_test.txt" )))

#  merge the training and the test sets by row binding 
#and rename variables "subject" and "activityNum"

allSubject <- rbind(SubjectTrain, SubjectTest)
setnames(allSubject, "V1", "subject")

allActivity<- rbind(ActivityTrain, ActivityTest)
setnames(allActivity, "V1", "activityNum")

#combine the DATA training and test files
datatable <- rbind(dataTrain, dataTest)

#column names for activity labels
activityLabels<- tbl_df(read.table(file.path(path, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))

# Merge columns
alldataSubject <- cbind(allSubject, allActivity)
datatable <- cbind(alldataSubject, datatable)


# 2. -- Extracts only the measurements on the mean and standard deviation for each measurement.

# Read in the feature names from the features.txt file.
dataFeatures <- tbl_df(read.table(file.path(path, "features.txt")))
# name variables according to feature
setnames(dataFeatures, names(dataFeatures), c("featureNum","featureName"))
colnames(datatable) <- dataFeatures$featureName
# Reading "features.txt" and extracting only the mean and standard deviation
dataFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",dataFeatures$featureName,value=TRUE) 

# Taking only measurements for the mean and standard deviation and add "subject","activityNum"
dataFeaturesMeanStd <- union(c("subject","activityNum"), dataFeaturesMeanStd)
datatable <- subset(datatable, select=dataFeaturesMeanStd)

#3 & 4
# enter the name of activity into datatable
datatable <- merge(activityLabels, datatable, by="activityNum", all.x=TRUE)
datatable$activityName <- as.character(datatable$activityName)
# create dataTable with variable means sorted by subject and Activity
dataAggr <- aggregate(. ~ subject - activityName, data = datatable, mean)
datatable <- tbl_df(arrange(dataAggr,subject,activityname))
#5
#write a text file
write.table(datatable, "TidyData.txt", row.name=FALSE)