#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Election Data Gathering
# Johannes Schulz-Knappe
# Update 24 April 2016
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

library(repmis)
library(rio)
library(xlsx)
library(rvest)
library(dplyr)


# Create list of commonly used working directories (update, if needed)
possible_dir <- c('C:/Users/Johannes SK/Dropbox/Studium/Spring2016/CollaborativeResearch/Assignment03',
                  'C:/Users/User/Documents/GitHub/Assignment03')
set_valid_wd(possible_dir) # Set to first valid directory in the possible_dir vector
rm(possible_dir) # remove possible_dir vector


#-------------------------------------------#
# Retrieve the data for the state elections #
#-------------------------------------------#

### Baden-Württemberg 2016

bw16_raw <- read.csv('http://www.statistik.baden-wuerttemberg.de/Wahlen/Landtag/Kreise.csv', 
                 sep = ';')


### Baden-Württemberg 2011

# bw11_raw <- read.csv('http://www.stala.bwl.de/Wahlen/Landtag/altKreise.csv',
                     # sep = ';') # Clean table, but not with recalculations

URL <- 'https://www.statistik-bw.de/Wahlen/Landtag/02035000.tab?E=LW'

# get and parse table from webpage
webpage <- read_html(URL)
table <- html_nodes(webpage, 'table')
bw11_raw <- html_table(table, fill = TRUE)

rm(URL)
rm(webpage)
rm(table) # clean environment


### Baden-Württemberg 2006

## Data not comparable due to district reforms affecting 16 of the 51 districts
## Data only available on Land level


#### Rhineland-Palatinate 2016 (and changes from 2011)

## data available in .pdf format
# Install "https://s3.amazonaws.com/bytescout.com/files/PDFMultitool.exe"
# Download "https://www.statistik.rlp.de/fileadmin/dokumente/nach_themen/stat_analysen/wahlen/lw/wahlnachtanalyse-lw2016.pdf"
# Open wahlnachtanalyse-lw2016.pdf in PDFMultitool
# Convert table on page 65 into .csv format, without headers. Save .csv file in 
# the Data_Files folder in the working directory

rp16_raw <- read.csv('Data_Files/wahlnachtanalyse-lw2016_page_65.csv', header = FALSE, sep = ';')


### Rhineland-Palatinate 2016 & 2011

## data available in xlsx format (work in progress)
# rp_raw <- source_XlsxData('http://www.wahlen.rlp.de/ltw/wahlen/2016_Landtagswahlergebnisse_Wahlkreise_Endgueltig.xlsx',
                          # 2, cache = TRUE)
# SHA-1 hash of the downloaded data file is: '684c60bd87144a1215024f912673c3f34ce7f6d9'
# or
# rp_raw <- read.xlsx2('http://www.wahlen.rlp.de/ltw/wahlen/2016_Landtagswahlergebnisse_Wahlkreise_Endgueltig.xlsx',
                          # 2)


### Rhineland-Palatinate 2006

## Data only available on district level, too much cleaning effort


### Saxony Anhalt 2016

sa16_raw <- read.csv('http://www.statistik.sachsen-anhalt.de/wahlen/lt16/erg/csv/lt16dat2.csv',
                 sep = ';')


### Saxony Anhalt 2011

sa11_raw <- read.csv('https://www.statistik.sachsen-anhalt.de/wahlen/lt11/erg/csv/lt11dat2.csv',
                     sep = ';')


### Saxony Anhalt 2006

sa06_raw <- read.csv('https://www.statistik.sachsen-anhalt.de/wahlen/lt06/erg/csv/lt06dat2.csv',
                     sep = ';')
View(sa06_raw)



#------------------------------------------------------#
# Retrieve the data for the additional state elections #
#------------------------------------------------------#

# Attention:
# Since the data of different states is very diverse, we focus on the data of 
# the last three state elections (bw16, rp16, sa16) first

# Bremen 2015

# Hamburg 2015

# Brandenburg 2014
# bb14 <- source_XlsxData('https://www.statistik-berlin-brandenburg.de/Publikationen/Dowmies/BB_LT_2014_Wahlkreise_Endg_Ergebnis.xlsx', 
                       # 2, cache = TRUE)
## SHA-1 hash of the downloaded data file is: 'd017e1c2b9bf28227362978e41986a023f149237'

# Saxony 2014

# Thuringia 2014

# Hesse 2013
## data available in compressed format

# Store the URL in an object called 'URL'
# URL <- "http://www.statistik-hessen.de/fileadmin/media/fb05/dokumente/landtagswahl2013.zip"
# temp <- tempfile() # create a temporary file
# download.file(URL, temp) # download compressed file into the temporary file
# he13 <- import(gzfile(temp, "landtagswahl2013.xls")) # Decompress the file and
# convert it into a data frame (not working)
# unlink(temp) # delete the temporary file