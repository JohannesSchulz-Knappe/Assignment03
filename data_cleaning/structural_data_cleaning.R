#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Structural Data Cleaning 
# Johannes Schulz-Knappe
# Update 27 April 2016
# Hertie School of Governance
#######################################################################


#-----------------------------------------#
# 1. Prepare the workspace                #
#-----------------------------------------#

# Run "1_Data.R" for workspace preparation


#-----------------------------------------#
# 2. Cleaning structural data             #
#-----------------------------------------#


## 2.1 Education

# Delete unnecessary columns
edu <- edu_raw[, -c(1, 3)]  

# Rename columns
names(edu) <- c("ID", "abitur.ratio", "nodegree.ratio")

# Convert ID to numeric
edu$ID <- as.numeric(as.character(edu$ID)) 

# Remove raw data from environment
rm(edu_raw)



## 2.2 GDP per capita

# Delete unnecessary columns
gdp <- gdp_raw[, -c(1, 3)]

# Rename columns
names(gdp) <- c("ID", "GDP.capita")

# Convert variables
gdp$ID <- as.numeric(as.character(gdp$ID))  # Convert ID to numeric 
gdp$GDP.capita <- as.character(gdp$GDP.capita)  # convert GDP.capita to character
gdp$GDP.capita <- gsub(",", ".", x = gdp$GDP.capita)  # replace commas with periods
gdp$GDP.capita <- as.numeric(gdp$GDP.capita)  # convert GDP.capita to numeric

# Remove raw data from environment
rm(gdp_raw)



### 2.3 Unemployment rate

# Keep necessary columns
unemp <- unemp_raw[, c(2, 11)]

# Delete unnecessary rows
unemp <- unemp[-c(1:9), ]

# Rename columns
names(unemp) <- c("ID", "unempl.rate")

# Convert variables
unemp$ID <- as.numeric(as.character(unemp$ID))  # convert ID to numeric
unemp$unempl.rate <- as.character(unemp$unempl.rate)  # convert unempl.rate to character
unemp$unempl.rate <- gsub(",", ".", x = unemp$unempl.rate)  # replace commas with periods
unemp$unempl.rate <- as.numeric(unemp$unempl.rate)  # convert unempl.rate to numeric

# Remove raw data from environment
rm(unemp_raw)


## 2.4 Refugees

# Keep necessary columns
refugee <- refugee_raw[, c(2, 10)]

# Rename columns
names(refugee) <- c("ID", "n.refugees")

# Convert ID to numeric
refugee$ID <- as.numeric(as.character(refugee$ID))

# Remove raw data from environment
rm(refugee_raw)