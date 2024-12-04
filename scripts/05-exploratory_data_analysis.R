#### Preamble ####
# Purpose: Summarize volume data by classification and time period, and visulize each plots with each factors to traffic volume.
# Author: Irene Liu
# Date: 20 November 2024
# Contact: liuzilin.liu@mail.utornto.ca
# License: MIT
# Pre-requisites: The `dplyer`, `ggplot2` packages must be installed.


# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()

# Box plot for volume distribution by intersection
ggplot(data, aes(x = intersection_name, y = volume)) +
  geom_boxplot(aes(fill = intersection_name), show.legend = FALSE) +
  labs(title = "Volume Distribution by Intersection",
       x = "Intersection Name",
       y = "Traffic Volume") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Preprocessing: Summarize volume data by classification and time period
summary_data <- data %>%
  group_by(classification, period_name) %>%
  summarise(total_volume = sum(volume, na.rm = TRUE)) %>%
  arrange(desc(total_volume))


# Visualization : Average volume by intersection
intersection_summary <- data %>%
  group_by(intersection_name, classification) %>%
  summarise(avg_volume = mean(volume, na.rm = TRUE)) %>%
  arrange(desc(avg_volume))

ggplot(intersection_summary, aes(x = reorder(intersection_name, avg_volume), y = avg_volume, fill = classification)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Average Volume by Intersection and Classification",
       x = "Intersection",
       y = "Average Volume",
       fill = "Classification") +
  coord_flip() +
  theme_minimal()

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
