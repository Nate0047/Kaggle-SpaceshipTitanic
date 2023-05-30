# Model Build - logreg.model2 ------------------------------------------------------------

# Build Model ----------------------------------------------------------------------------

# take only training data (drop imputation info)
x <-
  train.data %>%
  select(1:17) %>% # take only main data (dropping any additional columns)
  select(-c('GroupNo', 'Room', 'Name'))

# set reference level of DV to 'false'
x$Transported <- relevel(x$Transported, ref = "False")

# fit model
set.seed(47)

logreg.model2 <- logistic_reg() %>%
  set_engine("glm") %>%
  set_mode("classification") %>%
  fit(Transported ~ ., data = x)

# model output (with exp to see odds ratio)
tidy(logreg.model2, exponentiate = TRUE)

# filter output to only variables p < .05
tidy(logreg.model2, exponentiate = TRUE) %>%
  filter(p.value < 0.05) # pretty much all variables significant apart from VIP


# Build Evaluation Output ----------------------------------------------------------------

# match test data to training data
y <-
  test.data %>%
  select(1:17) %>% # take only main data (dropping any additional columns)
  select(-c('GroupNo', 'Room', 'Name'))

# model predictions on test data
logreg.model2.predictions <- predict(logreg.model2, 
                                     new_data = test.data,
                                     type = "class")

# build evaluation df
logreg.model2.results <- 
  y %>% 
  select('Transported') %>%
  cbind(logreg.model2.predictions$.pred_class) %>%
  rename(., 'Transported prediction' = 'logreg.model2.predictions$.pred_class')


# Evaluate Model -------------------------------------------------------------------------

print(
  customEvaluationMetrics(logreg.model2.results, 
                          truth = 'Transported', 
                          estimate = 'Transported prediction')
)

# Model 2 with the engineered features provides comparable performance to previous model
# # A tibble: 5 x 3
# .metric  .estimator .estimate
# <chr>    <chr>          <dbl>
# 1 accuracy binary         0.791
# 2 sens     binary         0.781
# 3 spec     binary         0.802
# 4 f_meas   binary         0.787
# 5 mcc      binary         0.582

# first model results
# # A tibble: 5 x 3
# .metric  .estimator .estimate
# <chr>    <chr>          <dbl>
# 1 accuracy binary         0.788
# 2 sens     binary         0.784
# 3 spec     binary         0.793
# 4 f_meas   binary         0.785
# 5 mcc      binary         0.577








