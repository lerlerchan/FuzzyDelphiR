# FuzzyDelphiR Quick Reference

## Installation

```r
# Install dependencies
install.packages(c("devtools", "roxygen2"))

# Create sample data
setwd("C:/Users/LerLerChan/Documents/GitHub/FuzzyDelphiR")
source("create_data.R")

# Generate documentation
library(roxygen2)
roxygenise()

# Install package
setwd("..")
devtools::install("FuzzyDelphiR")
```

## Basic Usage

```r
library(FuzzyDelphiR)

# Quick analysis
data(expert_data)
results <- fuzzy_delphi(expert_data, likert_scale = 5)
print(results)
```

## Main Functions

| Function | Purpose |
|----------|---------|
| `fuzzy_delphi()` | Complete analysis (recommended) |
| `likert5_to_fuzzy()` | Convert Likert-5 to fuzzy numbers |
| `likert7_to_fuzzy()` | Convert Likert-7 to fuzzy numbers |
| `calculate_fuzzy_scale()` | Calculate d-values |
| `calculate_consensus()` | Calculate consensus % |
| `defuzzify()` | Convert fuzzy to crisp values |
| `rank_items()` | Rank items |
| `export_results()` | Export to CSV |
| `generate_report()` | Generate text report |

## Interpretation Guide

### d-value (Fuzzy Distance)
- **≤ 0.2**: Excellent (consensus achieved)
- **0.2-0.5**: Moderate
- **> 0.5**: Low (needs improvement)

### Consensus Percentage
- **≥ 75%**: Strong consensus
- **50-75%**: Moderate consensus
- **< 50%**: Weak consensus

## Common Workflows

### 1. Quick Analysis
```r
results <- fuzzy_delphi(my_data, likert_scale = 5)
print(results)
summary(results)
```

### 2. Export Results
```r
results <- fuzzy_delphi(my_data)
export_results(results, output_dir = "output", prefix = "study1")
generate_report(results, output_file = "report.txt")
```

### 3. Step-by-Step
```r
# Convert
fuzzy <- likert5_to_fuzzy(my_data)

# Analyze
scale <- calculate_fuzzy_scale(fuzzy)
consensus <- calculate_consensus(scale)
defuzz <- defuzzify(fuzzy)
ranks <- rank_items(defuzz)

# View
print(scale)
print(consensus)
print(ranks)
```

### 4. Custom Threshold
```r
results <- fuzzy_delphi(
  my_data,
  likert_scale = 5,
  consensus_threshold = 0.15  # Stricter
)
```

## Data Format

```r
# Correct format:
my_data <- data.frame(
  Question1 = c(5, 4, 5, 4),  # Expert responses
  Question2 = c(4, 5, 4, 5),
  Question3 = c(3, 4, 3, 4)
)
# Rows = Experts, Columns = Items, Values = Likert scale (1-5 or 1-7)
```

## Accessing Results

```r
results <- fuzzy_delphi(my_data)

# Overall metrics
results$overall_d_construct      # Overall d-value
results$overall_consensus         # Overall consensus %

# Item-level results
results$item_d_values            # d-value per item
results$consensus_percentage     # Consensus % per item
results$defuzzification          # Defuzzified values
results$ranking                  # Item rankings

# Detailed data
results$fuzzy_scale              # All expert d-values
results$fuzzy_data               # Fuzzy triangular numbers
```

## Example: Accept/Reject Items

```r
results <- fuzzy_delphi(my_data)

# Create summary
summary_df <- data.frame(
  Item = names(results$item_d_values),
  d_value = as.numeric(results$item_d_values),
  consensus = as.numeric(results$consensus_percentage)
)

# Apply criteria (d ≤ 0.2 AND consensus ≥ 75%)
summary_df$accepted <-
  summary_df$d_value <= 0.2 & summary_df$consensus >= 75

# View results
print(summary_df)

# Get accepted items
accepted <- subset(summary_df, accepted == TRUE)
print(accepted)
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Package not found | Run installation steps in order |
| Sample data missing | Run `source("create_data.R")` |
| Wrong data format | Check: rows=experts, cols=items, values=Likert |
| All NA results | Check for missing values in data |
| Export fails | Check directory exists and permissions |

## Help

```r
# Function help
?fuzzy_delphi
?calculate_fuzzy_scale

# Examples
example(fuzzy_delphi)

# Vignette
vignette("fuzzy_delphi_tutorial")
```

## Package Structure

```
FuzzyDelphiR/
├── R/
│   ├── likert_conversion.R    # Conversion functions
│   ├── fuzzy_analysis.R       # Analysis functions
│   ├── fuzzy_delphi.R         # Main wrapper
│   ├── utilities.R            # Export/report functions
│   └── data.R                 # Data documentation
├── data/
│   └── expert_data.rda        # Sample dataset
├── vignettes/
│   └── fuzzy_delphi_tutorial.Rmd
├── DESCRIPTION
├── NAMESPACE
└── README.md
```
