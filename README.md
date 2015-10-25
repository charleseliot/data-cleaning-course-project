# data-cleaning-course-project

Sourcing run_analysis.R will write a data frame of the full cleaned data to full.data, and a data frame of grouped data, aggregated by mean values, to grouped.data. grouped.data is then saved as grouped_data.txt.

More implementation information is in the run_analysis.R comments.

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
write.table(grouped.data, file="grouped_data.txt", row.names=FALSE)
```
