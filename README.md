This script ("run_analysis.R") uses the data from wearing devices from source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

It does the following:
1) merges 2 datasets from this source ("train" and "test")
2) adds descriptive variable names and activity names 
3) extracts only mean and std variables from dataset
4) calculates mean values of extracted variables, groupped by person number and activity type
5) writes the result into file "result_table.txt"
