# Copyright (c) 2015 Charles Eliot

# -------------------------------
# UTILITY FUNCTIONS
# -------------------------------

totidy <- function(x){
    # Convert raw variable name format to tidy standard
    
    x <- sub("\\(\\)", "", x)           # Remove parentheses
    
    if (substr(x,1,1) == "f"){          # Identify frequency domain variables
        x <- sub("-","Freq-",x)
    }
    
    x <- substr(x,2,nchar(x,type="c"))  # Remove lead t/f character
    x <- tolower(x)                     # Lower case
    x <- gsub("-","_",x)                # Convert dashes to underscores
    x <- gsub("bodybody","body",x)      # Minor clean-up
    
    return(x)
}

# -------------------------------
# MAIN CLEANING FUNCTION
# -------------------------------

clean <- function(data.directory=".\\"){
    old.working.directory <- getwd()
    on.exit(setwd(old.working.directory))
    setwd(data.directory)

    # Read the two main data tables
    
    table1 <- read.table(file="test\\X_test.txt")
    table2 <- read.table(file="train\\X_train.txt")
    full.table <- rbind(table1,table2)
    
    # Read the feature (aka variable) names and use as column names
    
    features <- read.table(file="features.txt")
    names(full.table) <- features$V2
    
    # Select only columns with mean() or std() in the column name
    
    col.filter <- grep("mean\\(\\)|std\\(\\)",features$V2)
    full.table <- full.table[,col.filter]
    
    # Convert column names to tidy format
    
    col.names <- names(full.table)
    names(full.table) <- sapply(col.names,totidy)
    
    # Read the list of all experimental subjects
    
    subs1 <- read.table(file="test\\subject_test.txt")
    subs2 <- read.table(file="train\\subject_train.txt")
    all.subs <- rbind(subs1,subs2)
    
    # Read in the lookup table of activity names
    
    activity.labels <- read.table(file="activity_labels.txt")
    
    # Read in the list of activity codes
    
    activities1 <- read.table(file="test\\y_test.txt")
    activities2 <- read.table(file="train\\y_train.txt")
    all.activities <- rbind(activities1,activities2)
    
    # Convert activity codes to strings by using the lookup table
    
    all.activities <- sapply(all.activities$V1,function(x){activity.labels$V2[activity.labels$V1==x]})
    
    # Construct the full data table by binding column sets together
    
    full.table <- cbind(all.subs,all.activities,full.table)
    
    names(full.table)[1] <- "subject"
    names(full.table)[2] <- "activity"
    
    return(full.table)
}

# -------------------------------
# ANALYSIS FUNCTION
# -------------------------------

grouped.means <- function(df=data.frame()){
    tbl_df(df) %>% group_by(subject,activity) %>% summarize_each(funs(mean))   
}

# -------------------------------
# DEFAULT SCRIPT ACTIONS
# -------------------------------

full.data <- clean()
grouped.data <- grouped.means(full.data)
write.table(grouped.data, file="grouped_data.txt", row.names=FALSE)
