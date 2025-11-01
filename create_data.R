# Script to create sample dataset
# Run this in R to generate the expert_data.rda file

set.seed(123)

# Generate realistic expert responses (27 experts, 10 items)
expert_data <- data.frame(
  Item1 = sample(c(4, 5), 27, replace = TRUE, prob = c(0.3, 0.7)),
  Item2 = sample(c(4, 5), 27, replace = TRUE, prob = c(0.4, 0.6)),
  Item3 = sample(c(4, 5), 27, replace = TRUE, prob = c(0.35, 0.65)),
  Item4 = sample(c(3, 4, 5), 27, replace = TRUE, prob = c(0.1, 0.4, 0.5)),
  Item5 = sample(c(4, 5), 27, replace = TRUE, prob = c(0.45, 0.55)),
  Item6 = sample(c(3, 4, 5), 27, replace = TRUE, prob = c(0.2, 0.5, 0.3)),
  Item7 = sample(c(2, 3, 4, 5), 27, replace = TRUE, prob = c(0.1, 0.2, 0.4, 0.3)),
  Item8 = sample(c(3, 4, 5), 27, replace = TRUE, prob = c(0.3, 0.4, 0.3)),
  Item9 = sample(c(2, 3, 4, 5), 27, replace = TRUE, prob = c(0.05, 0.25, 0.45, 0.25)),
  Item10 = sample(c(3, 4, 5), 27, replace = TRUE, prob = c(0.15, 0.5, 0.35))
)

# Save to data directory
save(expert_data, file = "data/expert_data.rda")
cat("Sample dataset created successfully at data/expert_data.rda\n")
