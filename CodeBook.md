### Tidy data set variables

The following list contains a brief explanation (or formula) for each of the 
columns present in the **tidy data set** (ml_data_2014-04-26_10-31-22.csv file):

* mean_tBodyAcc.mean.X - mean(tBodyAcc-mean()-X)
* mean_tBodyAcc.mean.Y - mean(tBodyAcc-mean()-Y)
* mean_tBodyAcc.mean.Z - mean(tBodyAcc-mean()-Z)
* mean_tBodyAcc.std.X - mean(tBodyAcc-std()-X)
* mean_tBodyAcc.std.Y - mean(tBodyAcc-std()-Y)
* mean_tBodyAcc.std.Z - mean(tBodyAcc-std()-Z)
* mean_tGravityAcc.mean.X - mean(tGravityAcc-mean()-X)
* mean_tGravityAcc.mean.Y - mean(tGravityAcc-mean()-Y)
* mean_tGravityAcc.mean.Z - mean(tGravityAcc-mean()-Z)
* mean_tGravityAcc.std.X - mean(tGravityAcc-std()-X)
* mean_tGravityAcc.std.Y - mean(tGravityAcc-std()-Y)
* mean_tGravityAcc.std.Z - mean(tGravityAcc-std()-Z)
* mean_tBodyAccJerk.mean.X - mean(tBodyAccJerk-mean()-X)
* mean_tBodyAccJerk.mean.Y - mean(tBodyAccJerk-mean()-Y)
* mean_tBodyAccJerk.mean.Z - mean(tBodyAccJerk-mean()-Z)
* mean_tBodyAccJerk.std.X - mean(tBodyAccJerk-std()-X)
* mean_tBodyAccJerk.std.Y - mean(tBodyAccJerk-std()-Y)
* mean_tBodyAccJerk.std.Z - mean(tBodyAccJerk-std()-Z)
* mean_tBodyGyro.mean.X - mean(tBodyGyro-mean()-X)
* mean_tBodyGyro.mean.Y - mean(tBodyGyro-mean()-Y)
* mean_tBodyGyro.mean.Z - mean(tBodyGyro-mean()-Z)
* mean_tBodyGyro.std.X - mean(tBodyGyro-std()-X)
* mean_tBodyGyro.std.Y - mean(tBodyGyro-std()-Y)
* mean_tBodyGyro.std.Z - mean(tBodyGyro-std()-Z)
* mean_tBodyGyroJerk.mean.X - mean(tBodyGyroJerk-mean()-X)
* mean_tBodyGyroJerk.mean.Y - mean(tBodyGyroJerk-mean()-Y)
* mean_tBodyGyroJerk.mean.Z - mean(tBodyGyroJerk-mean()-Z)
* mean_tBodyGyroJerk.std.X - mean(tBodyGyroJerk-std()-X)
* mean_tBodyGyroJerk.std.Y - mean(tBodyGyroJerk-std()-Y)
* mean_tBodyGyroJerk.std.Z - mean(tBodyGyroJerk-std()-Z)
* mean_tBodyAccMag.mean - mean(tBodyAccMag-mean())
* mean_tBodyAccMag.std - mean(tBodyAccMag-std())
* mean_tGravityAccMag.mean - mean(tGravityAccMag-mean())
* mean_tGravityAccMag.std - mean(tGravityAccMag-std())
* mean_tBodyAccJerkMag.mean - mean(tBodyAccJerkMag-mean())
* mean_tBodyAccJerkMag.std - mean(tBodyAccJerkMag-std())
* mean_tBodyGyroMag.mean - mean(tBodyGyroMag-mean())
* mean_tBodyGyroMag.std - mean(tBodyGyroMag-std())
* mean_tBodyGyroJerkMag.mean - mean(tBodyGyroJerkMag-mean())
* mean_tBodyGyroJerkMag.std - mean(tBodyGyroJerkMag-std())
* mean_fBodyAcc.mean.X - mean(fBodyAcc-mean()-X)
* mean_fBodyAcc.mean.Y - mean(fBodyAcc-mean()-Y)
* mean_fBodyAcc.mean.Z - mean(fBodyAcc-mean()-Z)
* mean_fBodyAcc.std.X - mean(fBodyAcc-std()-X)
* mean_fBodyAcc.std.Y - mean(fBodyAcc-std()-Y)
* mean_fBodyAcc.std.Z - mean(fBodyAcc-std()-Z)
* mean_fBodyAccJerk.mean.X - mean(fBodyAccJerk-mean()-X)
* mean_fBodyAccJerk.mean.Y - mean(fBodyAccJerk-mean()-Y)
* mean_fBodyAccJerk.mean.Z - mean(fBodyAccJerk-mean()-Z)
* mean_fBodyAccJerk.std.X - mean(fBodyAccJerk-std()-X)
* mean_fBodyAccJerk.std.Y - mean(fBodyAccJerk-std()-Y)
* mean_fBodyAccJerk.std.Z - mean(fBodyAccJerk-std()-Z)
* mean_fBodyGyro.mean.X - mean(fBodyGyro-mean()-X)
* mean_fBodyGyro.mean.Y - mean(fBodyGyro-mean()-Y)
* mean_fBodyGyro.mean.Z - mean(fBodyGyro-mean()-Z)
* mean_fBodyGyro.std.X - mean(fBodyGyro-std()-X)
* mean_fBodyGyro.std.Y - mean(fBodyGyro-std()-Y)
* mean_fBodyGyro.std.Z - mean(fBodyGyro-std()-Z)
* mean_fBodyAccMag.mean - mean(fBodyAccMag-mean())
* mean_fBodyAccMag.std - mean(fBodyAccMag-std())
* mean_fBodyBodyAccJerkMag.mean - mean(fBodyBodyAccJerkMag-mean())
* mean_fBodyBodyAccJerkMag.std - mean(fBodyBodyAccJerkMag-std())
* mean_fBodyBodyGyroMag.mean - mean(fBodyBodyGyroMag-mean())
* mean_fBodyBodyGyroMag.std - mean(fBodyBodyGyroMag-std())
* mean_fBodyBodyGyroJerkMag.mean - mean(fBodyBodyGyroJerkMag-mean())
* mean_fBodyBodyGyroJerkMag.std - mean(fBodyBodyGyroJerkMag-std())
* subject - the id of the human subject
* activity - the id of the activity
* activity.label - the descriptive name of the activity

The mean_... variables, as shown by the formula, represent the mean of some of 
the original values computed for a distinct combination of **subject and activity** 
values.

For a description of the original column names check the URL provided in the 
project assignment description: 
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
Also, additional info (related to the initial raw data processing) can be found 
in the README.txt file in the data directory - **UCI HAR Dataset/README.txt**
