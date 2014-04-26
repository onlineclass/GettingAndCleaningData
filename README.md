## Getting and Cleanning Data Project - Solution description

This repository contains the solution to the peer graded project assignment of 
the Getting and Cleaning Data course.
Following is a brief description of the files in this repository:

* README.md - this file
* CodeBook.md - brief explanation of the columns in the output data 
  file - ml_data_2014-04-26_10-31-22.csv
* ml_data_2014-04-26_10-31-22.csv - tidy data set created using the R 
  script run_analysis.R
* run_analysis.R - data processing R script, version 1
* run_analysis_v2.R - data processing R script, version 2

The only difference between **run_analysis.R** and **run_analysis_v2.R** scripts
consists in the way the main data files (*X_train.txt* and *X_test.txt*) are
being loaded from disk into a data frame object. Version 2 of the script improves 
the overall performance of the script by about **5x**
The rest of the processing tasks are identical in the 2 scripts.

### run_analysis.R

The script performs the tasks described in the project assignment specifications 
for the "Getting and Cleaning Data" class

#####Requirements:
* the Samsung data directories and files are in the same directory
  with this script (directory **"UCI HAR Dataset"** and it's content);
* R working directory is set to the location of the run_analysis.R script;
* the computer running R has sufficient memory (RAM) for loading and
  processing the data files and enough disk space (less than 250kB) for saving 
  the tidy data set;

#####General structure:
The script contains one function which encapsulates the entire data processing 
logic followed by a single statement that calls the function and stores in a 
variable (`ml.data.list`) the output of the function - a list with 2 named 
elements:
* `data` - first elemnt of the list is a data frame containing the filtered data 
  set loaded from the original files. This first element requires ~5.5MB of RAM
* `data.mean` - second element of the list, also a data frame, contains the tidy 
  data set
The tidy data set was also used to generate a disk file in comma-separated format
The naming convention used for the output file is "ml_mean_YYYY-MM-DD_HH-MI-SS.csv"
where YYYY-MM-DD_HH-MI-SS is the date and time of running the script. This way, 
each time the script is sourced (or the function `data_filter()` is called) a 
new file will be created on disk.

#####Data processing steps in data_filter() function
The script performs the following data processing steps, all of which have been 
commented in the R script:
* retrieve the current date and time and store them in a character variable to 
  be used for generating the output file name;
* processes the input argument of the function - `dir_name` - which has a default 
  value and represents the name the top directory that stores the data. The 
  default value is "UCI HAR Dataset". The function expects that directory to be 
  in R's current working directory;
* generate a character vector having as elements the file names and locations 
  (relative to `dir_name`) of the files to be loaded from disk. The last element
  of the vector is name of the output file;
* read all data files from disk and store them in data frame variables. The 
  small explanatory files activity_labels.txt and features.txt are loaded with 
  `read.table()` function while the training and test data files (X, y and subject)
  are loaded using `scan()` in one large data frame - `ml.data`
* from `ml.data`, there will be retained only the columns that have the name 
  containing `mean()` or `std()` character sequences. This filtering will result 
  in a much smaller ml.data data frame with only 68 columns - 66 feature 
  columns (out of the original 561), 1 activity column and 1 subject column;
* compute the feature averages for each distinct combination of activity and 
  subject values and store the result in a new data frame - `agg.ml.data`. 
  This task could be achieved using a single line in the script but I chose to 
  implement it in several steps (commented in the script) for readability
* add a new column to both data frames (`ml.data` and `agg.ml.data`) 
  named _activity.labels_ and populated with the descriptive activity names 
  found in the activity labels explanatory file. The numeric column activity has 
  been kept in the data frames as well since it only takes very little memory 
  and can be processed much easier than a text variable in computations performed 
  outside R (using code written in C++ or C)
* write the `agg.ml.data` data frame in a comma-separated ascii file (see naming 
  convention above)

The file **CodeBook.md** in the repository contains a brief explanation of each 
column name in the `agg.ml.data` data frame (and the output data file).


###run_analysis_v2.R

As mentioned above, the **run_analysis_v2.R** script performs the same tasks 
as run_analysis.R script except for loading the **X_train.txt** and **X_test.txt** 
files, which is done using `laf_open_fwf()` function in the **LaF** package 
(**L**arge **a**SCII **F**iles).

###Performance improvement

Following are the execution times (elapsed time in seconds) of the two scripts:
* run_analysis.R execution time (elapsed) = **10.56 sec**
* run_analysis_v2.R execution time (elapsed) = **2.53 sec**

The performance improvement is ~5 times just by using a different package to read 
large data files which I found to be the single largest performance bottleneck.
