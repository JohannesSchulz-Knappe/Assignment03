#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Structural Data Cleaning 
# Johannes Schulz-Knappe
# Update 25 April 2016
# Hertie School of Governance
#######################################################################

#-----------------------------------------#
# Preparation                             #
#-----------------------------------------#


## if not done before, install packages:


# Create list of commonly used working directories (update, if needed)
possible_dir <- c('C:/Users/Johannes SK/Dropbox/Studium/Spring2016/CollaborativeResearch/Assignment03',
                  'C:/Users/User/Documents/GitHub/Assignment03')
set_valid_wd(possible_dir) # Set to first valid directory in the possible_dir vector
rm(possible_dir) # remove possible_dir vector


#-----------------------#
# 1. Getting data files #
#-----------------------#

source("structural_data_gathering.R")


#-----------------------#
# 1. Cleaning data      #
#-----------------------#


### 1. Education

edu <- edu_raw[, -c(1, 3)]  # delete unnecessary columns
names(edu) <- c("ID", "abitur.ratio", "nodegree.ratio")   # rename columns
edu$ID <- as.numeric(edu$ID) # change ID class to numeric


### 2. GDP per capita

gdp <- gdp_raw[, -c(1, 3)]  # delete unnecessary columns
names(gdp) <- c("ID", "GDP.capita")   # rename columns
gdp$ID <- as.numeric(gdp$ID) # change ID class to numeric
gdp$GDP.capita <- as.numeric(gdp$GDP.capita) # change GDP variable to numeric


### 3. Unemployment rate

unemp <- unemp_raw[, c(2, 11)] # keep necessary columns
unemp <- unemp[-c(1:9), ] # delete unnecessary rows
names(unemp) <- c("ID", "unempl.rate") # rename columns


### 4. Refugees

refugee <- refugee_raw[, c(2, 10)] # keep necessary columns
names(refugee) <- c("ID", "n.refugees")


