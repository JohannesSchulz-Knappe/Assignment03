#######################################################################
# MPP-E1180: Introduction to Collaborative Social Science Data Analysis
# Assignment03
# Analysis
# Md Mujahedul Islam 
# Update 27 April 2016
# Hertie School of Governance
#######################################################################


#-----------------------------------------#
# 1. Prepare the workspace                #
#-----------------------------------------#

## 1.1 Clear the environment

rm(list = ls())


## 1.2 Load packages for data analysis

# Create vector of used packages
packages <- c("repmis", "plyr", "xtable", "texreg", "stargazer", 
              "magrittr", "readstata13", "ggplot2", "reshape")

# Install packages that are not already installed
for (p in packages) {
  if (p %in% installed.packages()[,1]) require(p, character.only=TRUE)
  else {
    install.packages(p)
    require(p, character.only=TRUE)
  }
}
rm(p)

# Load packages
loaded <- lapply(packages, require, character.only = TRUE)
rm(loaded)


## 1.3 Set the working directory

# Create list of commonly used working directories (update, if needed)
possible_dir <- c('C:/Users/Johannes SK/Dropbox/Studium/Spring2016/CollaborativeResearch/Assignment03',
                  'C:/Users/User/Documents/GitHub/Assignment03')

# Set to first valid directory in the possible_dir vector
set_valid_wd(possible_dir)

# remove possible_dir vector
rm(possible_dir)


## 1.4 Create bibTeX file for the used packages

LoadandCite(packages, file = 'Packages2.bib')
rm(packages)


## 1.5 Create and load the dataset

load('Data.Rda')


#--------------------------------------#
# 2. Descriptive Statistics            #
#--------------------------------------#


## 2.1 Mean values

# Create mean values for variables
mean(Data$vote.AfD, na.rm = TRUE)
mean(Data$GDP.capita, na.rm = TRUE)
mean(Data$unempl.rate, na.rm = TRUE)
mean(Data$nodegree.ratio, na.rm = TRUE)
mean(Data$n.refugees, na.rm = TRUE)
mean(Data$abitur.ratio, na.rm = TRUE)

# Loop function for finding "mean" for all the variables
for (i in 4:length(names(Data))) {
  Data[, i] %>%
    mean() %>%
    round(digits = 2) %>%
    paste(names(Data)[i], ., '\n') %>% # the . directs the 
    cat()
}


## 2.2 Summary statistics of all variables

# Assign variable labels
summary_labels <- c('Vote share of AfD in 2016', 'Vote turnout in 2011', 
                    'Vote share of CDU in 2011', 'Vote share of Greens in 2011', 
                    'Vote share of SPD in 2011', 'Vote share of FDP in 2011', 
                    'Vote share of Linke in 2011', 'High school ratio', 
                    'No degree ratio', 'GDP per capita', 
                    'Unemployment rate', 'Number of refugees')

# Create summary statistics table
stargazer(Data[4:16],
          title = 'Summary statistics of all variables',
          covariate.labels = summary_labels,
          font.size = 'small',
          digit = 2, 
          out = 'outputs/tables/summary_statistics.tex')


## 2.3 Histograph using ggplot to show frequency distribution of the number of refugees

ggplot(Data) +
  geom_histogram(aes(x = n.refugees),
                 colour = "black",
                 fill = "transparent",
                 binwidth = 30) +
  ylab("Frequency") +
  xlab("Number of refugees per district") +
  theme_light()


## 2.4 AfD vote share by district

ggplot(Data) +
  geom_bar(aes(y = vote.AfD, x = reorder(district.name, -vote.AfD)), 
           stat = "identity") +
  ylab("AfD vote share") +
  xlab("Districts of BW, RP, and SA") +
  ggtitle("Vote share of AfD in districts of BW, RP, and SA") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90))
  out = 'outputs/figures/AfD_voteshare_in_RP_BW_SA.pdf'


## 2.5 Correlation matrix in table format
  
correlation.matrix <- cor(Data[, c("vote.AfD","lag.CDU",
                                   "lag.SPD","GDP.capita",
                                   "unempl.rate","n.refugees",
                                   "abitur.ratio")])

stargazer(correlation.matrix, 
          title = "Correlation Matrix",
          font.size = 'small',
          out = 'outputs/tables/correlation_matrix.tex')
  


#--------------------------------------#
# 3. Initial correlation analysis      #
#--------------------------------------#


## 3.1 Correlation of AfD's vote share and unemployment rate

# The result shows statistically significant positve 
# correlation of increase in unemployment rate with 
# the increase in AfD vote share in the three states

ggplot2::ggplot(Data, aes(log(x = unempl.rate), vote.AfD)) + 
  xlab("Unemployment rate in RP, BW, and SA") +
  ylab("AfD vote share (in %)") +
  geom_point() + geom_smooth() + 
  theme_bw()

# Test for statistical significance of above correlation
cor.test(log(Data$vote.AfD), Data$unempl.rate)



## 3.2 Correlation of AfD vote share and GDP per capita

# The result shows statistically significant negative 
# coorelation of increase in Per capita GDP 
# with AfD vote share

ggplot2::ggplot(Data,aes(log(x = GDP.capita), vote.AfD)) + 
  xlab("GDP per capita in RP, BW, and SA") +
  ylab("AfD vote share (in %)") +
  geom_point() + geom_smooth() + 
  theme_bw()

# Test for statistical significance of above correlation
cor.test(log(Data$vote.AfD), Data$GDP.capita)



## 3.3 Correlation of AfD vote share and No. of Refugees

# The result shows positive coorelation of 
# increase no. of refugees with with AfD's vote share, 
# though it is not statistically significant (most likely 
# due to outdated refugee numbers)

ggplot2::ggplot(Data,aes(log(x = n.refugees), vote.AfD)) + 
  xlab("Number of refugees in RP, BW, and SA") +
  ylab("AfD vote share (in %)") +
  geom_point() + geom_smooth() + 
  theme_light()

# Test for statistical significance of above correlation
cor.test(log(Data$vote.AfD), Data$n.refugees)



#--------------------------------------#
# 4. Inferential Analysis              #
#--------------------------------------#

# Create series of regression models
reg1 <- lm(vote.AfD ~ GDP.capita + unempl.rate + n.refugees, data = Data)
reg2 <- lm(vote.AfD ~ GDP.capita + unempl.rate + n.refugees + lag.CDU + 
             lag.SPD + lag.turnout, data = Data)
reg3 <- lm(vote.AfD ~ GDP.capita + unempl.rate + n.refugees + 
             abitur.ratio + nodegree.ratio, data = Data)
reg4 <- lm(vote.AfD ~ GDP.capita + unempl.rate + n.refugees 
           + lag.CDU + lag.SPD + lag.turnout + abitur.ratio + 
             nodegree.ratio, data = Data)

# Assign variable labels
var_labels <- c('GDP per capita', 'Unemployment rate', 'No. of Refugees', 
            'Vote share of CDU in 2011 election',
            'Vote share of SPD in 2011 election',
            'High School Ratio', 'University Degree ratio', '(Intercept)')

# Create regression table
stargazer::stargazer(reg1, reg2, reg3, reg4,
          omit = 'as.factor*', 
          omit.stat = c('f', 'ser'), # to nicely fits on the page
          out.header = F,
          title = 'Determinants of the vote share of the Alternative for Germany',
          dep.var.labels = 'Vote share of AfD',
          covariate.labels = var_labels,
          label = 'AfD_voteshare',
          add.lines = list(c('District FE?', rep('NO', 4))),
          font.size = 'small',
          digit = 2, 
          out = 'outputs/tables/afd_voteshare_regressions.tex')