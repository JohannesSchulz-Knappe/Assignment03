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

summary(reg1)
plot(reg1, which = 1)
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

summary(Data)
View(test)
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
  out = 'figures/AfD_voteshare_in_RP_BW_SA.pdf'


#---------------------------------------------------------------------#
#---------------Correlation matrix in Table---------------------------#
#---------------------------------------------------------------------#
  
  correlation.matrix <- cor(Data[,c("vote.AfD","lag.CDU",
                                    "lag.SPD","GDP.capita",
                                    "unempl.rate","n.refugees",
                                    "abitur.ratio")])
  stargazer(correlation.matrix, 
            title = "Correlation Matrix",
            font.size = 'small',
            out = 'tables/correlation_matrix.tex')
  
  
  
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
  xlab("Number of refugees in RP, BW, and SA") +
  ylab("AfD's vote share (in %)") +
  geom_point() + geom_smooth() + 
  theme_light()

#------------------------------------------------------#
#Test for statistical significance of above correlation#
#------------------------------------------------------#

cor.test(log(Data$vote.AfD), Data$n.refugees)


#------------------------------------------------------------------------#
# Inferential Analysis: Determinants of AfD's success in recent elections#
#------------------------------------------------------------------------#

reg1 <- lm(vote.AfD ~ GDP.capita + unempl.rate + n.refugees, data = Data)
reg2 <- lm(vote.AfD ~ GDP.capita + unempl.rate + n.refugees + lag.CDU + 
             lag.SPD + lag.turnout, data = Data)
reg3 <- lm(vote.AfD ~ GDP.capita + unempl.rate + n.refugees + 
             abitur.ratio + nodegree.ratio, data = Data)
reg4 <- lm(vote.AfD ~ GDP.capita + unempl.rate + n.refugees 
           + lag.CDU + lag.SPD + lag.turnout + abitur.ratio + 
             nodegree.ratio, data = Data)


var_labels <- c('GDP per capita', 'Unemployment rate', 'No. of Refugees', 
            'Vote share of CDU in 2011 election',
            'Vote share of SPD in 2011 election',
            'High School Ratio', 'University Degree ratio', '(Intercept)')

stargazer::stargazer(reg1, reg2, reg3, reg4,
          omit = 'as.factor*', 
          omit.stat = c('f', 'ser'), # to nicely fits on the page
          out.header = F,
          title = 'Determinants of vote for the Alternative for Germany',
          dep.var.labels = 'Vote share of AfD',
          covariate.labels = var_labels,
          label = 'AfD_voteshare',
          add.lines = list(c('District FE?', rep('NO', 4))),
          font.size = 'small',
          digit = 2, 
          out = 'tables/afd_voteshare_regressions.tex')

#------------------------------------------------------------------------------#
#------------------------------------------------------------------------------#
#Summary statistics of all variables#
#------------------------------------------------------------------------------#
summary_labels <- c('Vote share of AfD', 'Vote turnout in 2011', 
                        'Vote share of CDU in 2011', 'Vote share of Greens in 2011', 
                        'Vote share of SPD in 2011', 'Vote share of FDP in 2011', 
                        'Vote share of Linke in 2011', 'High school ratio', 
                        'No high school degree', 'GDP per capita', 
                        'Unemployment rate', 'No. of refugees')


stargazer(Data[4:16],
title = 'Summary statistics of all variables',
covariate.labels = summary_labels,
font.size = 'small',
digit = 2, 
out = 'C:/Users/User/Documents/GitHub/Assignment03/tables/summary_statistics.tex')

#------------------------------------------------------------------------------#

