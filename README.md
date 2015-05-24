### This is a script for cleaning and tiding dataset of UCI HAR dataset.
original dataset URL : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
PLEASE set the working directory as 'setwd(UNZIPPED UCI HAR dataset PATH HERE)'.

### Instruction
0. After loading required libraries , cleaning global enviroment is performed.
 It is recommended to execute 'install.packages("LIBRARY NAME HERE") in the library() before running the script.

1. All the 10,299 observations from training and test directory is merged into one dataframe.
 The information of directory structure of the downloaded UCI HAR dataset will be kept in the script.
 Therefore, it isnt' necessary to change anything AFTER unzipping the downloaded UCI HAR dataset.
 The performance of this script,However, is not efficiently optimized for saving the directory structure info. 

2. Only the mean and standard deviation for each measurement is extracted.
3. The type of activity is changed as more descriptive names in the dataset of 2.
4. The labels of extracted dataset is changed as being more descriptive.
5. The independent tidy data set with the average of each variable for each activity and each subject is written in 'harus_tidy2.txt'.

