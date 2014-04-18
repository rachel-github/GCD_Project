Code Book for the *Getting and Cleaning Data* Course Project
------------------------------------------------------------

* * * * *

### Data set download

The data set used in this project came from the *Human Activity
Recognition Using Smartphones Dataset* downloaded from
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
on April 17, 2014.

The **README.txt** file included in the original data set describes the
following:

-   The experiment performed and methods used to collect the data.
-   The files included in the data set zip file
-   A description of how the data is organized in each file

### Data preprocessing

The following preprocessing steps were performed on the original data
set to produce the final tidy data set for this project.

1.  The activity labels, variable names, test set x values, test set y
    values, test set subject data, training set x values, training set y
    values, and training set subject data were read into R.

<!-- -->

    activity.labels <- read.table("activity_labels.txt")
    features <- read.table("features.txt")

    x.test <- read.table("./test/X_test.txt")
    y.test <- read.table("./test/y_test.txt")
    subject.test <- read.table("./test/subject_test.txt")

    x.train <- read.table("./train/X_train.txt")
    y.train <- read.table("./train/y_train.txt")
    subject.train <- read.table("./train/subject_train.txt")

1.  The subject data, X variable data (features data), and Y data
    (activity data) were combined in the test set and training set
    respectively.

<!-- -->

    data.test <- cbind(subject.test, y.test, x.test)
    data.train <- cbind(subject.train, y.train, x.train)

1.  Observations from the test set and the training set were merged into
    one data set.

<!-- -->

    data.all <- rbind(data.test, data.train)

1.  The columns of the merged data set were labelled with descriptive
    names.

<!-- -->

    names(data.all)[1:2] <- c("subject", "activity")
    names(data.all)[3:length(data.all)] <- as.character(features[,2])

1.  The values of the *activity* column were replaced with descriptive
    activity names.

<!-- -->

    data.all$activity <- factor(data.all$activity, levels = activity.labels[,1], 
                                labels=activity.labels[,2])

1.  Only the variables containing the mean and standard deviations of
    the measurements were included in tidy data set. In the features.txt
    file, these are the variables with either *mean()* or *std()* in
    their variable names.

<!-- -->

    index.mean <- grep("-mean\\(\\)", names(data.all))
    index.std <- grep("-std\\(\\)", names(data.all))

    data.mean.std <- data.all[,c(1,2, index.mean,index.std)]

1.  The final tidy data set was created with the average of each
    variable for each activity and each subject.

<!-- -->

    library(reshape)

    data.molten <- melt(data.mean.std, id.vars=c("subject", "activity"))
    data.varmeans <- cast(data.molten, subject + activity ~ variable, mean)

The structure of the final tidy data set is shown below:

    str(data.varmeans)

    ## List of 68
    ##  $ subject                    : int [1:180] 1 1 1 1 1 1 2 2 2 2 ...
    ##  $ activity                   : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
    ##  $ tBodyAcc-mean()-X          : num [1:180] 0.277 0.255 0.289 0.261 0.279 ...
    ##  $ tBodyAcc-mean()-Y          : num [1:180] -0.01738 -0.02395 -0.00992 -0.00131 -0.01614 ...
    ##  $ tBodyAcc-mean()-Z          : num [1:180] -0.1111 -0.0973 -0.1076 -0.1045 -0.1106 ...
    ##  $ tGravityAcc-mean()-X       : num [1:180] 0.935 0.893 0.932 0.832 0.943 ...
    ##  $ tGravityAcc-mean()-Y       : num [1:180] -0.282 -0.362 -0.267 0.204 -0.273 ...
    ##  $ tGravityAcc-mean()-Z       : num [1:180] -0.0681 -0.0754 -0.0621 0.332 0.0135 ...
    ##  $ tBodyAccJerk-mean()-X      : num [1:180] 0.074 0.1014 0.0542 0.0775 0.0754 ...
    ##  $ tBodyAccJerk-mean()-Y      : num [1:180] 0.028272 0.019486 0.02965 -0.000619 0.007976 ...
    ##  $ tBodyAccJerk-mean()-Z      : num [1:180] -0.00417 -0.04556 -0.01097 -0.00337 -0.00369 ...
    ##  $ tBodyGyro-mean()-X         : num [1:180] -0.0418 0.0505 -0.0351 -0.0454 -0.024 ...
    ##  $ tBodyGyro-mean()-Y         : num [1:180] -0.0695 -0.1662 -0.0909 -0.0919 -0.0594 ...
    ##  $ tBodyGyro-mean()-Z         : num [1:180] 0.0849 0.0584 0.0901 0.0629 0.0748 ...
    ##  $ tBodyGyroJerk-mean()-X     : num [1:180] -0.09 -0.1222 -0.074 -0.0937 -0.0996 ...
    ##  $ tBodyGyroJerk-mean()-Y     : num [1:180] -0.0398 -0.0421 -0.044 -0.0402 -0.0441 ...
    ##  $ tBodyGyroJerk-mean()-Z     : num [1:180] -0.0461 -0.0407 -0.027 -0.0467 -0.049 ...
    ##  $ tBodyAccMag-mean()         : num [1:180] -0.137 -0.1299 0.0272 -0.9485 -0.9843 ...
    ##  $ tGravityAccMag-mean()      : num [1:180] -0.137 -0.1299 0.0272 -0.9485 -0.9843 ...
    ##  $ tBodyAccJerkMag-mean()     : num [1:180] -0.1414 -0.4665 -0.0894 -0.9874 -0.9924 ...
    ##  $ tBodyGyroMag-mean()        : num [1:180] -0.161 -0.1267 -0.0757 -0.9309 -0.9765 ...
    ##  $ tBodyGyroJerkMag-mean()    : num [1:180] -0.299 -0.595 -0.295 -0.992 -0.995 ...
    ##  $ fBodyAcc-mean()-X          : num [1:180] -0.2028 -0.4043 0.0382 -0.9796 -0.9952 ...
    ##  $ fBodyAcc-mean()-Y          : num [1:180] 0.08971 -0.19098 0.00155 -0.94408 -0.97707 ...
    ##  $ fBodyAcc-mean()-Z          : num [1:180] -0.332 -0.433 -0.226 -0.959 -0.985 ...
    ##  $ fBodyAccJerk-mean()-X      : num [1:180] -0.1705 -0.4799 -0.0277 -0.9866 -0.9946 ...
    ##  $ fBodyAccJerk-mean()-Y      : num [1:180] -0.0352 -0.4134 -0.1287 -0.9816 -0.9854 ...
    ##  $ fBodyAccJerk-mean()-Z      : num [1:180] -0.469 -0.685 -0.288 -0.986 -0.991 ...
    ##  $ fBodyGyro-mean()-X         : num [1:180] -0.339 -0.493 -0.352 -0.976 -0.986 ...
    ##  $ fBodyGyro-mean()-Y         : num [1:180] -0.1031 -0.3195 -0.0557 -0.9758 -0.989 ...
    ##  $ fBodyGyro-mean()-Z         : num [1:180] -0.2559 -0.4536 -0.0319 -0.9513 -0.9808 ...
    ##  $ fBodyAccMag-mean()         : num [1:180] -0.1286 -0.3524 0.0966 -0.9478 -0.9854 ...
    ##  $ fBodyBodyAccJerkMag-mean() : num [1:180] -0.0571 -0.4427 0.0262 -0.9853 -0.9925 ...
    ##  $ fBodyBodyGyroMag-mean()    : num [1:180] -0.199 -0.326 -0.186 -0.958 -0.985 ...
    ##  $ fBodyBodyGyroJerkMag-mean(): num [1:180] -0.319 -0.635 -0.282 -0.99 -0.995 ...
    ##  $ tBodyAcc-std()-X           : num [1:180] -0.284 -0.355 0.03 -0.977 -0.996 ...
    ##  $ tBodyAcc-std()-Y           : num [1:180] 0.11446 -0.00232 -0.03194 -0.92262 -0.97319 ...
    ##  $ tBodyAcc-std()-Z           : num [1:180] -0.26 -0.0195 -0.2304 -0.9396 -0.9798 ...
    ##  $ tGravityAcc-std()-X        : num [1:180] -0.977 -0.956 -0.951 -0.968 -0.994 ...
    ##  $ tGravityAcc-std()-Y        : num [1:180] -0.971 -0.953 -0.937 -0.936 -0.981 ...
    ##  $ tGravityAcc-std()-Z        : num [1:180] -0.948 -0.912 -0.896 -0.949 -0.976 ...
    ##  $ tBodyAccJerk-std()-X       : num [1:180] -0.1136 -0.4468 -0.0123 -0.9864 -0.9946 ...
    ##  $ tBodyAccJerk-std()-Y       : num [1:180] 0.067 -0.378 -0.102 -0.981 -0.986 ...
    ##  $ tBodyAccJerk-std()-Z       : num [1:180] -0.503 -0.707 -0.346 -0.988 -0.992 ...
    ##  $ tBodyGyro-std()-X          : num [1:180] -0.474 -0.545 -0.458 -0.977 -0.987 ...
    ##  $ tBodyGyro-std()-Y          : num [1:180] -0.05461 0.00411 -0.12635 -0.96647 -0.98773 ...
    ##  $ tBodyGyro-std()-Z          : num [1:180] -0.344 -0.507 -0.125 -0.941 -0.981 ...
    ##  $ tBodyGyroJerk-std()-X      : num [1:180] -0.207 -0.615 -0.487 -0.992 -0.993 ...
    ##  $ tBodyGyroJerk-std()-Y      : num [1:180] -0.304 -0.602 -0.239 -0.99 -0.995 ...
    ##  $ tBodyGyroJerk-std()-Z      : num [1:180] -0.404 -0.606 -0.269 -0.988 -0.992 ...
    ##  $ tBodyAccMag-std()          : num [1:180] -0.2197 -0.325 0.0199 -0.9271 -0.9819 ...
    ##  $ tGravityAccMag-std()       : num [1:180] -0.2197 -0.325 0.0199 -0.9271 -0.9819 ...
    ##  $ tBodyAccJerkMag-std()      : num [1:180] -0.0745 -0.479 -0.0258 -0.9841 -0.9931 ...
    ##  $ tBodyGyroMag-std()         : num [1:180] -0.187 -0.149 -0.226 -0.935 -0.979 ...
    ##  $ tBodyGyroJerkMag-std()     : num [1:180] -0.325 -0.649 -0.307 -0.988 -0.995 ...
    ##  $ fBodyAcc-std()-X           : num [1:180] -0.3191 -0.3374 0.0243 -0.9764 -0.996 ...
    ##  $ fBodyAcc-std()-Y           : num [1:180] 0.056 0.0218 -0.113 -0.9173 -0.9723 ...
    ##  $ fBodyAcc-std()-Z           : num [1:180] -0.28 0.086 -0.298 -0.934 -0.978 ...
    ##  $ fBodyAccJerk-std()-X       : num [1:180] -0.1336 -0.4619 -0.0863 -0.9875 -0.9951 ...
    ##  $ fBodyAccJerk-std()-Y       : num [1:180] 0.107 -0.382 -0.135 -0.983 -0.987 ...
    ##  $ fBodyAccJerk-std()-Z       : num [1:180] -0.535 -0.726 -0.402 -0.988 -0.992 ...
    ##  $ fBodyGyro-std()-X          : num [1:180] -0.517 -0.566 -0.495 -0.978 -0.987 ...
    ##  $ fBodyGyro-std()-Y          : num [1:180] -0.0335 0.1515 -0.1814 -0.9623 -0.9871 ...
    ##  $ fBodyGyro-std()-Z          : num [1:180] -0.437 -0.572 -0.238 -0.944 -0.982 ...
    ##  $ fBodyAccMag-std()          : num [1:180] -0.398 -0.416 -0.187 -0.928 -0.982 ...
    ##  $ fBodyBodyAccJerkMag-std()  : num [1:180] -0.103 -0.533 -0.104 -0.982 -0.993 ...
    ##  $ fBodyBodyGyroMag-std()     : num [1:180] -0.321 -0.183 -0.398 -0.932 -0.978 ...
    ##  $ fBodyBodyGyroJerkMag-std() : num [1:180] -0.382 -0.694 -0.392 -0.987 -0.995 ...
    ##  - attr(*, "row.names")= int [1:180] 1 2 3 4 5 6 7 8 9 10 ...
    ##  - attr(*, "idvars")= chr [1:2] "subject" "activity"
    ##  - attr(*, "rdimnames")=List of 2
    ##   ..$ :'data.frame': 180 obs. of  2 variables:
    ##   .. ..$ subject : int [1:180] 1 1 1 1 1 1 2 2 2 2 ...
    ##   .. ..$ activity: Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
    ##   ..$ :'data.frame': 66 obs. of  1 variable:
    ##   .. ..$ variable: Factor w/ 66 levels "tBodyAcc-mean()-X",..: 1 2 3 4 5 6 7 8 9 10 ...

### ID variables

#### subject

-   **Description**: A number identifying the person who performed the
    activity
-   **Type**: integer
-   **Values**: 1 to 30

#### activity

-   **Description**: The activity performed by each subject
-   **Type**: enumerated type
-   **Values**:
    -   WALKING
    -   WALKING\_UPSTAIRS
    -   WALKING\_DOWNSTAIRS
    -   SITTING
    -   STANDING
    -   LAYING

### Measurement variables: Time domain signals

-   Time domain signals were captured at a constant rate of 50 Hz and
    then were filtered using a median filter and a 3rd order low pass
    Butterworth filter with a corner frequency of 20 Hz to remove noise.
-   The acceleration signal was then separated into body and gravity
    acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using
    another low pass Butterworth filter with a corner frequency of 0.3
    Hz.

#### tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z

-   **Description**: The *mean* values of the 3-axial signals in the X,
    Y, and Z directions for body acceleration
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyAcc-std()-X, tBodyAcc-std()-Y, tBodyAcc-std()-Z

-   **Description**: The *standard deviation* of the 3-axial signals in
    the X, Y, and Z directions for body acceleration
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tGravityAcc-mean()-X, tGravityAcc-mean()-Y, tGravityAcc-mean()-Z

-   **Description**: The *mean* values of the 3-axial signals in the X,
    Y, and Z directions for gravity acceleration
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tGravityAcc-std()-X, tGravityAcc-std()-Y, tGravityAcc-std()-Z

-   **Description**: The *standard deviation* of the 3-axial signals in
    the X, Y, and Z directions for gravity acceleration
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyAccJerk-mean()-X, tBodyAccJerk-mean()-Y, tBodyAccJerk-mean()-Z

-   **Description**: The *mean* values of the 3-axial signals in the X,
    Y, and Z directions for body acceleration jerk
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyAccJerk-std()-X, tBodyAccJerk-std()-Y, tBodyAccJerk-std()-Z

-   **Description**: The *standard deviation* of the 3-axial signals in
    the X, Y, and Z directions for body acceleration jerk
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyGyro-mean()-X, tBodyGyro-mean()-Y, tBodyGyro-mean()-Z

-   **Description**: The *mean* values of the 3-axial signals in the X,
    Y, and Z directions for body angular velocity
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyGyro-std()-X, tBodyGyro-std()-Y, tBodyGyro-std()-Z

-   **Description**: The *standard deviation* of the 3-axial signals in
    the X, Y, and Z directions for body angular velocity
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyGyroJerk-mean()-X, tBodyGyroJerk-mean()-Y, tBodyGyroJerk-mean()-Z

-   **Description**: The *mean* values of the 3-axial signals in the X,
    Y, and Z directions for body angular velocity jerk
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyGyroJerk-std()-X, tBodyGyroJerk-std()-Y, tBodyGyroJerk-std()-Z

-   **Description**: The *standard deviation* of the 3-axial signals in
    the X, Y, and Z directions for body angular velocity jerk
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyAccMag-mean()

-   **Description**: The *mean* magnitude value of the 3-dimensional
    body acceleration signals calculated using the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyAccMag-std()

-   **Description**: The *standard deviation* of the magnitude value of
    the 3-dimensional body acceleration signals calculated using the
    Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tGravityAccMag-mean()

-   **Description**: The *mean* magnitude value of the 3-dimensional
    gravity acceleration signals calculated using the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tGravityAccMag-std()

-   **Description**: The *standard deviation* of the magnitude value of
    the 3-dimensional gravity acceleration signals calculated using the
    Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyAccJerkMag-mean()

-   **Description**: The *mean* magnitude value of the 3-dimensional
    body acceleration jerk signals calculated using the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyAccJerkMag-std()

-   **Description**: The *standard deviation* of the magnitude value of
    the 3-dimensional body acceleration jerk signals calculated using
    the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyGyroMag-mean()

-   **Description**: The *mean* magnitude value of the 3-dimensional
    body angular velocity signals calculated using the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyGyroMag-std()

-   **Description**: The *standard deviation* of the magnitude value of
    the 3-dimensional body angular velocity signals calculated using the
    Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyGyroJerkMag-mean()

-   **Description**: The *mean* magnitude value of the 3-dimensional
    body angular velocity jerk signals calculated using the Euclidean
    norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### tBodyGyroJerkMag-std()

-   **Description**: The *standard deviation* of the magnitude value of
    the 3-dimensional body angular velocity jerk signals calculated
    using the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

### Measurement variables : Frequency domain signals

-   Frequency domain signals were produced by applying a Fast Fourier
    Transform (FFT) to some of the signals.

#### fBodyAcc-mean()-X, fBodyAcc-mean()-Y, fBodyAcc-mean()-Z

-   **Description**: The *mean* values of the 3-axial signals in the X,
    Y, and Z directions for body acceleration
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyAcc-std()-X, fBodyAcc-std()-Y, fBodyAcc-std()-Z

-   **Description**: The *standard deviation* of the 3-axial signals in
    the X, Y, and Z directions for body acceleration
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyAccJerk-mean()-X, fBodyAccJerk-mean()-Y, fBodyAccJerk-mean()-Z

-   **Description**: The *mean* values of the 3-axial signals in the X,
    Y, and Z directions for body acceleration jerk
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyAccJerk-std()-X, fBodyAccJerk-std()-Y, fBodyAccJerk-std()-Z

-   **Description**: The *standard deviation* of the 3-axial signals in
    the X, Y, and Z directions for body acceleration jerk
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyGyro-mean()-X, fBodyGyro-mean()-Y, fBodyGyro-mean()-Z

-   **Description**: The *mean* values of the 3-axial signals in the X,
    Y, and Z directions for body angular velocity
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyGyro-std()-X, fBodyGyro-std()-Y, fBodyGyro-std()-Z

-   **Description**: The *standard deviation* of the 3-axial signals in
    the X, Y, and Z directions for body angular velocity
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyAccMag-mean()

-   **Description**: The *mean* magnitude value of the 3-dimensional
    body acceleration signals calculated using the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyAccMag-std()

-   **Description**: The *standard deviation* of the magnitude value of
    the 3-dimensional body acceleration signals calculated using the
    Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyBodyAccJerkMag-mean()

-   **Description**: The *mean* magnitude value of the 3-dimensional
    body acceleration jerk signals calculated using the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyBodyAccJerkMag-std()

-   **Description**: The *standard deviation* of the magnitude value of
    the 3-dimensional body acceleration jerk signals calculated using
    the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyBodyGyroMag-mean()

-   **Description**: The *mean* magnitude value of the 3-dimensional
    body angular velocity signals calculated using the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyBodyGyroMag-std()

-   **Description**: The *standard deviation* of the magnitude value of
    the 3-dimensional body angular velocity signals calculated using the
    Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyBodyGyroJerkMag-mean()

-   **Description**: The *mean* magnitude value of the 3-dimensional
    body angular velocity jerk signals calculated using the Euclidean
    norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]

#### fBodyBodyGyroJerkMag-std()

-   **Description**: The *standard deviation* of the magnitude value of
    the 3-dimensional body angular velocity jerk signals calculated
    using the Euclidean norm
-   **Type**: numeric
-   **Values**: Values are normalized and bounded within [-1,1]
