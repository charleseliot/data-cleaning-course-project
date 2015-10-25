---
title: "CodeBook.MD"
author: "Charles Eliot"
date: "October 25, 2015"
output: html_document
---

## Study Design

Information about the original experimental design and data gathering is in the README.txt file of the downleaded data set.

### Activities

Downloaded raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on 10/7/2015

Extracted zip file and used top-level directory for working directory

UCI HAR Dataset  <<< The analysis code assumes that this is the working directory  
  |  
  |-- test  
  |  
  |-- train  
  
Investigated the various file formats (HexEdit is a very useful tool for this)

- features.txt is an LF-delimited list of 561 feature names. Each line consists of an ID value and the name of the feature, separated by white space. These will become column IDs in our tidy data set. features_info.txt gives more information about the variables.

- activity\_labels.txt is an LF-delimited list of activity names ("WALKING", "SITTING", etc). Each line consists of an ID value and the name of the activity separated by white space. Activities are identified in the observational data by the activity ID, so the data from activity_labels.txt will be used to replace activity IDs with more descriptive activity names in our tidy data set.

- test\\X\_test.txt and train\\X\_train.txt are LF-delimited lists of observations. Each line consists of 561 values separated by white space. The 561 variables map to the features listed in features.txt. These data will be combined in our final tidy data set.

- test\\subject\_test.txt and train\\subject\_train.txt are LF-delimited lists of subject IDs in text format ("1", "2", etc). Each line corresponds to one of the observations in X\_test.txt or X\_train.txt respectively. Sanity check: nrow(subject\_train) == nrow(X\_train), and nrow(subject\_test) == nrow(X\_test).

- README.txt gives information about the experimental design and execution, and describes the data files.

### Data Cleaning Script

script = run_analysis.R

cleaning function = clean()  
analysis function = grouped.means()  

```{r}
clean <- function(directory=".\\"){
# Input:
#   directory - location of the HAR raw data. Default = current working directory.
# Output:
#   data frame with the ungrouped tidy data set

...
}
```

```{r}
grouped.means <- function(df=data.frame()){
# Input:
#   df - ungrouped data, as returned by clean()
# Output:
#   data frame with data grouped by activity and subject, aggregated as means 

...
}
```
Default actions when the run_analysis.R script is sourced:

```{r}
full.data <- clean()
grouped.data <- grouped.means()
write.table(grouped.data, file="grouped_data.txt", row.name=FALSE)
```

### Variable Names

Variable names for observed values are derived from the features.txt file. Only variables containing either "mean()" or "std()" are kept, corresponding to the mean and standard deviation of values computed from the 128-sample inertial signal windows. (The filtering also excludes variables with "meanFreq()" in the name. "meanFreq" variables are not simple means; they are weighted averages from the frequency (FFT) domain, intended to convey the dominant frequency of a sample.)

Recipe for forming variable names:  

- Extract 561 raw variable names from features.txt  
- Filter for variables names containing either "mean()" or "std()", resulting in 66 variables  
- Remove "()" substrings  
- If the variable name begins with "f" (for frequency domain), insert "Freq" before the first dash  
- Remove the first letter (either "f" or "t")  
- Convert to lower case  
- Convert dashes to underscores  
- Convert "bodybody" to "body" (to correct a minor irritant in the original names)  

Samples:

tBodyAcc-std()-Y --> tbodyacc\_std\_y  
fBodyGyro-std()-X --> bodygyrofreq\_std\_z  
fBodyBodyGyroJerkMag-mean() --> bodygyrojerkmagfreq\_mean  

Note: including underscores departs slightly from the group standard, but is done to separate the syntactically important sub-elements of the variable name - measurement / processing / axis. Elements of the measurement could have been further expanded - "acc" to "acceleration", "gyro" to "gyroscope" - but at the risk of making names that were already getting long and hard to read even more so. 

## Code Book

Column # | Variable Name        | Description
---------|----------------------|------------
1        | subject              | Experimental subject's ID number  
2        | activity             | Experimental activity  
3        | bodyacc\_mean\_x     | Columns 3-68 are derived from the feature names in features.txt. The conversion algorithm is described above. Refer to features_info.txt for more details about what each variable represents.
4        | bodyacc\_mean\_y     |  
5        | bodyacc\_mean\_z     |   
6        | bodyacc\_std\_x      |  
7        | bodyacc\_std\_y      |  
8        | bodyacc\_std\_z  
9        | gravityacc\_mean\_x  
10       | gravityacc\_mean\_y  
11       | gravityacc\_mean\_z  
12       | gravityacc\_std\_x  
13       | gravityacc\_std\_y  
14       | gravityacc\_std\_z  
15       | bodyaccjerk\_mean\_x  
16       | bodyaccjerk\_mean\_y  
17       | bodyaccjerk\_mean\_z  
18       | bodyaccjerk\_std\_x  
19       | bodyaccjerk\_std\_y  
20       | bodyaccjerk\_std\_z  
21       | bodygyro\_mean\_x  
22       | bodygyro\_mean\_y  
23       | bodygyro\_mean\_z  
24       | bodygyro\_std\_x  
25       | bodygyro\_std\_y  
26       | bodygyro\_std\_z  
27       | bodygyrojerk\_mean\_x  
28       | bodygyrojerk\_mean\_y  
29       | bodygyrojerk\_mean\_z  
30       | bodygyrojerk\_std\_x  
31       | bodygyrojerk\_std\_y  
32       | bodygyrojerk\_std\_z  
33       | bodyaccmag\_mean  
34       | bodyaccmag\_std  
35       | gravityaccmag\_mean  
36       | gravityaccmag\_std  
37       | bodyaccjerkmag\_mean  
38       | bodyaccjerkmag\_std  
39       | bodygyromag\_mean  
40       | bodygyromag\_std  
41       | bodygyrojerkmag\_mean  
42       | bodygyrojerkmag\_std  
43       | bodyaccfreq\_mean\_x  
44       | bodyaccfreq\_mean\_y  
45       | bodyaccfreq\_mean\_z  
46       | bodyaccfreq\_std\_x  
47       | bodyaccfreq\_std\_y  
48       | bodyaccfreq\_std\_z  
49       | bodyaccjerkfreq\_mean\_x  
50       | bodyaccjerkfreq\_mean\_y  
51       | bodyaccjerkfreq\_mean\_z  
52       | bodyaccjerkfreq\_std\_x  
53       | bodyaccjerkfreq\_std\_y  
54       | bodyaccjerkfreq\_std\_z  
55       | bodygyrofreq\_mean\_x  
56       | bodygyrofreq\_mean\_y  
57       | bodygyrofreq\_mean\_z  
58       | bodygyrofreq\_std\_x  
59       | bodygyrofreq\_std\_y  
60       | bodygyrofreq\_std\_z  
61       | bodyaccmagfreq\_mean  
62       | bodyaccmagfreq\_std  
63       | bodyaccjerkmagfreq\_mean  
64       | bodyaccjerkmagfreq\_std  
65       | bodygyromagfreq\_mean  
66       | bodygyromagfreq\_std  
67       | bodygyrojerkmagfreq\_mean  
68       | bodygyrojerkmagfreq\_std  

