# Notes about installing R packages
# 	To install packages for all users ie : ec2-user, hadoop, rstudio shiny 
# 	we want to run the install as root.
# 	Additionally on EMR the root partition has very little space (9GB) so we need to be careful 
# 	about using space on /
# 	This command will install 
# 	R CMD INSTALL -l /path/to/library packagename

# 	sudo R CMD INSTALL -l /mnt/data/R-libs pracma
#		I've not had experience with this yet.  It requires getting the package AND the dependencies on the local system first.  

# 	Also we can specify the library location from R 
# 		 install.packages('rgl', repos="http://cran.r-project.org", lib="/mnt/data/R-libs")

#	There is a environment variable for setting the R path
# 		export R_LIBS="/mnt/data/R-libs"
# 	Setting this and running R install.packages('rgl', repos="http://cran.r-project.org") will install in the specified location
#	 .libPaths(); shows the library paths searched when looking for packages

# 	So you don't have to type it every time, put the export command in your .bashrc.more file or even better, put the following line in a file called .Renviron in your home directory:
#   R_LIBS="/home/your_username/R_libs"
#	 You can have several R library directories if you wish to separate differnt libraries.
#	 Just add these directories to the export line, or .Renviron file, like so:
#   export R_LIBS="/home/your_username/R_libs:/home/your_username/R_libs_biostat"
#	 Then, to specify the directory to install to use:
#   R CMD INSTALL -l lib_directory pkg_version.tar.gz
#	 where lib_directory gives the path to the library tree to install to.

install.packages("devtools")
install.packages("base64enc")

install.packages("sparklyr")

##Tidyverse
install.packages("broom") # Tidy model display - usage tidy(lm.fit)


#Markdown
install.packages("knitr")
install.packages("rmarkdown")
install.packages("pander") #Nice Table ouput for Markdown
install.packages("printr") # Should print matrices as LaTeX tables automatically in markdown
install.packages("stargazer")
install.packages('latex2exp') #LaTex In Plots : usage TeX("$ \\beata $")

####Shiny Development
install.packages("htmlwidgets")
install.packages("devtools")

###GGplot Solarized Themes
install.packages('ggthemes', dependencies = TRUE)

install.packages("formatR")

install.packages("MASS")
install.packages("car")
install.packages("plyr")

install.packages("ggplot2")
install.packages("ggfortify") # for plotting regression diagnostics - NICE! - see https://cran.r-project.org/web/packages/ggfortify/vignettes/plot_lm.html
install.packages("ggrepel") # Replel for text labels on plot  https://cran.r-project.org/web/packages/ggrepel/vignettes/ggrepel.html

install.packages("reshape2")

install.packages("pracma") #Functions from numerical analysis and linear algebra 

install.packages('moments')#Moments, cumulants, skewness, kurtosis and related tests

install.packages("outliers")

install.packages("RColorBrewer")

install.packages("foreach")
install.packages("doMC") # - Linux Parallel

install.packages("doSNOW") # Another Parallel Package

install.packages("vioplot") #Violin Plots
install.packages("GGally")
install.packages("Kendall")
install.packages("corrplot")

install.packages("compare")
install.packages("pracma")
 
install.packages("e1071") #You would not know this but this is the SVM in R
install.packages("caret")
install.packages("glmnet")

#ROC
install.packages("ROCR")

install.packages("scatterplot3d")

install.packages("rgl")

#Stochastic Neighbor Embedding
install.packages("tsne")
install.packages("Rtsne")

install.packages("neuralnet")

install.packages("class")
install.packages("rpart")  #Decision Tree Algorithm
install.packages("randomForest")
install.packages("gbm")
install.packages("mlbench")
install.packages("ggmap")
install.packages("corrgram")
install.packages("leaflet")
#install.packages("doSNOW") #Windows Parallel
install.packages("mixtools")

install.packages("hexbin")

#install.packages("Rgraphviz") - not available in standard repo
source("https://bioconductor.org/biocLite.R")
biocLite("Rgraphviz")

install.packages("bnlearn") #Graphical Models

# install.packages("devtools")
# devtools::install_github("rstudio/sparklyr")
install.packages("rattle")		#tree plot
install.packages("rpart.plot")				# Enhanced tree plots

#install.packages(party)					# Alternative decision tree algorithm
#install.packages(partykit)				# Convert rpart object to Binary

######### Linear Algebra Section
install.packages("Matrix")
install.packages("igraph")   #In addition to Arpack - this has an exensive collection of graph functionality

install.packages("RcppEigen")

######### Markov Chains

#See markov and mcmcm

install.packages("expm")
install.packages("markovchain")
install.packages("diagram")
install.packages("pracma")


# Several people have posted that RSQLite 2.0 breaks sqldf causing an error to be produced for nearly every sqldf statement run.
# Until that is resolved (1) use an older version of RSQLite or (2) use the RH2 (or other) backend or (3) use MySQL or PostgreSQL backends.
# The RH2 backend is the easiest to install since it only requires that you install java and the RH2 package - H2 itself is already included in RH2.   If RH2 is loaded sqldf will notice it and use it instead of SQLite.
# install java
#library(RH2)
#library(sqldf)
# can now issue sqldf statements using selects acceptable to H2
#H2 does have more builtin functions that SQLite and also has true date and datetime types which SQLite lacks.
#Until the new version of sqldf is loaded onto CRAN try using the github versoin of sqldf.

install.packages("devtools")
library(devtools)
# install_github("ggrothendieck/sqldf")

install.packages("sqldf")

#List all user installed packages 
ip <- as.data.frame(installed.packages()[,c(1,3:4)])
rownames(ip) <- NULL
ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
print(ip, row.names=FALSE)