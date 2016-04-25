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
# Cleaning data         #
#-----------------------#


### 1. Education

edu <- edu_raw[, -c(1, 3)]  # delete unnecessary columns
names(edu) <- c("ID", "abitur.ratio", "nodegree.ratio")   # rename columns
edu$ID <- as.numeric(as.character(edu$ID)) # convert ID to numeric


### 2. GDP per capita

gdp <- gdp_raw[, -c(1, 3)]  # delete unnecessary columns
names(gdp) <- c("ID", "GDP.capita")   # rename columns
gdp$ID <- as.numeric(as.character(gdp$ID)) # convert ID to numeric

gdp$GDP.capita <- as.character(gdp$GDP.capita) # convert GDP.capita to character
gdp$GDP.capita <- gsub(",", ".", x = gdp$GDP.capita) # replace commas with periods
gdp$GDP.capita <- as.numeric(gdp$GDP.capita) # convert GDP.capita to numeric


### 3. Unemployment rate

unemp <- unemp_raw[, c(2, 11)] # keep necessary columns
unemp <- unemp[-c(1:9), ] # delete unnecessary rows
names(unemp) <- c("ID", "unempl.rate") # rename columns
unemp$ID <- as.numeric(as.character(unemp$ID)) # convert ID to numeric

unemp$unempl.rate <- as.character(unemp$unempl.rate) # convert unempl.rate  to character
unemp$unempl.rate <- gsub(",", ".", x = unemp$unempl.rate) # replace commas with periods
unemp$unempl.rate <- as.numeric(unemp$unempl.rate) # convert unempl.rate  to numeric


### 4. Refugees

refugee <- refugee_raw[, c(2, 10)] # keep necessary columns
names(refugee) <- c("ID", "n.refugees")
refugee$ID <- as.numeric(as.character(refugee$ID)) # convert ID to numeric