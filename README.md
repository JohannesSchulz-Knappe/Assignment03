# Assignment 3 - MPP-E1180: Introduction to Collaborative Social Science Data Analysis

### Spring 2016

**Version: 27 April 2016**

#### By: Md Mujahedul Islam & Johannes Schulz-Knappe

### Description of the project progress

This repository is created for the third pair assignment of the course [MPP-E1180: Introduction to Collaborative Social Science Data Analysis](https://github.com/HertieDataScience/SyllabusAndLectures), taught by [Christopher Gandrud](https://github.com/christophergandrud). This readme file describes our work done for this assignment.

The task for this assignment was to gather web based data from at least two sources, merge the data sets, conduct basic inferential statistics on the data to address our research question and to briefly describe the results including with dynamically generated tables and figures.


### Documents in the repository

Besides this readme, there are 7 main files in the repository

- [Assignment03.pdf](https://github.com/JohannesSchulz-Knappe/Assignment03/blob/master/Assignment03.pdf) is the main analysis document in pdf-format.
- [Assignment03.Rmd](https://github.com/JohannesSchulz-Knappe/Assignment03/blob/master/Assignment03.RMD) is a markup document which contains the analysis and R code chunks in raw format.
- [Data.Rda](https://github.com/JohannesSchulz-Knappe/Assignment03/blob/master/Data.Rda) is our data set. It contains 15 variables on 94 observations. 
- [1_Data.R](https://github.com/JohannesSchulz-Knappe/Assignment03/blob/master/1_Data.R) is the R file that contains all our data gathering, cleaning, and merging work. Run this file to update the dataset.
- [2_Analysis.R](https://github.com/JohannesSchulz-Knappe/Assignment03/blob/master/2_Analysis.R) is the R file that separately contains all analysis we performed on the dataset
- [Packages1.bib](https://github.com/JohannesSchulz-Knappe/Assignment03/blob/master/Packages1.bib) and [Packages2.bib](https://github.com/JohannesSchulz-Knappe/Assignment03/blob/master/Packages2.bib) are two bibTeX libraries that list the packages we used for 1) the data collection, and 2) the analysis.

Furthermore, there are four folders. The [data_gathering](https://github.com/JohannesSchulz-Knappe/Assignment03/tree/master/data_gathering) folder contains the two R files that gather and scrape our datasets, while the [data_cleaning](https://github.com/JohannesSchulz-Knappe/Assignment03/tree/master/data_cleaning) folder contains the two R files that clean the election and the structural data. The [1_Data.R](https://github.com/JohannesSchulz-Knappe/Assignment03/blob/master/1_Data.R) file has to have access to those folders in order to run the data collection.
The [data_raw](https://github.com/JohannesSchulz-Knappe/Assignment03/tree/master/data_raw) folder contains the structural data sets that were manually downloaded from the Genesis-Online database. And finally, the [outputs](https://github.com/JohannesSchulz-Knappe/Assignment03/tree/master/outputs) folder contains two subfolders - [figures](https://github.com/JohannesSchulz-Knappe/Assignment03/tree/master/outputs/figures) and [tables](https://github.com/JohannesSchulz-Knappe/Assignment03/tree/master/outputs/tables) - where we stored the tables and figures we created in our analysis.