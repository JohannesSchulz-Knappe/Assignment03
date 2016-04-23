#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Election Data Gathering
# Johannes Schulz-Knappe
# Updated 23 April 2016
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
# install.packages("xlsx")

library(repmis)
library(rio)
library(xlsx)

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

View(rp16a)

# Saxony Anhalt 2016
sa16 <- read.csv('http://www.statistik.sachsen-anhalt.de/wahlen/lt16/erg/csv/lt16dat2.csv',
                 sep = ';')

# Bremen 2015
br15 <- read.csv

# Hamburg 2015
ha15 <- read.csv

# Brandenburg 2014
bb14 <- source_XlsxData('https://www.statistik-berlin-brandenburg.de/Publikationen/Dowmies/BB_LT_2014_Wahlkreise_Endg_Ergebnis.xlsx', 
                        2, cache = TRUE)
## SHA-1 hash of the downloaded data file is: 'd017e1c2b9bf28227362978e41986a023f149237'

View(bb14)

# Saxony 2014
sx14 <- read.csv

# Thuringia 2014
th14 <- read.csv

# Hesse 2013
## data available in compressed format

# Store the URL in an object called 'URL'
URL <- "http://www.statistik-hessen.de/fileadmin/media/fb05/dokumente/landtagswahl2013.zip"

# Create a temporary file called 'temp' to put the zip file into
temp <- tempfile()

# Download the compressed file into the temporary file
download.file(URL, temp)

# Decompress the file and convert it into a data frame
he13 <- import(gzfile(temp, "landtagswahl2013.xls"))

# Delete the temporary file
unlink(temp)

View(he13)
