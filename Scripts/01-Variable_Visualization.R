## Volume Distribution by Intersection

# Load necessary libraries
library(ggplot2)
library(dplyr)
library(readxl)

# Summarize data by intersection
intersection_summary <- data %>%
  group_by(intersection_name) %>%
  summarise(total_volume = sum(volume, na.rm = TRUE),
            mean_volume = mean(volume, na.rm = TRUE),
            volume_sd = sd(volume, na.rm = TRUE)) %>%
  arrange(desc(total_volume))


# Box plot for volume distribution by intersection
ggplot(data, aes(x = intersection_name, y = volume)) +
  geom_boxplot(aes(fill = intersection_name), show.legend = FALSE) +
  labs(title = "Volume Distribution by Intersection",
       x = "Intersection Name",
       y = "Traffic Volume") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Volume Distribution by Classification

# Filter the data to ensure "volume" is numeric and relevant classifications are included
classification_summary <- data %>%
  mutate(volume = as.numeric(volume)) %>%
  filter(classification %in% c("Pedestrians", "Cyclists", "Vehicles"))

# Box plot: Volume distribution by classification
ggplot(classification_summary, aes(x = classification, y = volume, fill = classification)) +
  geom_boxplot(outlier.colour = "red", outlier.size = 2) +
  labs(title = "Volume Distribution by Classification",
       x = "Classification",
       y = "Volume") +
  theme_minimal()

## Volume Distribution by Period_Name

# Box plot: Traffic volume distribution by period_name
ggplot(data, aes(x = period_name, y = as.numeric(volume), fill = period_name)) +
  geom_boxplot(outlier.colour = "red", outlier.size = 2) +
  labs(title = "Traffic Volume Distribution by Period Name",
       x = "Period Name",
       y = "Volume") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1), 
    legend.position = "bottom",                      
    legend.title = element_text(size = 10),           
    legend.text = element_text(size = 8)              
  ) +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE))  
