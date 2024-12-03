

# Load necessary libraries
library(ggplot2)
library(readxl)
library(dplyr)

# Preprocessing: Summarize volume data by classification and time period
summary_data <- data %>%
  group_by(classification, period_name) %>%
  summarise(total_volume = sum(volume, na.rm = TRUE)) %>%
  arrange(desc(total_volume))


# Visualization 2: Average volume by intersection
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

# Visualization 3: Volume distribution by direction
direction_summary <- data %>%
  group_by(dir, classification) %>%
  summarise(total_volume = sum(volume, na.rm = TRUE)) %>%
  arrange(desc(total_volume))

ggplot(direction_summary, aes(x = dir, y = total_volume, fill = classification)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Total Volume by Direction and Classification",
       x = "Direction",
       y = "Total Volume",
       fill = "Classification") +
  theme_minimal()

# Save the plots
ggsave("volume_by_time_period.png")
ggsave("volume_by_intersection.png")
ggsave("volume_by_direction.png")

library(ggbeeswarm)


filtered_data <- data %>%
  filter(classification %in% c("Pedestrians", "Vehicles", "Cyclists"))

bar_data <- filtered_data %>%
  group_by(classification) %>%
  summarise(total_volume = sum(volume, na.rm = TRUE))

ggplot(bar_data, aes(x = classification, y = total_volume, fill = classification)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Volume by Classification",
       x = "Classification",
       y = "Total Volume") +
  theme_minimal()

ggplot(filtered_data, aes(x = volume, fill = classification)) +
  geom_density(alpha = 0.5) +
  labs(title = "Density Plot of Volume by Classification",
       x = "Volume",
       y = "Density") +
  theme_minimal()

ggplot(filtered_data, aes(x = classification, y = volume, fill = classification)) +
  geom_violin(trim = FALSE, alpha = 0.7) +
  labs(title = "Violin Plot of Volume by Classification",
       x = "Classification",
       y = "Volume") +
  theme_minimal()

ggplot(filtered_data, aes(x = classification, y = volume, color = classification)) +
  geom_beeswarm(alpha = 0.7) +
  labs(title = "Bee Swarm Plot of Volume by Classification",
       x = "Classification",
       y = "Volume") +
  theme_minimal()
