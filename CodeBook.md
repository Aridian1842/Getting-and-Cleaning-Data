#Descriptions of the variables:

Subject: Each subject is identify by a number between 1 to 30
Activity: There are a total of 6 of them
  -LAYING            
  -SITTING           
  -STANDING            
  -WALKING WALKING_DOWNSTAIRS   
  -WALKING_UPSTAIRS 

#The rest of the variables

 The signals receive by the device were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

#The set of variables that were estimated from these signals are: 
mean(): Mean value
std(): Standard deviation

#Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

## CLEANING PROCESS

Below describes the steps to go through the process of understanding how the data was cleaning
and what kind of issues were treated

Step 1. Reading and Putting together all the test data. 

-Analize the code
-Note that reading using sep=" "
-all_test variable is a 2947x562 matrix containing all the test data
        
Step 2. Reading and Putting together all the train data.
-Reading as Step 1

Step 3. Merging the 2 data sets, train and test data using "rbind"
-all variable contain all the data merged
-Cleaning the memmory space except "all"

Step 4. Code for replacing activity labels for activity names
-Help by the "activity_labels.txt" file

Step 5. Looking for the columns that have standard deviation and mean
-use grep() function, returning an numeric vector with the desired text
-Sorting and saving in variable "c"
-Subsetting by c(1:2,c)

Step 6. Getting the mean of each SUBJECT+ACTIVITY+VARIABLE
-This is an idea that i have for ease the subsetting analisys. 
-I Paste "Subject"+"Activity" giving a new variable (id) that can be
 subsetting for analize.
-use by() to apply colMeans only to the numeric data, returning an list
-Extract element by element, transpose it,transform it as data frame, name it,bind it to his 
 correspondent new variable "id"

Step Final. Transform and separate column id 
-Using the names resulting by by() in the previous loop we need to
 separate the id column into subject and activity


