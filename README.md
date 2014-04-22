Getting and Cleaning Data Project
===========

This repository contains the files for the peer-reviewed project 
of the Getting and Cleaning Data class on Coursera.

###Data files (Original/raw data set)
- **README.txt**  

    The readme file accompanying the original data set downloaded from 
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  
    Among others, it describes how the data was obtain and how the data is organized 
    in the files included in the data set.  
    
- **features_info.txt**  

    Contains information about the variables used on the feature vector  
    
- **features.txt**  

    Contains the list of all features  
    
- **activity_labels.txt**  

    Links the activity name with their integer value equivalents  
    
- **train/X_train.txt**  

    Contains the training set feature values  
    
- **train/y_train.txt**  

    Contains the training labels (activity integer values corresponding to each observation 
    in the training set)
    
- **train/subject_train.txt**  

    Contains the data identifying the subject corresponding to each observation
    in the training set
    
- **test/X_test.txt**  

    Contains the test set feature values
    
- **test/y_test.txt**  

    Contains the test labels (activity integer values corresponding to each observation 
    in the test set)
    
- **test/subject_test.txt**  

    Contains the data identifying the subject corresponding to each observation
    in the test set

*Note*:  
    The data files contained in the **Inertial Signals** directory of the
    training set and test set were not included in the data preprocessing done
    in this project.


###R script file

- **run_analysis.R**  

    This R script is provided for reproducibility of the preprocessing steps done
    on the original data set.  It assumes that the data files described in the
    **Data files** section above have already been extracted from the .zip file 
    and placed in the R working directory.  
    
    The code in the script performs the following processing steps:  
    
    1. Reading the data from the .txt files into R
    
    2. Merging the feature values, labels, and subject data to create the
       *training* set data frame
       
    3. Merging the feature values, labels, and subject data to create the
       *test* set data frame
       
    4. Merging the training set and test set into one data frame
    
    5. Replacing the activity integer values with the activity labels
    
    6. Extracting a subset of the data containing only the variables representing
       the mean and standard deviation measurements
       
    7. Fixing the variable names to remove dashes, parentheses, and duplicated
       substrings.
       
    7. Creating a tidy data set containing the average of each variable for each
       activity and subject

###CodeBook file
- **CodeBook.md**

     This code book markdown file describes where and when the original data set
     was downloaded, what preprocessing steps were done to produce
     the final tidy data set, and what variables are included in that final data set.
