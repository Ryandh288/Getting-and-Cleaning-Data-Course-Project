Getting and Cleaning Data Course Project
========================================

Project of [Getting and Cleaning Data course on Coursera](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project), July 2016 edition.

## Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

## What you find in this repository

* __CodeBook.md__: information about raw and tidy data set and elaboration made to
  transform them
* __LICENSE__: license terms for text and code
* __README.md__: this file
* __run_analysis.R__: R script to transform raw data set in a tidy one

## How to create the tidy data set

1. clone this repository: `git clone git@github.com:maurotrb/getting-cleaning-data-2014-project.git`
2. download [compressed raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
3. unzip raw data and copy the directory `UCI HAR Dataset` to the cloned repository root directory
4. open a R console and set the working directory to the repository root (use setwd())
5. source run_analysis.R script: `source('run_analysis.R')`

The output of the 5th step is called GACDtidy.txt, and uploaded in the course project's form.
