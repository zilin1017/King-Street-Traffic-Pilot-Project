# Load necessary libraries
library(dplyr)


# Create binary variable for Bathurst and Jarvis intersections
data <- data %>%
  mutate(intersection_binary = ifelse(grepl("Bathurst|Jarvis", intersection_name, ignore.case = TRUE), 1, 0))

# Fit the regression model
model <- lm(volume ~ classification + intersection_binary, data = data)

# Summarize the model
summary(model)


data <- data %>%
  mutate(intersection_binary = ifelse(grepl("Bathurst|Jarvis", intersection_name, ignore.case = TRUE), 1, 0))

data$classification <- as.factor(data$classification)
model <- lm(volume ~ classification + intersection_binary, data = data)

summary(model)



library(dplyr)

data <- read.csv("path_to_data.csv")

data <- data %>%
  mutate(intersection_binary = ifelse(grepl("Bathurst|Jarvis", intersection_name, ignore.case = TRUE), 1, 0))


data$classification <- as.factor(data$classification)

model <- lm(volume ~ classification + intersection_binary, data = data)


residuals <- residuals(model)
fitted_values <- fitted(model)

plot(fitted_values, residuals,
     xlab = "Fitted Values",
     ylab = "Residuals",
     main = "Residuals vs Fitted Values")
abline(h = 0, col = "red")


hist(residuals, breaks = 30, main = "Histogram of Residuals", xlab = "Residuals", col = "blue")

qqnorm(residuals, main = "QQ Plot of Residuals")
qqline(residuals, col = "red")


summary(model)

influence <- influence.measures(model)
summary(influence)





data <- data %>%
  mutate(intersection_binary = ifelse(grepl("Bathurst|Jarvis", intersection_name, ignore.case = TRUE), 1, 0))

data$classification <- as.factor(data$classification)

model <- lm(volume ~ classification + intersection_binary, data = data)

residuals <- residuals(model)
fitted_values <- fitted(model)


plot(fitted_values, residuals,
     xlab = "Fitted Values",
     ylab = "Residuals",
     main = "Residuals vs Fitted Values")
abline(h = 0, col = "red")


sqrt_abs_residuals <- sqrt(abs(residuals))
plot(fitted_values, sqrt_abs_residuals,
     xlab = "Fitted Values",
     ylab = "Sqrt(|Residuals|)",
     main = "Scale-Location Plot")
abline(h = 0, col = "red")


qqnorm(residuals, main = "QQ Plot of Residuals")
qqline(residuals, col = "red")

hist(residuals, breaks = 30, main = "Histogram of Residuals", xlab = "Residuals", col = "blue")


library(dplyr)

data <- read.csv("path_to_data.csv")

data <- data %>%
  mutate(intersection_binary = ifelse(grepl("Bathurst|Jarvis", intersection_name, ignore.case = TRUE), 1, 0))


data$classification <- as.factor(data$classification)
data$period_name <- as.factor(data$period_name)

model <- lm(volume ~ classification + intersection_binary + period_name, data = data)

summary(model)



residuals <- residuals(model)
fitted_values <- fitted(model)

plot(fitted_values, residuals,
     xlab = "Fitted Values",
     ylab = "Residuals",
     main = "Residuals vs Fitted Values",
     pch = 20, col = "blue")
abline(h = 0, col = "red")

sqrt_abs_residuals <- sqrt(abs(residuals))
plot(fitted_values, sqrt_abs_residuals,
     xlab = "Fitted Values",
     ylab = "Sqrt(|Residuals|)",
     main = "Scale-Location Plot",
     pch = 20, col = "blue")
abline(h = 0, col = "red")

qqnorm(residuals, main = "QQ Plot of Residuals")
qqline(residuals, col = "red")

hist(residuals, breaks = 30, main = "Histogram of Residuals", xlab = "Residuals", col = "blue")

