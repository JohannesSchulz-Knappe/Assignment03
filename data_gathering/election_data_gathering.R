#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Election Data Gathering
# Johannes Schulz-Knappe
# Update 27 April 2016
# Hertie School of Governance
#######################################################################


#-----------------------------------------#
# 1. Prepare the workspace                #
#-----------------------------------------#

# Run "1_Data.R" for workspace preparation


#-----------------------------------------#
# 2. Retrieve state election data         #
#-----------------------------------------#

# All downloads updated on 27.04.2016


## 2.1 Baden-Württemberg 2016 & 2011

# Data available as webpage table on the 2016 and 2011 election results

# Assign webpage linke to "URL"
URL <- 'http://www.statistik.baden-wuerttemberg.de/Wahlen/Landtag/02035000.tab?E=KR'


# get and parse table from webpage
webpage <- read_html(URL)
table <- html_nodes(webpage, 'table')  # 'table' as identifier
bw_raw <- html_table(table, header = FALSE, 
                     fill = TRUE)


# convert raw data into a data frame
bw_raw <- as.data.frame(bw_raw)


# Repair encoding of first column (district names)
bw_raw$X1 <- repair_encoding(bw_raw$X1) 


# Clean environment
rm(URL)
rm(webpage)
rm(table)



## 2.2 Rhineland-Palatinate 2016

# Import csv table on 2016 state election, covering districts and
rp16_raw <- read.csv('http://www.wahlen.rlp.de/ltw/wahlen/2016/downloads/lw000.txt',
                     sep = ';', 
                     header = TRUE)


## 2.3 Rhineland-Palatinate 2011

# Import csv table on 2011 state election, covering only districts (Landkreise)
rp11_raw <- read.csv('http://www.wahlen.rlp.de/ltw/wahlen/2011/downloads/lw000.txt', 
                     sep = ';', 
                     header = TRUE)


## 2.4 Saxony Anhalt 2016

# Import csv table on 2016 state election, covering districts and constituencies
sa16_raw <- read.csv('http://www.statistik.sachsen-anhalt.de/wahlen/lt16/erg/csv/lt16dat2.csv',
                     sep = ';')


## 2.5 Saxony Anhalt 2011

# Import csv table on 2011 state election, covering districts and constituencies
sa11_raw <- read.csv('http://www.statistik.sachsen-anhalt.de/wahlen/lt11/erg/csv/lt11dat2.csv',
                     sep = ';')