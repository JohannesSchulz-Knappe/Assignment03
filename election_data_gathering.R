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


# Install packages

## if not done before, install:
# install.packages("repmis")
# install.packages("rio")

library(repmis)
# library(rio) (not used so far)


# Set the working directory

# Create list of commonly used working directories (update, if needed)
possible_dir <- c('C:/Users/Johannes SK/Dropbox/Studium/Spring2016/CollaborativeResearch/Assignment03',
                  'C:/Users/User/Documents/GitHub/Assignment03')

# Set to first valid directory in the possible_dir vector
set_valid_wd(possible_dir)

rm(possible_dir)

#-------------------------------------------#
# Retrieve the data for the state elections #
#-------------------------------------------#

# Baden-Wuerttemberg 2016
bw16 <- read.csv('http://www.statistik.baden-wuerttemberg.de/Wahlen/Landtag/Kreise.csv', 
                 sep = ';')
View(bw16)

# Rhineland-Palatinate 2016

## data only available in .pdf format
# Install "https://s3.amazonaws.com/bytescout.com/files/PDFMultitool.exe"
# Download "https://www.statistik.rlp.de/fileadmin/dokumente/nach_themen/stat_analysen/wahlen/lw/wahlnachtanalyse-lw2016.pdf"
# Open wahlnachtanalyse-lw2016.pdf in PDFMultitool
# Convert tables on page 64 and 65 into .csv format, without headers. Save .csv files in 
# working directory

rp16a <- read.csv('wahlnachtanalyse-lw2016_page_64.csv', header = FALSE, sep = ';')
rp16b <- read.csv('wahlnachtanalyse-lw2016_page_65.csv', header = FALSE, sep = ';')

# Saxony Anhalt 2016
sa16 <- import('')



View(bw16)
