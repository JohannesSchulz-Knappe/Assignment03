#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Election Data Cleaning
# Johannes Schulz-Knappe & Md Mujahedul Islam 
# Update 25 April 2016
# Hertie School of Governance
#######################################################################

#--------------------------------------#
# Descriptive Statistics                          #
#--------------------------------------#


## if not done before, install packages:
# install.packages(plyr)



# Create list of commonly used working directories (update, if needed)
possible_dir <- c('C:/Users/Johannes SK/Dropbox/Studium/Spring2016/CollaborativeResearch/Assignment03',
                  'C:/Users/User/Documents/GitHub/Assignment03')
set_valid_wd(possible_dir) # Set to first valid directory in the possible_dir vector
rm(possible_dir) # delete possible_dir


rm(list = ls()) #just to clear all
load <- c("dplyr", "xtable", "texreg", "stargazer", "magrittr", "readstata13", "ggplot2", "reshape", "plyr") #shortcut to load packages I need
loaded <- lapply(load, require, character.only = T)
rm(load, loaded)


load("~/GitHub/Assignment03/.RData")

mean(Data$vote.AfD, na.rm = TRUE)
mean(Data$GDP.capita, na.rm = TRUE)
mean(Data$unempl.rate, na.rm = TRUE)
mean(Data$nodegree.ratio, na.rm = TRUE)
mean(Data$n.refugees, na.rm = TRUE)
mean(Data$abitur.ratio, na.rm = TRUE)

#------------------------------------------------------#
#loop function for finding "mean" for all the variables#
#------------------------------------------------------#
for (i in 4:length(names(Data))) {
  Data[, i] %>%
    mean() %>%
    round(digits = 2) %>%
    paste(names(Data)[i], ., '\n') %>% # the . directs the 
    cat()
}

#----------------------------#
#Summary of all the variables#
#----------------------------#
summary(Data$vote.AfD)
summary(Data$n.refugees)


#-----------------------------------------------------#
#Histograp using ggplot to show the number of refugees#
#-----------------------------------------------------#
ggplot(Data) +
  geom_histogram(aes(x = n.refugees),
                 colour = "black",
                 fill = "transparent",
                 binwidth = 30) +
  ylab("Frequency") +
  xlab("No. of refugess in RP, BW, and SA") +
  theme_light()


#-----------------------------------------------------#
#AfD's vote share by consistuencies#
#-----------------------------------------------------#
ggplot(Data) +
  geom_bar(aes(y = vote.AfD, x = reorder(district.name, -vote.AfD)), 
           stat = "identity") +
  ylab("AfD's vote share") +
  xlab("Different consistuencies of RP, BW and SA") +
  ggtitle("Vote share of AfD in three different states of Germany") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90))



#-----------------------------------------------------#
#Correlation of AfD's vote share and unemployment rate#
#-----------------------------------------------------#
# the result shows statistically significant positve 
# correlation of increase in unemployment rate with 
# the increase in AfD's vote share in those three states

ggplot2::ggplot(Data,aes(log(x = unempl.rate), vote.AfD)) + 
  xlab("Unemployment rate in RP, BW, and SA") +
  ylab("AfD's vote share (in %)") +
  geom_point() + geom_smooth() + 
  theme_bw()

#------------------------------------------------------#
#Test for statistical significance of above correlation#
#------------------------------------------------------#

cor.test(log(Data$vote.AfD), Data$unempl.rate)

#-----------------------------------------------------#
#Correlation of AfD's vote share and unemployment rate#
#-----------------------------------------------------#
# the result shows statistically significant negative 
# coorelation of increase inPer capita GDP 
# with AfD's vote share

ggplot2::ggplot(Data,aes(log(x = GDP.capita), vote.AfD)) + 
  xlab("GDP per capita in RP, BW, and SA") +
  ylab("AfD's vote share (in %)") +
  geom_point() + geom_smooth() + 
  theme_bw()

#------------------------------------------------------#
#Test for statistical significance of above correlation#
#------------------------------------------------------#

cor.test(log(Data$vote.AfD), Data$GDP.capita)



#-----------------------------------------------------#
#Correlation of AfD's vote share and No. of Refugees  #
#-----------------------------------------------------#
# the result though shows positive coorelation of 
# increase no. of refugees with with AfD's vote share, 
# it is not statistically significant (most likely due
# to small small size)

ggplot2::ggplot(Data,aes(log(x = n.refugees), vote.AfD)) + 
  xlab("GDP per capita in RP, BW, and SA") +
  ylab("AfD's vote share (in %)") +
  geom_point() + geom_smooth() + 
  theme_light()

#------------------------------------------------------#
#Test for statistical significance of above correlation#
#------------------------------------------------------#

cor.test(log(Data$vote.AfD), Data$n.refugees)



