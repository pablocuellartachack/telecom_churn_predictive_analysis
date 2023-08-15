# Loading necessary libraries
install.packages(c("tidyverse", "caret", "rpart", "rpart.plot", "randomForest", "xgboost", "pROC"))
library(tidyverse)
library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)
library(xgboost)
library(pROC)


# Loading data
data <- read.csv("Raw_Data/Raw_Data.csv")

# Data Pre-processing

# Convert 'Yes' and 'No' in 'Churn' column to 1 and 0
data$Churn <- ifelse(data$Churn == "Yes", 1, 0)

# Create dummy variables for categorical columns
dummy_vars <- c('gender', 'Partner', 'Dependents', 'PhoneService', 'MultipleLines', 
                'InternetService', 'OnlineSecurity', 'OnlineBackup', 'DeviceProtection', 
                'TechSupport', 'StreamingTV', 'StreamingMovies', 'Contract', 
                'PaperlessBilling', 'PaymentMethod')

data <- data %>%
  mutate(across(all_of(dummy_vars), as.factor)) %>%
  dplyr::select(-c(customerID)) %>%
  mutate(across(everything(), as.numeric))

# Convert 'Churn' back to factor for modeling
data$Churn <- as.factor(data$Churn)

# Splitting the dataset into training and testing sets
set.seed(123)
trainIndex <- createDataPartition(data$Churn, p = .8, 
                                  list = FALSE, 
                                  times = 1)

dataTrain <- data[ trainIndex,]
dataTest  <- data[-trainIndex,]

# Checking for NULL values in cols
colnames(dataTrain)[colSums(is.na(dataTrain)) > 0]
median_train <- median(dataTrain$TotalCharges, na.rm = TRUE)
dataTrain$TotalCharges[is.na(dataTrain$TotalCharges)] <- median_train

median_test <- median(dataTest$TotalCharges, na.rm = TRUE)
dataTest$TotalCharges[is.na(dataTest$TotalCharges)] <- median_test

# Decision tree model #
tree_model <- rpart(Churn ~ ., data = dataTrain, method = "class")
rpart.plot(tree_model, main="Decision Tree for Customer Churn")

# Predictions using decision tree
tree_predictions <- predict(tree_model, dataTest, type = "prob")[,2]
roc_curve_tree <- roc(dataTest$Churn, tree_predictions)
auc_tree <- auc(roc_curve_tree)

# Random forest model #
rf_model <- randomForest(Churn ~ ., data = dataTrain)
rf_predictions <- predict(rf_model, dataTest, type = "response")
roc_curve_rf <- roc(dataTest$Churn, as.numeric(rf_predictions))
auc_rf <- auc(roc_curve_rf)

plot_rf_importance <- function(rf_model) {
importance_data <- as.data.frame(randomForest::importance(rf_model))
p <- ggplot(importance_data, aes(x = reorder(rownames(importance_data), MeanDecreaseGini), y = MeanDecreaseGini)) +
     geom_bar(stat = "identity", fill = "lightgreen") +
             coord_flip() + 
             theme_minimal() +
             labs(title = "Random Forest Variable Importance",
             x = "Variables",
             y = "Mean Decrease Gini") +
             theme(text = element_text(size=12),
             axis.title.y = element_text(vjust = 2))
  return(p)
}

plot_rf_importance(rf_model)

# XGBoost model #
xgb_data <- xgb.DMatrix(data = as.matrix(dataTrain[,-which(names(dataTrain) == "Churn")]), label = as.numeric(dataTrain$Churn) - 1)
xgb_test <- xgb.DMatrix(data = as.matrix(dataTest[,-which(names(dataTest) == "Churn")]), label = as.numeric(dataTest$Churn) - 1)
xgb_model <- xgb.train(data = xgb_data, objective = "binary:logistic", nrounds = 100)
xgb_predictions <- predict(xgb_model, newdata = xgb_test)
roc_curve_xgb <- roc(as.numeric(dataTest$Churn) - 1, xgb_predictions)
auc_xgb <- auc(roc_curve_xgb)

plot_custom_xgb_importance <- function(xgb_model) {
importance_matrix <- xgb.importance(model = xgb_model)
ordered_features <- importance_matrix[order(importance_matrix$Gain, decreasing = FALSE), ]
par(mar = c(5, 9, 4, 2) + 0.1)
barplot(ordered_features$Gain, 
        names.arg = ordered_features$Feature, 
        las = 2,
        main = "XGBoost Variable Importance",
        col = "#1f77b4",
        xlim = c(0, 0.3),
        horiz = TRUE,
        cex.names = 0.7,
        border = "white")
  title(xlab = "Mean Gain", line = 3)
  title(ylab = "Features", line = 7)
}

plot_custom_xgb_importance(xgb_model)

# Model evaluation summary
cat(paste0("AUC for Decision Trees: ", auc_tree, "\n"))
cat(paste0("AUC for Random Forest: ", auc_rf, "\n"))
cat(paste0("AUC for XGBoost: ", auc_xgb, "\n"))

# Data frame with the AUC values and plotting the AUC values
auc_data <- data.frame(
  Model = c("Decision Trees", "Random Forest", "XGBoost"),
  AUC = c(auc_tree, auc_rf, auc_xgb)
)
library(ggplot2)
plot_auc_comparison <- function(auc_data) {
  p <- ggplot(auc_data, aes(x = Model, y = AUC, fill = Model)) +
       geom_bar(stat = "identity") +
               theme_minimal() +
               labs(title = "Model AUC Comparison", y = "AUC Value") +
               theme(legend.position = "none") + 
               theme(text = element_text(size=12),
               axis.title.y = element_text(vjust = 2))
  return(p)
}

plot_auc_comparison(auc_data)

# Plotting all models and evaluation summary
rpart.plot(tree_model, main="Decision Tree for Customer Churn")
plot_rf_importance(rf_model)
plot_custom_xgb_importance(xgb_model)
plot_auc_comparison(auc_data)

