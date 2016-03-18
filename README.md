# Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The following items compose this project:
1) a tidy data se, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work performed to clean up the data called CodeBook.md. 


The R script "run_analysis.R" does the following:

1. Download the dataset in the working directory
2. Load the activity and feature info
3. Loads the training and test datasets, keeping only those columns which
   reflect a mean or standard deviation
4. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset
5. Merges the two datasets
6. Converts the "activity" and "subject" columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is saved in the file "tidy.txt".
