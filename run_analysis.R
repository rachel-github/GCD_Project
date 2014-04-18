
library(reshape)

# read the data from the .txt files
# ----------------------------------------------------------
activity.labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

x.test <- read.table("./test/X_test.txt")
y.test <- read.table("./test/y_test.txt")
subject.test <- read.table("./test/subject_test.txt")

x.train <- read.table("./train/X_train.txt")
y.train <- read.table("./train/y_train.txt")
subject.train <- read.table("./train/subject_train.txt")
# ----------------------------------------------------------


# merge test and training data into one data set
# ----------------------------------------------------------
data.test <- cbind(subject.test, y.test, x.test)
data.train <- cbind(subject.train, y.train, x.train)

data.all <- rbind(data.test, data.train)
# ----------------------------------------------------------


# label the columns with meaningful names
# ----------------------------------------------------------
names(data.all)[1:2] <- c("subject", "activity")
names(data.all)[3:length(data.all)] <- as.character(features[,2])
# ----------------------------------------------------------


# replace activity names with meaningful names
# ----------------------------------------------------------
data.all$activity <- factor(data.all$activity, levels = activity.labels[,1], 
                            labels=activity.labels[,2])
# ----------------------------------------------------------


# extract only measurements on mean and standard deviation of each measurement
# ----------------------------------------------------------
index.mean <- grep("-mean\\(\\)", names(data.all))
index.std <- grep("-std\\(\\)", names(data.all))

# first data set (containing the measurement means and standard deviation)
data.mean.std <- data.all[,c(1,2, index.mean,index.std)]
# ----------------------------------------------------------


# create the tidy data set containing the average of each variable
# ----------------------------------------------------------
data.molten <- melt(data.mean.std, id.vars=c("subject", "activity"))
data.varmeans <- cast(data.molten, subject + activity ~ variable, mean)


# output the tidy data set to file
# ----------------------------------------------------------
# write to .csv file
write.csv(data.varmeans, "tidydata.csv", row.names=F)

# (alternative format):  write to .txt file
write.table(data.varmeans, "tidydata.txt", row.names=F, quote=F)
# ----------------------------------------------------------
