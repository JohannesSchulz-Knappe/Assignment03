#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Structural Data Gathering 
# Johannes Schulz-Knappe
# Update 27 April 2016
# Hertie School of Governance
#######################################################################


#-----------------------------------------#
# 1. Prepare the workspace                #
#-----------------------------------------#

# Run "1_Data.R" for workspace preparation


#-----------------------------------------#
# 2. Retrieve structura data              #
#-----------------------------------------#

# The data on structural characteristics of the districts is manually 
# retrieved from https://www.regionalstatistik.de/genesis/online, as the 
# Federal Statistical Office does not provide an API.
# We use the data files AI003-2 (Education), 659-71-4 (Unemployment),
# AI-N-10 (GDP per capita), and 661-31-4 (number of asylum seekers).
# The downloaded csv files are stored under '/data_raw' in the working directory


## 2.1 Education

# Table AI003-2, downloaded on 11/8/2015, selected time = 2013

# Import the csv file
edu_raw <- read.csv("data_raw/AI003-2.csv", 
                    header = FALSE, 
                    sep = ";", 
                    na.strings = c("-","."),
                    col.names = c("date", "district.ID", "district.name", 
                                  "abitur.percent", "nodegree.percent"),
                    skip = 6,
                    nrows = 525,
                    dec=",")


## 2.2 Unemployment rate

# Table 659-71-4, downloaded 11/8/2015, selected time = 2014

# Import the csv file
unemp_raw <- read.csv("data_raw/659-71-4.csv",
                      header = FALSE, 
                      sep = ";", 
                      na.strings = c("-","."),
                      nrows = 533,
                      dec = ",")


## 2.3 GDP per capita

# Table AI-N-10, downloaded 11/8/2015, selected time = 2012

# Import the csv file
gdp_raw <- read.csv("data_raw/AI-N-10.csv",
                    header = FALSE, 
                    sep = ";", 
                    na.strings = c("-","."),
                    col.names = c("date", "district.ID", "district.name", 
                                  "GDP.cap"),
                    skip = 7,
                    nrows = 525)


## 2.4 Number of asylum seekers

# Table 661-31-4, downloaded 11/8/2015, selected time = 12/31/2013

# Import the csv file
refugee_raw <- read.csv("data_raw/661-31-4.csv",
                        header = FALSE, 
                        sep = ";", 
                        na.strings = c("-","."),
                        col.names = c("date", "district.ID", "district.name", 
                                      "column04", "column05", "column06",
                                      "column07", "column08", "column09",
                                      "asylum.seeker"),
                        skip = 9,
                        nrows = 525,
                        dec = ",")