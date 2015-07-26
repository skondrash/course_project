Input file - "getdata-projectfiles-UCI HAR Dataset.zip" - file with all initial datasets.
This file is unzipped into folder "UCI HAR Dataset". All later meant paths are written without this folder name ("./UCI HAR Dataset/....")

Initial datasets:
1. Test datasets - are in the "test" folder. Contains 3 files - "test/X_test.txt" (records), "test/y_test.txt" (activity number by record), 
"test/subject_test.txt" (subject numbers).
2. Train datasets - are in "train" folder. Contains 3 files - "train/X_train.txt" (records), "train/y_train.txt" (activity number by record), 
"train/subject_train.txt" (subject numbers).
3. "features.txt" - names of records
4. "activity_labels.txt" - table, corresponding activity number with activity name

Output file - "result_table.txt"

Calculation steps:
1. Unziping file with initial datasets
2. Extracting data from initial datasets (records, activity numbers, subject numbers - each for test and train data, also names of records and activity names)
3. Renaming variables of person number and activity number in initial datasets
4. Creating records datasets with picked data - with mean and std data
5. Combining record datasets with activity numbers and subject numbers datasets
6. Combining test and train data
7. Inserting activity names (by merging with activity names dataset)
8. Groupping by activity names and person number, creating summarizing table with mean values
9. Writing into output file

Variables:
1. "variables" - dataset from "features.txt"
2. "activity_labels":
initially - dataset from "activity_labels.txt"
on second step - same dataset, but with renamed variables ("activity" instead of "V1" and "activity_label" instead of "V2")
3. "x_test":
initially - dataset from "test/X_test.txt"
on second step - same dataset, but variable names are inserted from second column of "variables"
4. "y_test":
initially - dataset from "test/y_test.txt"
on second step - same dataset, but with renamed variable name ("activity" instead of "V1")
5. "subject_test":
initially - dataset from "test/subject_test.txt"
on second step - same dataset, but with renamed variable name ("person" instead of "V1")
6. "x_train":
initially - dataset from "train/X_train.txt"
on second step - same dataset, but variable names are inserted from second column of "variables"
7. "y_train":
initially - dataset from "train/y_train.txt"
on second step - same dataset, but with renamed variable name ("activity" instead of "V1")
8. "subject_train":
initially - dataset from "train/subject_train.txt"
on second step - same dataset, but with renamed variable name ("person" instead of "V1")
9."x_test_picked" - dataset, picked from "x_test", including only mean and std variables (in 2 steps - firstly, pick variables containing "mean" 
or "std", secondly - excluding variables containing "Freq" to exclude Freqmean variables)
10. "x_train_picked" - dataset, picked from "x_train", including only mean and std variables (in 2 steps - firstly, pick variables containing "mean" 
or "std", secondly - excluding variables containing "Freq" to exclude Freqmean variables)
11. "test_picked" - dataset, combining "x_test_picked", "y_test", "subject_test"
12. "train_picked" - dataset, combining "x_train_picked", "y_train", "subject_train"
13. "dataset_picked":
initially - row-binded datasets "test_picked" and "dataset_picked"
on second step - itself but merged with dataset "activity_labels" (by variable "activity")
14. "dataset_picked_groupped" - "dataset_picked" dataset, groupped by variables "activity label" and "person"
15. "result_dataset" (written into output file) - summarized dataset from "dataset_picked_groupped": mean values of all variables by "activity label" and "person"