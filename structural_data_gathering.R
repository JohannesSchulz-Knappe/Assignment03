#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Structural Data Gathering 
# Johannes Schulz-Knappe
# Updated 23 April 2016
# Hertie School of Governance
#######################################################################

#-----------------------------------------#
# Preparation                             #
#-----------------------------------------#

rm(list = ls()) # Clear enviornment


## if not done before, install packages:
# install.packages("repmis")
# install.packages("rio")
# install.packages("xlsx")

# Library packages
library(repmis)
library(rio)
library(xlsx)

# Create list of commonly used working directories (update, if needed)
possible_dir <- c('C:/Users/Johannes SK/Dropbox/Studium/Spring2016/CollaborativeResearch/Assignment03',
                  'C:/Users/User/Documents/GitHub/Assignment03')
set_valid_wd(possible_dir) # Set to first valid directory in the possible_dir vector
rm(possible_dir) # remove possible_dir vector


#-------------------------------------------#
# Retrieve structura data                   #
#-------------------------------------------#

### Citation:

# Data has to be downloaded manually, as the federal statistical offices
# (DeStatis/Genesis) does not provide an API for free. Two sources are used: 
# https://www-genesis.destatis.de/genesis/online and
# https://www.regionalstatistik.de/genesis/online (specified for each variable).
# All data sets on those platforms are attributed a certain table number,
# which is provided in the sections below. Finding the files works best when
# inserting the table number into the search box at the beginning of the
# respective pages.
# For some data sets a certain time frame has to be specified. If we have done so,
# it is described in the sections below.
# All downloaded data is downloaded as a csv file and saved in the folder Data/Indepdendent Variables.
# No changes have been made to the files before loading them into R.
# Note: the table number and the file name are identical.

### Citation end

# Education

# Table AI003-2 from https://www.regionalstatistik.de/genesis/online
# Downloaded on 11/8/2015
# Specification: "Zeit auswählen" (select time) = 2013

education_raw <- read.csv("Data_Files/AI003-2.csv",
                         header = FALSE, 
                         sep = ";", 
                         na.strings = c("-","."),
                         col.names = c("year", "district.ID", "district.name", "abitur.ratio", "nodegree.ratio"),
                         skip = 6,
                         nrows = 525,
                         dec=",") # loads data frame


# Unemployment rate

# Table 659-71-4 from https://www.regionalstatistik.de/genesis/online
# Downloaded 11/8/2015
# Specification: "Zeit auswählen" (select time) = 2014

unemployment_raw <- read.csv("Data_Files/659-71-4.csv",
                    header = FALSE, 
                    sep = ";", 
                    na.strings = c("-","."),
                    nrows = 533,
                    dec = ",") # loads data frame


# GDP/capita

# Table AI-N-10 from https://www.regionalstatistik.de/genesis/online
# Downloaded 11/8/2015
# Specification: "Zeit auswählen" (select time) = 2012

gdp_raw <- read.csv("Data_Files/AI-N-10.csv",
                   header = FALSE, 
                   sep = ";", 
                   na.strings = c("-","."),
                   col.names = c("year", "district.ID", "district.name", "GDP.cap"),
                   skip = 7,
                   nrows = 525) # loads data frame


# number of refugees

# Table 661-31-4 from https://www.regionalstatistik.de/genesis/online
# Downloaded 11/8/2015
# Specification: "Zeit auswählen" (select time) = 12/31/2013

refugees_raw <- read.csv("Data_Files/661-31-4.csv",
                   header = FALSE, 
                   sep = ";", 
                   na.strings = c("-","."),
                   nrows = 534,
                   dec = ",") # loads data frame

