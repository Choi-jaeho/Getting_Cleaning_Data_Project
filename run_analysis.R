## step 1

d_subject_test <- read.table(".//UCI HAR Dataset//test//subject_test.txt")
d_X_test <- read.table(".//UCI HAR Dataset//test//X_test.txt")
d_y_test <- read.table(".//UCI HAR Dataset//test//y_test.txt")

d_subject_train <- read.table(".//UCI HAR Dataset//train//subject_train.txt")
d_X_train <- read.table(".//UCI HAR Dataset//train//X_train.txt")
d_y_train <- read.table(".//UCI HAR Dataset//train//y_train.txt")

merged_test <- cbind(d_subject_test, d_X_test, d_y_test)
merged_traing <- cbind(d_subject_train, d_X_train, d_y_train)
merged_total <- rbind(merged_test, merged_traing)

## step 2

d_features <- read.table(".//UCI HAR Dataset//features.txt", col.names = c("code", "feature"), stringsAsFactors = F)

names_merged_total <- c("subject", d_features$feature, "activity_code")
names(merged_total) <- names_merged_total


# index which contains character string "mean" in the column name
measure_mean <- grep("mean", names(merged_total), ignore.case = TRUE)
# index which contains character string "std" in the column name
measure_sd <- grep("std", names(merged_total), ignore.case = TRUE)
# index which contains character string "mean" or "std"
measure_mean_sd <- c(measure_mean, measure_sd)

# data frame with measurements on the mean and standard deviation
d_measure_mean_sd <- merged_total[, measure_mean_sd]


## step 3

d_activity_labels <- read.table(".//UCI HAR Dataset//activity_labels.txt",  col.names = c("activity_code", "activity_name"), stringsAsFactors = F)
# str(d_activity_labels)
str(merged_total[, 1:4])
merged_total_descriptive <- merge(merged_total, d_activity_labels, by="activity_code")

## step 4
## merged_total_desciptive data set is already labeled
## So no extra code for step 4

## step 5
second_dataset <- aggregate(.~ subject + activity_code, data = merged_total_descriptive[1:563], mean)
dim(second_dataset)

## save the result
write.table(second_dataset,".//output.txt", row.names = FALSE)

? write.table
