data <- data %>%
  mutate(intersection_binary = ifelse(grepl("Bathurst|Jarvis", intersection_name, ignore.case = TRUE), 1, 0))

data$classification <- as.factor(data$classification)
data$period_name <- as.factor(data$period_name)

data$log_volume <- log(data$volume + 1)  

log_model <- lm(log_volume ~ classification + intersection_binary + period_name, data = data)

#summary(log_model)

residuals <- residuals(log_model)
fitted_values <- fitted(log_model)
par(mfrow = c(2, 2))  

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

par(mfrow = c(1, 1))  