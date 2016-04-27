#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Election Data Cleaning
# Johannes Schulz-Knappe 
# Update 27 April 2016
# Hertie School of Governance
#######################################################################


#-----------------------------------------#
# 1. Prepare the workspace                #
#-----------------------------------------#

# Run "1_Data.R" for workspace preparation


#-----------------------------------------#
# 2. Cleaning election data               #
#-----------------------------------------#

## 2.1 Baden-Württemberg


### Step 1: Extract dependent variable for 2016

# Create intermediary data frame bw1 with relevant columns
bw1 <- bw_raw[, c(1, 2, 9)]

# Rename columns
names(bw1) <- c("district.name", "election.year", "vote.AfD")

# Delete the rows that are not covering 2016 state election
bw1 <- bw1[-c(1, 2, 3, 3+2*(1:44)), ]



### Step 2: Extract non-voters and other party voteshares for 2011 

# Create intermediary data frame bw2 with relevant columns
bw2 <- bw_raw[, c(1, 3, 4, 5, 6, 7, 8)]

# Rename columns
names(bw2) <- c("district.name", "lag.turnout", "lag.CDU", "lag.Greens", 
                "lag.SPD", "lag.FDP", "lag.Linke")

# Delete the rows that are not covering 2011 state election
bw2 <- bw2[-c(1, 2, 3, 4, 4+2*(1:43)), ]

# add district.names from bw1 to bw2 as identifier (this is functionable
# since both are still sorted in same order)
bw2$district.name <- bw1$district.name 



### Step 3: Merge intermediary data frames into one data frame

bw <- merge(bw1, bw2, "district.name")

# Remove intermediary and raw data frames from environment
rm(bw_raw)
rm(bw1)
rm(bw2)


### Step 4: Adding state variable

bw$state <- "BW"


### Step 5: Create district ID

bw_ID <- refugee_raw[, c(2, 3)] # Retrieve ID from 'refugee_raw' data
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

# sort district.names alphabetically
bw_ID <- arrange(bw_ID, bw_ID$district.name)

# Add ID to bw (as bw amd bw_ID are identically sorted)
bw$ID <- bw_ID$district.ID 

# Remove bw_ID from environment
rm(bw_ID)

# Reorder columns
bw <- bw[c(11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)] 



## 2.2 Rhineland-Palatinate


### Step 1: Extract dependent variable for 2016

# Create intermediary data frame rp1 with relevant columns
rp1 <- rp16_raw[, c(2, 105)]

# Rename columns
names(rp1) <- c("district.name", "vote.AfD") 

# Delete rows that are not on district level
rp1 <- rp1[-c(1, grep('VG$', rp1$district.name)), ] 


# Clean district names
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


### Step 2: Extract non-voters and other party voteshares for 2011

# Create intermediary data frame rp2 with relevant columns
rp2 <- rp11_raw[, c(2, 9, 94, 95, 96, 97, 98)]

# Rename columns
names(rp2) <- c("district.name", "lag.turnout", "lag.SPD",
                "lag.CDU", "lag.FDP", "lag.Greens", "lag.Linke") 

# Delete rows that are not district level
rp2 <- rp2[-1, ]


# Clean district names
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


### Step 3: Merge intermediary data frames into one data frame

rp <- merge(rp1, rp2, "district.name")

# Remove intermediary and raw data frames from environment
rm(rp11_raw)
rm(rp16_raw)
rm(rp1)
rm(rp2)


### Step 4: Add state and year variable

rp$state <- "RP"
rp$election.year <- "2016"


### Step 5: Create district ID

# Retrieve ID from refugee_raw data
rp_ID <- refugee_raw[, c(2, 3)] 

# Keep IDs for Rhineland-Palatinate
rp_ID <- rp_ID[c(grep('^07', rp_ID$district.ID)), ]

# Delete IDs on non-district level
rp_ID <- rp_ID[-c(1, 2, 14, 20), ] 


# Clean district names
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

# Sort district.names alphabetically
rp_ID <- arrange(rp_ID, rp_ID$district.name) 

# Add ID to rp (functionally as rp amd rp_ID are identically sorted)
rp$ID <- rp_ID$district.ID

# Remove rp_ID from environment
rm(rp_ID)

# Reorder columns
rp <- rp[c(11, 1, 10, 2, 3, 4, 5, 6, 7, 8, 9)]




## 2.3 Saxony Anhalt


### Step 1: Extract dependent variable for 2016

# Create intermediary data frame sa1 with relevant columns
sa1 <- sa16_raw[, c(7, 8, 12, 19)]

# Rename columns
names(sa1) <- c("ID", "district.name", "valid.votes", "AfD.n")

# Delete rows that are not district level
sa1 <- sa1[-c(1, 16:58), ]

# Calculate voteshare variable
sa1$vote.AfD    <- sa1$AfD.n/sa1$valid.votes*100

# Delete used columns
sa1$AfD.n       <- NULL
sa1$valid.votes <- NULL


### Step 2: Extract non-voters and other party voteshares for 2011 

# Create intermediary data frame sa2 with relevant columns
sa2 <- sa11_raw[, c(7, 8, 9, 10, 12, 13, 14, 15, 16, 22)]

# Rename columns
names(sa2) <- c("ID", "district.name", "eligible.voters", "voters.n", 
                "valid.votes", "CDU.n", "Linke.n", "SPD.n", "Greens.n", 
                "FDP.n")

# Delete rows that are not district level  
sa2 <- sa2[-c(1, 16:60), ]

# Calculating voter turnout 
sa2$lag.turnout <- sa2$voters.n/sa2$eligible.voters*100 

# calculating party vote shares in percentage
sa2$lag.CDU    <- sa2$CDU.n/sa2$voters.n*100
sa2$lag.Linke  <- sa2$Linke.n/sa2$voters.n*100
sa2$lag.SPD    <- sa2$SPD.n/sa2$voters.n*100
sa2$lag.Greens <- sa2$Greens.n/sa2$voters.n*100
sa2$lag.FDP    <- sa2$FDP.n/sa2$voters.n*100

# Deleting used columns
sa2$eligible.voters <- NULL
sa2$voters.n        <- NULL
sa2$valid.votes     <- NULL
sa2$CDU.n           <- NULL
sa2$Linke.n         <- NULL
sa2$SPD.n           <- NULL
sa2$Greens.n        <- NULL
sa2$FDP.n           <- NULL


# Step 3: Merge variables into one data frame

sa <- merge(sa1, sa2, c("ID", "district.name"))

# Remove intermediary and raw data frames from environment
rm(sa11_raw)
rm(sa16_raw)
rm(sa1)
rm(sa2)

# Clean district names

sa$district.name <- gsub(pattern = 'Landkreis ', 
                         replacement = '', 
                         x = sa$district.name)
sa$district.name <- gsub(pattern = 'Kreisfreie Stadt ', 
                         replacement = '', 
                         x = sa$district.name)


# Step 4: Adding state and year variable

sa$state <- "SA"
sa$election.year <- "2016"



#-----------------------------------------#
# 3. Combine election data                #
#-----------------------------------------#

# Combine all election data sets into one data frame
data.election <- rbind(bw, rp, sa) 

# Remove individual election data frames from environment
rm(bw)
rm(rp)
rm(sa)

# Replace commas with periods 
data.election[, c(4:10)] <- as.numeric(gsub(",", 
                                            ".", 
                                            as.matrix(data.election[, c(4:10)])))

# Round values to 2 digits
data.election[, c(4:10)] <- round(as.matrix(data.election[, c(4:10)]), digits=2)

# Convert ID into numeric
data.election$ID <- as.numeric(as.character(data.election$ID))

# Convert election.year into numeric
data.election$election.year <- as.numeric(data.election$election.year)