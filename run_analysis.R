### This is a script for cleaning and tiding dataset of UCI HAR dataset.
# --- original dataset URL : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# PLEASE set the working directory as 'setwd(UNZIPPED UCI HAR dataset PATH HERE)'.

#### Instruction
# 0. After loading required libraries , cleaning global enviroment is performed.
# 1. All the 10,299 observations from training and test directory is merged into one dataframe.
# 2. Only the mean and standard deviation for each measurement is extracted.
# 3. The type of activity is changed as more descriptive names in the dataset of 2.
# 4. The labels of extracted dataset is changed as being more descriptive.
# 5. The independent tidy data set with the average of each variable for each activity and each subject is written in 'harus_tidy2.txt'.


# 0. Cleaning enviroments
# --- It is recommended to execute 'install.packages("LIBRARY NAME HERE") in the library() before running the script.
# Patching libraries
library(data.table)
library(magrittr)
library(plyr)
library(dplyr)
library(reshape2)


# Cleaning the variable names, just in case.
if (any(c("dataset", "datasety", "subject_data", "extract_data") %in% ls())){
  rm(list=c("dataset", "datasety", "subject_data", "extract_data"))  
}

#1. merges the training and test dataset WITHOUT losing information of directory structure of the original dataset.
# --- The information of directory structure of the downloaded UCI HAR dataset will be kept in the script.
# Therefore, it isnt' necessary to change anything AFTER unzipping the downloaded UCI HAR dataset.
# The performance of this script,However, is not efficiently optimized for saving the directory structure info.


file_list <- list.files(recursive =TRUE)
for (file_name in file_list){
  if ((length(strsplit(file_name, split="/")[[1]]) == 2) && (strsplit(file_name, split="/")[[1]][[2]] =='X_test.txt' || strsplit(file_name, split="/")[[1]][[2]] =='X_train.txt')){
    
    
    if (!exists("dataset")){
      dataset <- read.table(file_name, header=FALSE)
      
    }
    
    # if the merged dataset does exist, append to it
    else if (exists("dataset")){
      temp_dataset <-read.table(file_name, header=FALSE)
      dataset<-rbind(dataset, temp_dataset)
      rm(temp_dataset)
    }
  }
  else if ((length(strsplit(file_name, split="/")[[1]]) == 2) && (strsplit(file_name, split="/")[[1]][[2]] =='y_test.txt' || strsplit(file_name, split="/")[[1]][[2]] =='y_train.txt')){
    if (!exists("datasety")){
      datasety <- read.table(file_name, header=FALSE)
      
    }
    
    # if the merged dataset does exist, append to it
    else if (exists("datasety")){
      temp_datasety <-read.table(file_name, header=FALSE)
      datasety<-rbind(datasety, temp_datasety)
      rm(temp_datasety)
    }
  }  
  else if ((length(strsplit(file_name, split="/")[[1]]) == 2) && (strsplit(file_name, split="/")[[1]][[2]] =='subject_train.txt' ||strsplit(file_name, split="/")[[1]][[2]] =='subject_test.txt' )){
    if (!exists("subject_data")){
      subject_data <- read.table(file_name, header=FALSE)
      
    }
    
    # if the merged dataset does exist, append to it
    else if (exists("subject_data")){
      
      temp_subject_data <-read.table(file_name, header=FALSE)
      subject_data<-rbind(subject_data, temp_subject_data)
      rm(temp_subject_data)
    }
  }  
}

#PART of 4. ADD descriptive variable names from 'feature.txt' 
#to X (observed dataset)
feature_name <- read.table("./features.txt", header=FALSE, sep=" ")
data_all <- cbind(dataset, datasety, subject_data)
colnames(data_all) <-c(t(feature_name[2]), "activity_type", "subject_ID")


#2. Extract only the measurements of the mean and SD
#AND 3. Uses descriptive activity names for ACTIVITY TYPE

names_list <- names(data_all)

for (name_item in names_list){
  if((length(strsplit(name_item, split="-")[[1]]) >= 2) && (strsplit(name_item, split="-")[[1]][[2]] == 'mean()' || strsplit(name_item, split="-")[[1]][[2]] == 'std()')){
    selected_item <- match(name_item, names_list)
    if (!exists("extract_data")){
      desc_Factor <-factor(data_all[["activity_type"]], levels=c(1:6),labels=c("WALKING" , "WALKING_UPSTAIRS" , "WALKING_DOWNSTAIRS" , "SITTING" , "STANDING" , "LAYING"))
      extract_data <- data.frame( subject_ID =factor(data_all[["subject_ID"]]), activity_type= desc_Factor, data_all[selected_item])      
    }
    else if (exists("extract_data")){
      extract_data <- cbind(extract_data, data_all[selected_item])      
    } 
  }
  
}


#4. Label descriptive variable names to the tidy dataset

names(extract_data)<-gsub("(?<![a-zA-Z0-9])t(?!y)", "mean-time-by(act,sub)-", names(extract_data), perl=TRUE)
names(extract_data) <-gsub("f", "mean-freq-by(act,sub)-", names(extract_data), perl=TRUE)


#5. Create the second, independent tidy data set with the average of each
#   variable for each activity and each subject

#group mean by activity type AND subject ID
tidy21<-aggregate(extract_data[, 3:68], list(activity_type=extract_data$activity_type, subject_ID=extract_data$subject_ID), mean)
write.table(tidy21, file="./harus_tidy2.txt", sep="\t", row.names=FALSE, col.names=TRUE, quote=FALSE)
