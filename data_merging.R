#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Merging Final Dataset
# Johannes Schulz-Knappe
# Update 25 April 2016
# Hertie School of Governance
#######################################################################

rm(list = ls())

library(repmis)

# Create list of commonly used working directories (update, if needed)
possible_dir <- c('C:/Users/Johannes SK/Dropbox/Studium/Spring2016/CollaborativeResearch/Assignment03',
                  'C:/Users/User/Documents/GitHub/Assignment03')
set_valid_wd(possible_dir) # Set to first valid directory in the possible_dir vector
rm(possible_dir) # remove possible_dir vector



# Running the gathering and cleaning files

# 1. Electoral data gathering
source("election_data_gathering.R")

# 2. Structural data gathering
source("structural_data_gathering.R")

# 3. Electoral data cleaning
source("election_data_cleaning.R")

# 4. Structural data cleaning
source("structural_data_cleaning.R")




# Merging the data

Data <- merge(data.election, edu, "ID", all.x = TRUE)
Data <- merge(Data, gdp, "ID", all.x = TRUE)
Data <- merge(Data, unemp, "ID", all.x = TRUE)
Data <- merge(Data, refugee, "ID", all.x = TRUE)

View(Data)
