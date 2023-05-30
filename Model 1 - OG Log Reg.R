# Model Build - logreg.model1 ------------------------------------------------------------

# Build Model ----------------------------------------------------------------------------

# take only training data (drop imputation info)
x <-
train.data %>%
  select(1:14) %>% # take only main data (dropping any additional columns)
  select(-c('PassengerId', 'Cabin', 'Name'))

# set reference level of DV to 'false'
x$Transported <- relevel(x$Transported, ref = "False") 

# fit model
set.seed(47)

logreg.model1 <- logistic_reg() %>%
  set_engine("glm") %>%
  set_mode("classification") %>%
  fit(Transported ~ ., data = x)

# model output (with exp to see odds ratio)
tidy(logreg.model1, exponentiate = TRUE)

# filter output to only variables p < .05
tidy(logreg.model1, exponentiate = TRUE) %>%
  filter(p.value < 0.05) # pretty much all variables significant apart from VIP


# Build Evaluation Output ----------------------------------------------------------------

# match test data to training data
y <-
  test.data %>%
  select(1:14) %>% # take only main data (dropping any additional columns)
  select(-c('PassengerId', 'Cabin', 'Name'))

# model predictions on test data
logreg.model1.predictions <- predict(logreg.model1, 
                                     new_data = test.data,
                                     type = "class")

# build evaluation df
logreg.model1.results <- 
y %>% 
  select('Transported') %>%
  cbind(logreg.model1.predictions$.pred_class) %>%
  rename(., 'Transported prediction' = 'logreg.model1.predictions$.pred_class')
  

# Evaluate Model -------------------------------------------------------------------------

# develop custom metric to pull all evaluation metrics to one output
customEvaluationMetrics <- metric_set(accuracy, sens, spec, f_meas, mcc)

print(
customEvaluationMetrics(logreg.model1.results, 
                        truth = 'Transported', 
                        estimate = 'Transported prediction')
)

# Overall, model is a fair fit of the test data. See if we can improve on this
# # A tibble: 5 x 3
# .metric  .estimator .estimate
# <chr>    <chr>          <dbl>
# 1 accuracy binary         0.788
# 2 sens     binary         0.784
# 3 spec     binary         0.793
# 4 f_meas   binary         0.785
# 5 mcc      binary         0.577








