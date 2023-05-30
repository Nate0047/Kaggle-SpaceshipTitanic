# Import Environment ---------------------------------------------------------------------
source("environment setup.r")


# Import Data ----------------------------------------------------------------------------

# read in training data only (test set is for prediction submission)
titanic.data.import <- read.csv("data/train.csv", stringsAsFactors = TRUE)

# explore the data
#DataExplorer::create_report(titanic.data.import) # generate report on data quality

# split data into training and testing samples
set.seed(47)

split <- initial_split(titanic.data.import, prop = 0.80)
train.data <- training(split)
test.data <- testing(split)

rm(split, titanic.data.import)


# EDA ------------------------------------------------------------------------------------

#source("EDA - training.r") - led to cleaning functions

# build PowerBI dashboard to explore data
#write.csv(train.data, "powerbi/train data.csv")

# Cleaning Train and Test ----------------------------------------------------------------

# read in cleaning functions from EDA
source("cleaning functions.r")

# apply cleaning functions to train and test data
train.data %<>%
  emptyStringstoMissing.fun() %>%
  hdImpute.fun()

test.data %<>%
  emptyStringstoMissing.fun() %>%
  hdImpute.fun()


# Model 1 fitting and diagnostics --------------------------------------------------------

# log reg model on cleaned data
source("Model 1 - OG Log Reg.r", verbose = TRUE)

# apply model 1 predictions to kaggle competition test submission data
source("kaggle submission 1 - log reg model 1.r")

# remove all info relating to model 1
rm(x, y, logreg.model1, logreg.model1.predictions, logreg.model1.results,
   kaggleSubmission.data, kaggleSubmission.model1)

# scored 78.629% accuracy on Kaggle leaderboard


# Feature Engineering --------------------------------------------------------------------

# separate passenger ID and Cabin ID - function from Feature Engineering file
source("Feature Engineering.r")

# apply separation function to train and test data
train.data %<>%
  IDandCabinSeparator.fun() %>%
  mutate(across(where(is.character), as.factor))

test.data %<>%
  IDandCabinSeparator.fun() %>%
  mutate(across(where(is.character), as.factor))


# Model 2 fitting and diagnostics --------------------------------------------------------

# log reg model on cleaned and engineered data
source("Model 2 - Engineered Log Reg.r")

# apply model 2 predictions to kaggle competition test submission data
source("kaggle submission 2 - log reg model 2.r")

rm(x, y, logreg.model2, logreg.model2.predictions, logreg.model2.results,
   kaggleSubmission.data, kaggleSubmission.model2)

# scored 78.559% accuracy on Kaggle leaderboard - comparable to model 1


# Alternative Models ---------------------------------------------------------------------

# random forest (original data) ----------------------------------------------------------

# fit random forest to the data
source("Model 3 - OG Rand Forest.r")

# apply model 3 predictions to kaggle competition test submission data
source("kaggle submission 3 - rand forest model 3.r")

rm(x, y, randForest.model1, randForest.model1.predictions, randForest.model1.results,
   kaggleSubmission.data, kaggleSubmission.model3)

# scored 79.214% accuracy on Kaggle leaderboard - best model yet, but still not ideal








