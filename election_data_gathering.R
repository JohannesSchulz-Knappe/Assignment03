#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Election Data Gathering
# Md Mujahedul Islam & Johannes Schulz-Knappe
# Update 24 April 2016
# Hertie School of Governance
#######################################################################

#-----------------------------------------#
# Preparation                             #
#-----------------------------------------#

## if not done before, install packages:
# install.packages("repmis")

library(repmis)
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

# All downloads updated at 24.04.2016

### Baden-Württemberg 2016 & 2011

URL <- 'http://www.statistik.baden-wuerttemberg.de/Wahlen/Landtag/02035000.tab?E=KR'
webpage <- read_html(URL)
table <- html_nodes(webpage, 'table')
bw_raw <- html_table(table, header = FALSE, 
                     fill = TRUE)
bw_raw <- as.data.frame(bw_raw) # get and parse table from webpage
bw_raw$X1 <- repair_encoding(bw_raw$X1) # repair encoding of first column

rm(URL)
rm(webpage)
rm(table) # clean environment


### Rhineland-Palatinate 2016

rp16_raw <- read.csv('http://www.wahlen.rlp.de/ltw/wahlen/2016/downloads/lw000.txt',
                     sep = ';', header = TRUE)

### Rhineland-Palatinate 2011 (Landkreise)

rp11_raw <- read.csv('http://www.wahlen.rlp.de/ltw/wahlen/2011/downloads/lw000.txt',
                       sep = ';', header = TRUE)


### Saxony Anhalt 2016

sa16_raw <- read.csv('http://www.statistik.sachsen-anhalt.de/wahlen/lt16/erg/csv/lt16dat2.csv',
                 sep = ';')


### Saxony Anhalt 2011

sa11_raw <- read.csv('http://www.statistik.sachsen-anhalt.de/wahlen/lt11/erg/csv/lt11dat2.csv',
                     sep = ';')




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