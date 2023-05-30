# Kaggle Submission - randForest.model1  -------------------------------------------------

# read in test data for submission
kaggleSubmission.data <- read.csv("data/test.csv")

# pass through cleaning pipeline
kaggleSubmission.data %<>%
  emptyStringstoMissing.fun() %>%
  hdImpute.fun() %>%
  select(1:13) # drop imputation info

# apply predictive model to submission data
kaggleSubmission.model3 <- predict(randForest.model1, 
                                   new_data = kaggleSubmission.data,
                                   type = "class")

# apply model predictions to data
kaggleSubmission.data %>%
  cbind(kaggleSubmission.model3) %>%
  rename(., 'Transported' = '.pred_class') %>%
  select('PassengerId', 'Transported') %>% # format for Kaggle submission
  write.csv(., "submissions/kaggle submission - model 3 - rand forest.csv", row.names = FALSE)