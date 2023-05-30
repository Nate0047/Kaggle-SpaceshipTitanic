# Library --------------------------------------------------------------------------------
.libPaths("C:/R library")

# Options --------------------------------------------------------------------------------
options(scipen = 999)

# Packages -------------------------------------------------------------------------------
if(!require("tidyverse")) {install.packages("tidyverse")}
library(tidyverse) # v.1.3.2
library(magrittr) # v.2.0.3

if(!require("DataExplorer")) {install.packages("DataExplorer")}
library(DataExplorer) # v.0.8.2

if(!require("tidymodels")) {install.packages("tidymodels")}
library(tidymodels) # v.1.0.0

if(!require("VIM")) {install.packages("VIM")}
library(VIM) # v.6.2.2

if(!require("visreg")) {install.packages("visreg")}
library(visreg) # v.2.7.0

#utils::packageVersion("")

