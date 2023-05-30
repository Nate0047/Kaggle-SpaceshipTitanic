# Kaggle Submission - Logreg.Model2 ------------------------------------------------------

# read in test data for submission
kaggleSubmission.data <- read.csv("data/test.csv")

# pass through cleaning pipeline
kaggleSubmission.data %<>%
  emptyStringstoMissing.fun() %>%
  hdImpute.fun() %>%
  select(1:13) # drop imputation info

# seperate off new PassengerId var before engineering
PassengerId <- kaggleSubmission.data$PassengerId

# pass through feature engineering pipeline
kaggleSubmission.data %<>%
  IDandCabinSeparator.fun() %>%
  mutate(across(where(is.character), as.factor))

# apply predictive model to submission data
kaggleSubmission.model2 <- predict(logreg.model2, 
                                   new_data = kaggleSubmission.data,
                                   type = "class")

# apply model predictions to data
kaggleSubmission.data %>%
  cbind(PassengerId, kaggleSubmission.model2) %>%
  rename(., 'Transported' = '.pred_class') %>%
  select('PassengerId', 'Transported') %>% # format for Kaggle submission
  write.csv(., "submissions/kaggle submission - model 2 - log reg.csv", row.names = FALSE)
