# Code Book for Corusera Getting and Cleaning Data Course Project by John Hopkins University

This Code Book describes the variables, the data, and any transformations or work that you performed to clean up the data originally retrieved from [UCI's Machine Learing Repository Site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The resulting tidy data set can be found in the file `new_data_tidy.txt` on this repository.


## Original Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


## Values and Variables in `new_data_tidy.txt`

The data set cosists of 180 rows (six activities for each of the 30 subjects) and 68 colums (i.e., variables).

The variable `subject` provides a subject identifier (i.e. integer, 1:30)
The variable `activity` describes whether the measure was obtained while the volunteer was `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, or `LAYING` (i.e., factor with 6 levels)

Variables 3 to 68 (all of class `numeric`) represent 'Mean' and 'StardardDeviation' measures of either time (prefixed `Time` to denote them) or frequency (prefixed `Freq` to denote them) signals, averaged for each activity and each subject independetly.

The features selected for this database come from the accelerometer (`Acceleration` variables) and gyroscope (`Gyro` variables) 3-axial raw signals (suffixed `X`,`Y`, or `Z`).
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (`Jerk` variables). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (`Magnitude` variables). 


## Transformations performed to original data 

The code comprised in `run_analysis.R` begins by requiring the R-package `plyr`, dowloading and unzing the data set nessesary for the geration of `new_data_tidy.txt`.

- Step 1: Merges the training and the test sets to create one data set.
- Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
- Step 3: Uses descriptive activity names to name the activities in the data set.
- Step 4: Appropriately labels the data set with descriptive variable names.
- Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


