## CODEBOOK for HARUS tidy dataset#

###1. Data Collection Description##
The dataset has 180 mean variables of selected mean and standard deviation of varaibles in UCI HAR(Human Activity Recognition Using Smartphones Dataset Version 1.0) dataset (10,299 observations of 563 variables). 
The original dataset has records of a group of 30 volunteers within an age of [19-48]. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist (URL : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

###2.The number of variables : 68

###3. Number of units(observations): 180

###4. Column locations for each variables
|  #Column  | data type  | missing value  |value range  |
|---|---|---|---|
|  1 |  factor  |  None | WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING  |
| 2  |  factor  | None  | 1-30  |
|  3~68 |  signed numeric   | None  |[-1, 1] |

###5. Names of the variables
Regarding the readable length of a variable name, the most part of each variable name could be regarded as being well-structured and self-explantory except 'f', or 't' note. The 'f' is replaced as 'freq', therefore, and 't' is replaced by 'time'  
And, as all the numeric variables in the new tidy dataset ('hus_tidy.txt') is the mean value for each activity and each subject, the notation of 'mean(act, sub)-' is added.

* mean-freq(act, sub) : Group Mean frequency by each activity type and subject ID
* mean-time(act, sub) : Group Mean time by each activity type and subject ID
* Body : Body motion information
* Gravity : Gravity information
* Gyro : Angular information
* Acc : Acceleration
* Mag : Magnitude
* Jerk : Deviation of acceleration with time
* X,Y,Z : Axis in 3-Dimensions
* mean : Mean
* sd : Standard deviation  

For example, 'mean-time-by(act,sub)-GravityAcc-mean()-Y' means mean time by each activity type and subject ID calculated by using Gravity Acceleration mean of Y axis' and this description is equivalent.
 



