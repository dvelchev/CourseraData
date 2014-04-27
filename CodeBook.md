## The raw data set

The [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) contains data collected from the recordings of 30 volunteers performing six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) while carrying a waist-mounted smartphone with embedded inertial sensors.  
The data consists of the sampled and pre-processed signals of the embedded accelerometer and gyroscope, labeled with the activity that the subject was carrying on while the signal was captured and randomly split into a training and test sets.  
The dataset is available for download at this [location](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip)  
For more details, see the file *README.txt* contained in the dataset archive.  


## The generated data set

The R script ['run_analysis.R'](./run_analysis.R) merges the train and test sets and summarizes the mean values of a subset of the original features for each (subject,activity) pair.  
The summary contains the measurements from the following 33 signals:  

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag  

The signals not included in the summary are:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean  

For each signal of interest, the summary includes two features of the original dataset that contain the estimations of the signal's mean and standard deviation.  
The result is the averages of each of the 66 features, summarized over each (subject,activity) pair contained in the original train and test datasets.

## Code book

Each record in the generated dataset contains the following items:
* subject - type: integer, range = [1,30],  ID of the person performing the activity 
* activity - one of [WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING] - a label indicating the performed activity
* 66 real numbers, range [-1,1] - the averages across both the training and test sets of the 66 original features of interest for the specified (subject,activity) pair  

The format of the file is a space delimited text file with a header row that contains the names of the 68 features in the record. Text values are unquoted.  
The names of the columns of the 66 averages are identical to the variables in the original dataset.

## Data process
The script performs the following steps:  

1. Loads the original train and test datasets from the files 'X_train.txt' and 'X_test.txt' into data.frame objects  
2. Attaches the feature names loaded from the file 'features.txt' as column names of the data frames  
3. Joins the value of the subject ID, loaded from the file 'subject_train.txt', to the train data frame  
4. Joins the value of the subject ID, loaded from the file 'subject_test.txt', to the test data frame  
5. Joins the human readable label of the activity, loaded from the file 'y_train.txt', to the train data frame  
6. Joins the human readable label of the activity, loaded from the file 'y_test.txt', to the test data frame  
7. Merges the train and test data frames into one using rbind()  
8. Extracts the column names of the features of interest by searching for the patterns '-mean()' and '-std()' in the column names and filters out the remaining features from the merged data frame  
9. Uses the function *melt()* and *dcast()* from the R package *reshape2* to generate the mean values of the features of interest for each (subject,activity) pair  
10. Saves the result to the file 'averages.txt'


## Running the script  

### Requirements  
1. If not already present, install the R package *'reshape2'*
2. [Download](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip) and extract the contents of the original data set.
3. When reading the data files, the script assumes that the original data is present in the currect working directory.


