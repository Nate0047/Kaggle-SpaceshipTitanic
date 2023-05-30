# Kaggle Submission - Logreg.Model1 ------------------------------------------------------

# read in test data for submission
kaggleSubmission.data <- read.csv("data/test.csv")

# pass through cleaning pipeline
kaggleSubmission.data %<>%
  emptyStringstoMissing.fun() %>%
  hdImpute.fun() %>%
  select(1:13) # drop imputation info

# apply predictive model to submission data
kaggleSubmission.model1 <- predict(logreg.model1, 
                                   new_data = kaggleSubmission.data,
                                   type = "class")

# apply model predictions to data
kaggleSubmission.data %>%
  cbind(kaggleSubmission.model1) %>%
  rename(., 'Transported' = '.pred_class') %>%
  select('PassengerId', 'Transported') %>% # format for Kaggle submission
  write.csv(., "submissions/Kaggle Submission - log reg model 1.csv", row.names = FALSE)
