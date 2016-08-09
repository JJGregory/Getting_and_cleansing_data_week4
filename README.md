#Readme

Files included in this repo:

* CodeBook.md
  * Describes the data, variables, and transformations applied

* run_analysis.R

  1. Downloads the raw data.
  2. Merges the training and the test sets to create one data set.
  3. Extracts only the measurements on the mean and standard deviation for each measurement.
  4. Uses descriptive activity names to name the activities in the data set
  5. Appropriately labels the data set with descriptive variable names.
  6. From the data set in step 4, creates a second, independent tidy data set called tidyData.txt with the average of each variable for each activity and each subject.

* tidyData.txt
  * The output of run_analysis.R
