# Library --------------------------------------------------------------------------------
.libPaths("C:/R library")

# Options --------------------------------------------------------------------------------
options(scipen = 999)

# Packages -------------------------------------------------------------------------------
if(!require("tidyverse")) {install.packages("tidyverse")}
library(tidyverse) # v.1.3.2 - for general functionality
library(magrittr) # v.2.0.3 - pipe

if(!require("DataExplorer")) {install.packages("DataExplorer")}
library(DataExplorer) # v.0.8.2 - quick diagnostics on data

if(!require("tidymodels")) {install.packages("tidymodels")}
library(tidymodels) # v.1.0.0 - main package for model creation

if(!require("VIM")) {install.packages("VIM")}
library(VIM) # v.6.2.2 # can't remember why this is needed - review

if(!require("visreg")) {install.packages("visreg")}
library(visreg) # v.2.7.0 # to visualise regression? need to explore this

if(!require("rpart.plot")) {install.packages("rpart.plot")}
library(rpart.plot) # v.3.1.1 - to visualise decision tree


#utils::packageVersion("")

