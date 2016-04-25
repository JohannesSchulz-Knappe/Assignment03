#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Election Data Cleaning
# Md Mujahedul Islam & Johannes Schulz-Knappe 
# Update 25 April 2016
# Hertie School of Governance
#######################################################################

#--------------------------------------#
# Preparation                          #
#--------------------------------------#


## if not done before, install packages:
# install.packages(plyr)

library("plyr")

# Create list of commonly used working directories (update, if needed)
possible_dir <- c('C:/Users/Johannes SK/Dropbox/Studium/Spring2016/CollaborativeResearch/Assignment03',
                  'C:/Users/User/Documents/GitHub/Assignment03')
set_valid_wd(possible_dir) # Set to first valid directory in the possible_dir vector
rm(possible_dir) # delete possible_dir


#------------------#
# Cleaning data    #
#------------------#

### 1. Baden-Württemberg

# Step 1: Extract dependent variable for 2016

bw1 <- bw_raw[, c(1, 2, 9)] # keep relevant columns
names(bw1) <- c("district.name", "election.year", "vote.AfD") # rename columns
bw1 <- bw1[-c(1, 2, 3, 3+2*(1:44)), ] # delete rows that are not 2016


# Step 2: Extract non-voters and other party voteshares for 2011 

bw2 <- bw_raw[, c(1, 3, 4, 5, 6, 7, 8)] # keep relevant columns
names(bw2) <- c("district.name", "lag.turnout", "lag.CDU", "lag.Greens", 
                "lag.SPD", "lag.FDP", "lag.Linke") # rename columns
bw2 <- bw2[-c(1,2,3,4, 4+2*(1:43)), ] # delete rows that are not 2011
bw2$district.name <- bw1$district.name # add district.names as identifier


# Step 3: Merge variables into one dataframe

bw <- merge(bw1, bw2, "district.name")


# Step 4: Adding state variable

bw$state <- "BW"


# Step 5: Create district ID

bw_ID <- refugee_raw[, c(2, 3)] # Retrieve ID from refugee_raw
bw_ID <- bw_ID[c(207:219, 221:232, 234:243, 245:253), ] # keep district IDs for BW

# Manipulate district names to match bw1 & bw2 district names
bw_ID$district.name <- gsub(pattern = 'Heilbronn, Landkreis', 
                            replacement = 'Heilbronn (Land)', 
                            x = bw_ID$district.name)
bw_ID$district.name <- gsub(pattern = 'Karlsruhe, Landkreis', 
                            replacement = 'Karlsruhe (Land)', 
                            x = bw_ID$district.name)
bw_ID$district.name <- gsub(pattern = 'Heilbronn, Kreisfreie Stadt', 
                            replacement = 'Heilbronn (Stadt)', 
                            x = bw_ID$district.name)
bw_ID$district.name <- gsub(pattern = 'Karlsruhe, Kreisfreie Stadt', 
                            replacement = 'Karlsruhe (Stadt)', 
                            x = bw_ID$district.name)
bw_ID$district.name <- gsub(pattern = ', Landkreis', 
                            replacement = '', 
                            x = bw_ID$district.name)
bw_ID$district.name <- gsub(pattern = ', Kreisfreie Stadt', 
                            replacement = '', 
                            x = bw_ID$district.name)
bw_ID$district.name <- gsub(pattern = ', Universitätsstadt', 
                            replacement = '', 
                            x = bw_ID$district.name)
bw_ID$district.name <- gsub(pattern = ', Landeshauptstadt', 
                            replacement = '', 
                            x = bw_ID$district.name)

bw_ID <- arrange(bw_ID, bw_ID$district.name) # sort alphabetically
bw$ID <- bw_ID$district.ID # add ID to bw

bw <- bw[c(11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)] # reorder columns


### 2. Rhineland-Palatinate

# Step 1: Extract dependent variable for 2016

rp1 <- rp16_raw[, c(2, 105)] # keep relevant columns
names(rp1) <- c("district.name", "vote.AfD") # rename columns
rp1 <- rp1[-c(1, grep('VG$', rp1$district.name)), ] # delete rows that are not district level

# clean district names
rp1$district.name <- gsub(pattern = 'Kaiserslautern, Landkreis', 
                          replacement = 'Kaiserslautern (Land)', 
                          x = rp1$district.name)
rp1$district.name <- gsub(pattern = 'Kaiserslautern, Kreisfreie Stadt', 
                          replacement = 'Kaiserslautern (Stadt)', 
                          x = rp1$district.name)
rp1$district.name <- gsub(pattern = ', Landkreis', 
                            replacement = '', 
                            x = rp1$district.name)
rp1$district.name <- gsub(pattern = ', Kreisfreie Stadt', 
                             replacement = '', 
                             x = rp1$district.name)


# Step 2: Extract non-voters and other party voteshares for 2011

rp2 <- rp11_raw[, c(2, 9, 94, 95, 96, 97, 98)] # keep relevant columns
names(rp2) <- c("district.name", "lag.turnout", "lag.SPD",
                "lag.CDU", "lag.FDP", "lag.Greens", "lag.Linke") # rename columns
rp2 <- rp2[-1, ] # delete rows that are not district level

# clean district names
rp2$district.name <- gsub(pattern = 'Kaiserslautern, Landkreis', 
                          replacement = 'Kaiserslautern (Land)', 
                          x = rp2$district.name)
rp2$district.name <- gsub(pattern = 'Kaiserslautern, Kreisfreie Stadt', 
                          replacement = 'Kaiserslautern (Stadt)', 
                          x = rp2$district.name)
rp2$district.name <- gsub(pattern = ', Landkreis', 
                          replacement = '', 
                          x = rp2$district.name)
rp2$district.name <- gsub(pattern = ', Kreisfreie Stadt', 
                          replacement = '', 
                          x = rp2$district.name)


# Step 3: Merge variables into one dataframe

rp <- merge(rp1, rp2, "district.name")


# Step 4: Adding state and year variable

rp$state <- "RP"
rp$election.year <- "2016"


# Step 5: Create district ID

rp_ID <- refugee_raw[, c(2, 3)] # Retrieve ID from refugee_raw
rp_ID <- rp_ID[c(grep('^07', rp_ID$district.ID)), ] # keep IDs for RP
rp_ID <- rp_ID[-c(1, 2, 14, 20), ] # keep IDs on district level

# clean district names
rp_ID$district.name <- gsub(pattern = 'Kaiserslautern, Landkreis', 
                            replacement = 'Kaiserslautern (Land)', 
                            x = rp_ID$district.name)
rp_ID$district.name <- gsub(pattern = 'Kaiserslautern, Kreisfreie Stadt', 
                            replacement = 'Kaiserslautern (Stadt)', 
                            x = rp_ID$district.name)
rp_ID$district.name <- gsub(pattern = ', Landkreis', 
                            replacement = '', 
                            x = rp_ID$district.name)
rp_ID$district.name <- gsub(pattern = ', Kreisfreie Stadt', 
                            replacement = '', 
                            x = rp_ID$district.name)

rp_ID <- arrange(rp_ID, rp_ID$district.name) # sort alphabetically
rp$ID <- rp_ID$district.ID # add ID to rp
rp <- rp[c(11, 1, 10, 2, 3, 4, 5, 6, 7, 8, 9)] # reorder columns



### 3. Saxony Anhalt

# Step 1: Extract dependent variable for 2016

sa1 <- sa16_raw[, c(7, 8, 12, 19)] # keep relevant columns
names(sa1) <- c("ID", "district.name", "valid.votes", "AfD.n") # rename columns

sa1$vote.AfD    <- sa1$AfD.n/sa1$valid.votes
sa1$AfD.n       <- NULL
sa1$valid.votes <- NULL # Calculate voteshare variable and delete used columns


# Step 2: Extract non-voters and other party voteshares for 2011 

sa2 <- sa11_raw[, c(7, 8, 9, 10, 12, 13, 14, 15, 16, 22)] # keep relevant columns
names(sa2) <- c("ID", "district.name", "eligible.voters", "voters.n", 
                "valid.votes", "CDU.n", "Linke.n", "SPD.n", "Greens.n", "FDP.n")
                # rename columns

# calculating voter turnout 
sa2$lag.turnout <- sa2$voters.n/sa2$eligible.voters 

# calculating party vote shares in percentage
sa2$cent        <- 100
sa2$lag.CDU     <- sa2$CDU.n/sa2$voters.n*sa2$cent
sa2$lag.Linke   <- sa2$Linke.n/sa2$voters.n*sa2$cent
sa2$lag.SPD     <- sa2$SPD.n/sa2$voters.n*sa2$cent
sa2$lag.Greens  <- sa2$Greens.n/sa2$voters.n*sa2$cent
sa2$lag.FDP     <- sa2$FDP.n/sa2$voters.n*sa2$cent


# deleting used columns
sa2$cent            <- NULL
sa2$eligible.voters <- NULL
sa2$voters.n        <- NULL
sa2$valid.votes     <- NULL
sa2$CDU.n           <- NULL
sa2$Linke.n         <- NULL
sa2$SPD.n           <- NULL
sa2$Greens.n        <- NULL
sa2$FDP.n           <- NULL


# Step 3: Merge variables into one dataframe

sa <- merge(sa1, sa2, c("ID", "district.name"))


# Step 4: Adding state and year variable

sa$state <- "SA"
sa$election.year <- "2016"



#---------------------------#
# Merge election data       #
#---------------------------#

data.election <- rbind(bw, rp, sa) # merge all election data sets into one data frame


