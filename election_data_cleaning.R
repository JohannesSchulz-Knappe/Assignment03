#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Webscraping the datasets 
# Johannes Schulz-Knappe
# Updated 22 April 2016
# Hertie School of Governance
#######################################################################

#-----------------------------------------#
# Preparation                             #
#-----------------------------------------#

# Clear enviornment
rm(list = ls())


# Installed packages and 
library(stringr)
library(repmis)
library(rio)
library(rJava)
library(xlsx)
library (readxl)
library(dplyr)
library(devtools)
library(ggplot2)
library(plyr)
library(WDI)
library(rio)
library(countrycode)
library(weathermetrics)
library(gdata)
library (foreign)
library(readstata13)
library(stargazer)
library(magrittr)
library(reshape)
library(arm)
library(coefplot)
library(bibtex)

# Set the working directory

# Create list of commonly used working directories (update, if needed)
possible_dir <- c('C:/Users/Johannes SK/Dropbox/Studium/Spring2016/CollaborativeResearch/Assignment03',
                  'C:/Users/User/Documents/GitHub/Assignment03')

# Set to first valid directory in the possible_dir vector
set_valid_wd(possible_dir)

rm(possible_dir)


# Getting data files

source("election_data_gathering.R")
View(sa16)

# Cleaning Baden-Wurttemberg election March 2016 data
# Keeping relevant variables from the dataset
bw16_clean <- bw16[c(1, 9, 24)]

# renaming variables for consistency and appending
names(bw16_clean) <- c("dist.name", "vote.n", "vote.afd")

# Cleaning Saxony Anhalt election  March 2016 data
# keeping relevant variables from the dataset
svariable <- c(8, 12, 19)
sa16_clean <- sa16[svariable]

# renaming variables for consistency and appending
names(sa16_clean) <- c("dist.name", "vote.n", "vote.afd")
View(sa16_clean)


# Cleaning Saxony Anhalt election  March 2016 data
# keeping relevant variables from the dataset
View(rp16b)
svariable <- c(1, 6)
rp16b_clean <- rp16b[svariable]

# renaming variables for consistency and appending
names(rp16b_clean) <- c("dist.name", "vote.afd")
View(vector)
vector <- rp16b_clean[1]
sapply(vector, class)

vector2 <- str_split_fixed(vector, pattern = ' ', n = 2)
View(vector2)
