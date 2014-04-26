## "run_analysis.R" script performs the five tasks described in the project 
## assignment specifications for the "Getting and Cleaning Data" class
##
## Requirements:
##    - the Samsung data directories and files are in the same directory
##      with this script (directory "UCI HAR Dataset" and it's content);
##    - R working directory is set to the location of the run_analysis.R script;
##    - the computer running R has sufficient memory (RAM) for loading and
##      processing the data files and enough disk space for saving the tidy
##      data set;
##
## To execute the script, either in R Studio or at command line in R:
##    - set the working directory to the location of #run_analysis.R" script
##                 > setwd("<script_and_data_directory>")
##    - execute the run_analysis.R script
##                 > source("run_analysis.R")
##
## Output: in the working directory a new file will be created containing the
## tidy data set. The output file naming format is:
##            ml_mean_YYYY-MM-DD_HH-MI-SS.csv
## where YYYY-MM-DD_HH-MI-SS is the date and time of running the R script


## All the tasks performed by the script are encapsulated in a function
data_filter <- function(dir_name = "UCI HAR Dataset") {
    ## Get the date and time of processing as a string "YYYY-MM-DD_HH-MM-SS"
    d <- gsub(" ", "_", fixed = T, 
              gsub(":", "-", fixed = T, as.character(Sys.time())))
    
    ## First make sure 'dir_name' doesn't contain any trailing back- or 
    ## forward-slash characters (if data_filter is called with non-NULL arg)
    while (identical(substr(dir_name, nchar(dir_name), nchar(dir_name)), "\\") 
           | identical(substr(dir_name, nchar(dir_name), nchar(dir_name)), "/"))
        dir_name <- substr(dir_name, 0, nchar(dir_name) - 1)
    
    ## Check if there is a directory named "UCI HAR Dataset" in the current
    ## working directory. If there is no data, print a message and exit
    if (!file.exists(dir_name)) {
        message(paste("Can not find the default data directory. If you",
                      "renamed the data directory, please run",
                      "'data_filter(<data_dir_name>)'"))
        return(NULL)
    }
    
    ## Set the folder separator
    fs = "/"
    ## If we are on Windows we use the forward-slash as folder separator
    if (grepl("windows", tolower(Sys.info()['sysname']))) {
        fs <- "\\"
    }
    
    ## Check the data files for both train and test sets, including
    ## activity_labels.txt and features.txt
    data_files <- c(as.character(paste(dir_name, fs, "activity_labels.txt", sep = "")))
    data_files <- c(data_files, as.character(paste(dir_name, 
                                                   fs, "features.txt", 
                                                   sep = "")))
    data_files <- c(data_files, as.character(paste(dir_name, 
                                                   fs, "test", 
                                                   fs, "subject_test.txt", 
                                                   sep = "")))
    data_files <- c(data_files, as.character(paste(dir_name, 
                                                   fs, "test", 
                                                   fs, "X_test.txt", sep = "")))
    data_files <- c(data_files, as.character(paste(dir_name, 
                                                   fs, "test", 
                                                   fs, "y_test.txt", sep = "")))
    data_files <- c(data_files, as.character(paste(dir_name, 
                                                   fs, "train", 
                                                   fs, "subject_train.txt", 
                                                   sep = "")))
    data_files <- c(data_files, as.character(paste(dir_name, 
                                                   fs, "train", 
                                                   fs, "X_train.txt", sep = "")))
    data_files <- c(data_files, as.character(paste(dir_name, 
                                                   fs, "train", 
                                                   fs, "y_train.txt", sep = "")))
    data_files <- c(data_files, as.character(paste("ml_mean_", 
                                                   d, ".csv", sep = "")))
    names(data_files) <- c("activity_labels", "features", 
                           "subject_test", "X_test", "y_test", 
                           "subject_train", "X_train", "y_train", "out_csv")
    
    ##  Check if the data files exist
    if (sum(file.exists(data_files)) != 8) {
        message(paste("Can not find one or more files in the data directory.",
                      "Make sure you have all the files in the original",
                      "folder structure for the project and then execute", 
                      "'data_filter(<data_dir_name>)'"))
        return
    }
    
    ## Read the activity labels and the feature names
    activity_labels <- read.table(data_files["activity_labels"], sep = " ", 
                                  stringsAsFactors = F, 
                                  col.names = c("activity_id", "activity_name"))
    feature_labels <- read.table(data_files["features"], sep = " ", 
                                  stringsAsFactors = F, 
                                  col.names = c("feature_id", "feature_name"))
    
    ## Read the 'X_train.txt' and 'X_test.txt' files in a data frame (ml.data)
    ml.data <- as.data.frame(matrix(c(scan(data_files["X_train"], quiet = T), 
                                      scan(data_files["X_test"], quiet = T)), 
                                    ncol = 561, byrow = T, 
                                    dimnames = list(NULL, feature_labels[,2])))
    
    ## Replace "-" character with "." and remove the character sequence "()"
    names(ml.data) <- gsub("-", ".", fixed = T, 
                           gsub("()", "", fixed = T, names(ml.data)))
    
    ## Retain in ml.data data frame only the columns with names that contain the 
    ## sequence "-mean()" or "-std()"
    ml.data <- ml.data[,grepl(glob2rx("*mean()*"), feature_labels[,"feature_name"])
                       |grepl(glob2rx("*std()*"), feature_labels[,"feature_name"])]
    
    ## Create the data frame for CodeBook.md
    code.book <- data.frame(ml.data.column = names(ml.data), feature.name = 
        feature_labels[grepl(glob2rx("*mean()*"), feature_labels[,"feature_name"]) | 
        grepl(glob2rx("*std()*"), feature_labels[,"feature_name"]),"feature_name"])
    
    
    ## Read the subject data from files (subject_train.txt and subject_test.txt)
    ## and from files (y_train.txt and y_test.txt) the observed class (activity)
    ## data and add them as the last 2 columns
    ml.data <- cbind(ml.data,
                     data.frame(subject = 
                                c(scan(data_files["subject_train"], quiet = T), 
                                  scan(data_files["subject_test"], quiet = T))),
                     data.frame(activity = 
                                c(scan(data_files["y_train"], quiet = T), 
                                  scan(data_files["y_test"], quiet = T))))
    
    ## Remove from ml.data the rows (if any) that contain at least one NA value
    ml.data <- ml.data[(rowSums(is.na(ml.data))) == 0,]
    
    ## Compute the feature averages for each combination of activity and subject
    ## We will use split and lapply functions:
    ## 1. Create the 'groups' list in which each element contains all the rows 
    ##    in the original data frame for a distinct combination of 
    ##    subject/activity values
    groups <- split(ml.data, list(ml.data$activity, ml.data$subject))
    ## 2. Apply 'colMeans' function to each element of the 'groups' list. The
    ##    result is a new list - 'agg.list'
    agg.list <- lapply(groups, colMeans)
    ## 3. Convert 'agg.list' list to a data frame - 'agg.ml.data - that contains 
    ##    one row for each distinct combination of subject/activity values
    agg.ml.data <- data.frame(matrix(unlist(agg.list), ncol = 68, byrow = T))
    ## 4. Set the column names of the aggregate data frame 
    ##    as 'mean(<original_column_name>)' except for the 'subject' 
    ##    and 'activity' columns
    names(agg.ml.data) <- ifelse(names(ml.data) == "activity" | 
                                     names(ml.data) == 'subject', 
                                 names(ml.data), 
                                 paste("mean_", names(ml.data), sep=""))
    
    ## Add a column labeled 'activity.label' to both data frames - ml.data and
    ## agg.ml.data and populate it with a replica of the 'activity' column
    ml.data <- cbind(ml.data, activity.label = ml.data$activity)
    agg.ml.data <- cbind(agg.ml.data, activity.label = agg.ml.data$activity)
    ## Now replace the values of the 'activity.label' column with the actual
    ## activity names from the 'activity_labels' data frame
    ml.data[,"activity.label"] <- activity_labels[ml.data[,"activity.label"],2]
    agg.ml.data[,"activity.label"] <- activity_labels[agg.ml.data[,"activity.label"],2]
    
    ## Write the summary data frame (the means) to a file on disk
    write.csv(agg.ml.data, file = data_files["out_csv"], quote = F, row.names = F)
    
    ## Return both data frames in a list
    list(data = ml.data, data.mean = agg.ml.data)
}

ml.data.list <- data_filter()