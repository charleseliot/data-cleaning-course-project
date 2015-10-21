---
title: "CodeBook.MD"
author: "Charles Eliot"
date: "October 17, 2015"
output: html_document
---

### Activities

Downloaded raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on 10/7/2015

Extracted zip file to RawData sub-directory

Investigated the various file formats (HexEdit is a very useful tool for this)

- features.txt is an LF-delimited list of 561 feature names. Each line consists of an ID value and the name of the feature, separated by white space. These will become column IDs in our tidy data set. features_info.txt gives more information about the variables.

- activity\_labels.txt is an LF-delimited list of activity names ("WALKING", "SITTING", etc). Each line consists of an ID value and the name of the activity separated by white space. Activities are identified in the observational data by the activity ID, so the data from activity_labels.txt will be used to replace activity IDs with more descriptive activity names in our tidy data set.

- test\\X\_test.txt and train\\X\_train.txt are LF-delimited lists of observations. Each line consists of 561 values separated by white space. The 561 variables map to the features listed in features.txt. These data will be combined in our final tidy data set.

- test\\subject\_test.txt and train\\subject\_train.txt are LF-delimited lists of subject IDs in text format ("1", "2", etc). Each line corresponds to one of the observations in X\_test.txt or X\_train.txt respectively. Sanity check: nrow(subject\_train) == nrow(X\_train), and nrow(subject\_test) == nrow(X\_test).

- README.txt gives information about the experimental design and execution, and describes the data files.

### Data Cleaning Script

script = run_analysis.R   
cleaning function = Clean()  

```{r}
Clean <- function(directory=".\\"){
# Input:
#   directory - location of the HAR raw data. Default = current working directory.
# Output:
#   data frame with the tidy data set

.
.
.
}
```

### Variable Names

Variable names for observed values are derived from the features.txt file. Only variables containing either "mean()" or "std()" are kept, corresponding to the mean and standard deviation of values computed from the 128-sample inertial signal windows. (The filtering excludes variables with "meanFreq()" in the name. "meanFreq" variables are not simple means; they are weighted averages from the frequency (FFT) domain intended to convey the dominant frequency of a sample.)

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

Note: including underscores departs slightly from the class standard, but is done to separate the syntactically important sub-elements of the variable name - measurement / processing / axis. Elements of the measurement could have been further expanded - "acc" to "acceleration", "gyro" to "gyroscope" - but at the risk of making names that were already getting long and hard to read even more so. 

### Final Variable Set

Column # | Column Name          | Description
---------|----------------------|------------
1        | subjectid            | Experimental subject's ID number  
2        | activityname         | Experimental activity  
3        | experimenttype       | TRAINING or TRIAL
4        | bodyacc\_mean\_x     | Columns 4-69 are derived from the feature names in features.txt. The conversion algorithm is described above. Refer to features_info.txt for more details about what each variable represents.
5        | bodyacc\_mean\_y     |  
6        | bodyacc\_mean\_z     |   
7        | bodyacc\_std\_x      |  
8        | bodyacc\_std\_y      |  
9        | bodyacc\_std\_z  
10       | gravityacc\_mean\_x  
11       | gravityacc\_mean\_y  
12       | gravityacc\_mean\_z  
13       | gravityacc\_std\_x  
14       | gravityacc\_std\_y  
15       | gravityacc\_std\_z  
16       | bodyaccjerk\_mean\_x  
17       | bodyaccjerk\_mean\_y  
18       | bodyaccjerk\_mean\_z  
19       | bodyaccjerk\_std\_x  
20       | bodyaccjerk\_std\_y  
21       | bodyaccjerk\_std\_z  
22       | bodygyro\_mean\_x  
23       | bodygyro\_mean\_y  
24       | bodygyro\_mean\_z  
25       | bodygyro\_std\_x  
26       | bodygyro\_std\_y  
27       | bodygyro\_std\_z  
28       | bodygyrojerk\_mean\_x  
29       | bodygyrojerk\_mean\_y  
30       | bodygyrojerk\_mean\_z  
31       | bodygyrojerk\_std\_x  
32       | bodygyrojerk\_std\_y  
33       | bodygyrojerk\_std\_z  
34       | bodyaccmag\_mean  
35       | bodyaccmag\_std  
36       | gravityaccmag\_mean  
37       | gravityaccmag\_std  
38       | bodyaccjerkmag\_mean  
39       | bodyaccjerkmag\_std  
40       | bodygyromag\_mean  
41       | bodygyromag\_std  
42       | bodygyrojerkmag\_mean  
43       | bodygyrojerkmag\_std  
44       | bodyaccfreq\_mean\_x  
45       | bodyaccfreq\_mean\_y  
46       | bodyaccfreq\_mean\_z  
47       | bodyaccfreq\_std\_x  
48       | bodyaccfreq\_std\_y  
49       | bodyaccfreq\_std\_z  
50       | bodyaccjerkfreq\_mean\_x  
51       | bodyaccjerkfreq\_mean\_y  
52       | bodyaccjerkfreq\_mean\_z  
53       | bodyaccjerkfreq\_std\_x  
54       | bodyaccjerkfreq\_std\_y  
55       | bodyaccjerkfreq\_std\_z  
56       | bodygyrofreq\_mean\_x  
57       | bodygyrofreq\_mean\_y  
58       | bodygyrofreq\_mean\_z  
59       | bodygyrofreq\_std\_x  
60       | bodygyrofreq\_std\_y  
61       | bodygyrofreq\_std\_z  
62       | bodyaccmagfreq\_mean  
63       | bodyaccmagfreq\_std  
64       | bodyaccjerkmagfreq\_mean  
65       | bodyaccjerkmagfreq\_std  
66       | bodygyromagfreq\_mean  
67       | bodygyromagfreq\_std  
68       | bodygyrojerkmagfreq\_mean  
69       | bodygyrojerkmagfreq\_std  








This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
