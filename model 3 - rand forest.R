# Model Build - Random Forest model 1 ----------------------------------------------------

# Build Model ----------------------------------------------------------------------------

# take only training data (drop imputation info)
x <-
  train.data %>%
  select(1:17) %>% # take only main data (dropping any additional columns)
  select(-c('GroupNo', 'PersonNo', 'Deck', 'Room', 'Side', 'Name'))

# set reference level of DV to 'false'
x$Transported <- relevel(x$Transported, ref = "False")

# fit model (using ranger engine for modelling)
set.seed(47)

randForest.model1 <-
rand_forest(mode = "classification", trees = 2000) %>%
  set_engine("randomForest") %>%
  set_mode("classification") %>%
  fit(Transported ~ ., data = x)

# Interpret Model ------------------------------------------------------------------------

# # examine variable importance
# randomForest::varImpPlot(randForest.model1$fit)
# 
# # then examine rough direction of each variable?
# plot(train.data$Transported, train.data$Spa)
# 
# # spa was most important var
# ggplot(train.data, aes(x = Transported, y = Spa)) +
#   geom_violin(aes(fill = Transported)) +
#   theme_minimal()
# 
# # examine Cryosleep
# ggplot(train.data, aes(x = Transported, fill = CryoSleep)) +
#   geom_bar()
# 

# Build Evaluation Output ----------------------------------------------------------------

# match test data to training data
y <-
  test.data %>%
  select(1:17) %>% # take only main data (dropping any additional columns)
  select(-c('GroupNo', 'PersonNo', 'Deck', 'Room', 'Side', 'Name'))

# model predictions on test data
randForest.model1.predictions <- predict(randForest.model1, 
                                     new_data = test.data,
                                     type = "class")

# build evaluation df
randForest.model1.results <- 
  y %>% 
  select('Transported') %>%
  cbind(randForest.model1.predictions$.pred_class) %>%
  rename(., 'Transported prediction' = 'randForest.model1.predictions$.pred_class')


# Evaluate Model -------------------------------------------------------------------------

print(
  customEvaluationMetrics(randForest.model1.results, 
                          truth = 'Transported', 
                          estimate = 'Transported prediction')
)

# Model 3 random forest appeared to fit the data better than the log regression
# A tibble: 5 x 3
# .metric  .estimator .estimate
# <chr>    <chr>          <dbl>
# 1 accuracy binary         0.804
# 2 sens     binary         0.779
# 3 spec     binary         0.828
# 4 f_meas   binary         0.797
# 5 mcc      binary         0.608

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

  
