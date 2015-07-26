library(dplyr)
if(file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")   # unzip file, if necessary
}
variables<-read.table("./UCI HAR Dataset/features.txt") #read variables names
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt") #read activities names

# block of reading test data, renaming column names of person number and activity
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
names(x_test)<-variables$V2
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
y_test<-rename(y_test,activity=V1)
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_test<-rename(subject_test,person=V1)

# block of reading test data, renaming column names of person number and activity
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
names(x_train)<-variables$V2
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
y_train<-rename(y_train,activity=V1)
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_train<-rename(subject_train,person=V1)

# block of picking mean and std data (excluded "Freq" - excluded meanFreq data)
x_test_picked<-x_test[grep("mean|std",colnames(x_test))]
x_test_picked<-x_test_picked[grep("Freq",colnames(x_test_picked),invert=TRUE)]
x_train_picked<-x_train[grep("mean|std",colnames(x_train))]
x_train_picked<-x_train_picked[grep("Freq",colnames(x_train_picked),invert=TRUE)]

# block of including activity number, person number and combining test and train datasets
test_picked<-cbind(x_test_picked,y_test,subject_test)
train_picked<-cbind(x_train_picked,y_train,subject_train)
dataset_picked<-rbind(test_picked,train_picked)
activity_labels<-rename(activity_labels,activity=V1)
activity_labels<-rename(activity_labels,activity_label=V2)

dataset_picked<-merge(dataset_picked,activity_labels,by="activity") #inserting activity names

# block of calculating mean values by activity and by people
dataset_picked_groupped<-group_by(dataset_picked,activity_label,person)
result_dataset<-summarise_each(dataset_picked_groupped,funs(mean))

# block of writing into file
if (!file.exists("result_table.txt")) {
  file.create("result_table.txt")
}
write.table(result_dataset,file="result_table.txt",row.names=FALSE)