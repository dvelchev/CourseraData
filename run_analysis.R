library(reshape2)   # using melt() and dcast()



# load features' names
dfFtsNames = read.table("features.txt", col.names = c("colid","name"),colClasses="character")

# load activity labels
dfActivityLabels = read.table("activity_labels.txt", col.names = c("id","label"))

# load the training set, its activity IDs and subjects
dfTrain = read.table("train//X_train.txt", col.names = dfFtsNames$name, check.names = F)
dfTrainLabels = read.table("train/y_train.txt", col.names = "activity")
dfTrainSubjects = read.table("train/subject_train.txt", col.names = "subject")

# join the subject id and the activity label to the training set
dfTrain$subject  = dfTrainSubjects$subject
dfTrain$activity = factor(dfTrainLabels$activity, labels = dfActivityLabels$label)

# load the test set, its activity IDs and subjects
dfTest = read.table("test//X_test.txt", col.names = dfFtsNames$name, check.names = F)
dfTestLabels = read.table("test/y_test.txt", col.names = "activity")
dfTestSubjects = read.table("test/subject_test.txt", col.names = "subject")

# join the subject id and the activity label to the test set
dfTest$subject  = dfTestSubjects$subject
dfTest$activity = factor(dfTestLabels$activity, labels = dfActivityLabels$label)

# merge the test and train sets
dfMerged = rbind(dfTrain, dfTest)

# extract only the measurements of mean and standard deviation by searching in the column names for the strings 
# "-mean()" and "-std()"
cnames = colnames(dfMerged)
extractedColumns = cnames[grepl("-(mean|std)\\(\\)", cnames)]

# subset the merged data frame with the extracted columns plus the additional two: 'activity' and 'subject'
dfMerged = subset(dfMerged, select = c("subject", "activity", extractedColumns))


# create a "tidy" data set with the average of each variable for each distinct (subject,activity) pair 

# first, melt the data using 'subject' and 'activity' as ID variables
dfMelt = melt(dfMerged, c("subject", "activity"))

# then, calculate the mean of each measurement
dfTidy = dcast(dfMelt, subject + activity ~ variable, mean)

# save the tidy set to a file
write.table(dfTidy,file="averages.txt",quote = F, row.names = F)
