# DataCleaningAssignment
For Coursera Data Cleaning Final Project

## run_analysis.R
This file downloads the activity data from UCI. This data is split into training (70%) and testing (30%), for the 30 subjects, and includes over 500 variables (features) created by, or calculated from, the Samsung accelerometers worn by the subjects. The subjects were monitored while performing 6 different activites, the y or label files.

The R code downloads and unzips the data, combines and subsets the testing and training data, and applies the feature and activity labels.

The final output of the script is a data.table, tdata.txt, generated using the dplyr library. The variable names are direct from the UCI data files.
