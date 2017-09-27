#####                   run_analysis.R 
#####       for Coursera Getting and Cleaning Data
#####                   Course project


# load nessesary packages
if ('plyr' %in% installed.packages()[, 1]) {
  require('plyr')
} else {
  install.packages('plyr')
  require('plyr')
}


## Download the data
data_URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

download.file(url = data_URL,
              destfile = './data_4_analysis.zip',
              method = 'curl')

## Unzip it and go to folder
unzip('./data_4_analysis.zip')
setwd('./UCI HAR Dataset/')


##### ##### 
##### ##### STEP 1 (Merge training and test sets)
training <- read.table('./train/X_train.txt') 
test <- read.table('./test/X_test.txt')

all_data <- rbind(training, test)


##### ##### 
##### ##### STEP 2 (Extract only mean and standard deviation 
##### #####         for each measurement)

# Read in features file
feats  <- read.table('features.txt', 
                     colClasses = c('numeric', 
                                    'character'), 
                     col.names = c('row', 
                                   'features'))
# Extract mean and std measures (mean() and std() in file)
feats_2_keep <- grep('(mean|std)\\(\\)', 
                     feats$features)


##### ##### 
##### ##### STEP 3 (Uses descriptive activity names to 
##### #####         name the activities in the data set)


# Read in activity files and merge them
training_labs <- read.table('./train/y_train.txt', col.names = c('labs'))
test_labs <- read.table('./test/y_test.txt', col.names = c('labs'))
labs <- rbind(training_labs, test_labs)

# Read in cativity labels
activity_labs <- read.table('activity_labels.txt',
                            colClasses = c('numeric', 
                                           'character'), 
                            col.names = c('code', 
                                          'activity'))

# Match activity values with activity names
labs$activity <- activity_labs[match(labs$labs, activity_labs$code), 2]


##### ##### 
##### ##### STEP 4 (Appropriately labels the data set with 
##### #####         descriptive variable names)

# Get the desired measures
all_data <- all_data[, feats_2_keep]

# Create appropiate and descriptive variable names
feats[feats_2_keep, 2] <- gsub('-mean\\(\\)-|-mean\\(\\)', 'Mean', feats[feats_2_keep, 2])
feats[feats_2_keep, 2] <- gsub('-std\\(\\)-|-std\\(\\)', 'StandardDeviation', feats[feats_2_keep, 2])
feats[feats_2_keep, 2] <- gsub('^t', 'Time', feats[feats_2_keep, 2])
feats[feats_2_keep, 2] <- gsub('^f', 'Freq', feats[feats_2_keep, 2])
feats[feats_2_keep, 2] <- gsub('Acc', 'Acceleration', feats[feats_2_keep, 2])
feats[feats_2_keep, 2] <- gsub('Mag', 'Magnitude', feats[feats_2_keep, 2])
feats[feats_2_keep, 2] <- gsub('BodyBody', 'Body', feats[feats_2_keep, 2]) #Correcting some typos

# Update variable names
colnames(all_data) <- feats[feats_2_keep, 2]


##### ##### 
##### ##### STEP 5 (Create second, independent tidy data set  
##### #####         with average variables activity and subject)

# Get training and test subjects
training_subj <- read.table('./train/subject_train.txt', col.names = c('subject'))
test_subj <- read.table('./test/subject_test.txt', col.names = c('subject'))
subjects <- rbind(training_subj, test_subj)

# Update data set wich subject ID and activity labels
all_data <- cbind(subjects, labs[, 2], all_data)
colnames(all_data)[2] <- 'activity'



##### Create tidy data set
tidy_data <- ddply(all_data, 
                   .(subject, activity), 
                   function(x){
                     colMeans(x[, 3:68])
                     }
                   )

#write.table(tidy_data, './new_data_tidy.txt', row.names = F, sep = '\t')