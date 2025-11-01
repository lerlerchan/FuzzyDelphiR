# FuzzyDelphiR

An R package for conducting Fuzzy Delphi Method analysis. This package provides comprehensive tools for expert consensus analysis using fuzzy triangular numbers.

## Features

- Convert Likert-5 and Likert-7 scale responses to fuzzy triangular numbers
- Calculate fuzzy distance (d-values) for expert agreement analysis
- Determine consensus percentage among experts
- Perform defuzzification to obtain crisp values
- Rank items based on defuzzified values
- Export results to CSV files
- Generate comprehensive analysis reports

## Installation

### From Source

1. Clone or download this repository
2. In R, install the package:

```r
# Install devtools if not already installed
install.packages("devtools")

# Install FuzzyDelphiR from local source
devtools::install("path/to/FuzzyDelphiR")
```

### Build from Package Directory

```r
# Navigate to the package directory and build
setwd("path/to/FuzzyDelphiR")

# Install required dependencies
install.packages(c("roxygen2", "knitr", "rmarkdown"))

# Generate documentation
roxygen2::roxygenise()

# Install the package
devtools::install()
```

## Quick Start

### Basic Usage

```r
library(FuzzyDelphiR)

# Load sample data (27 experts, 10 items with Likert-5 scale)
data(expert_data)
head(expert_data)

# Run complete Fuzzy Delphi analysis
results <- fuzzy_delphi(expert_data, likert_scale = 5)

# View results
print(results)
summary(results)
```

### Step-by-Step Analysis

```r
# Your data: rows = experts, columns = items
my_data <- data.frame(
  Question1 = c(5, 4, 5, 5, 4, 5),
  Question2 = c(4, 5, 4, 5, 5, 4),
  Question3 = c(3, 4, 3, 4, 4, 3)
)

# Step 1: Convert to fuzzy numbers
fuzzy_data <- likert5_to_fuzzy(my_data)

# Step 2: Calculate fuzzy scale (d-values)
fuzzy_scale <- calculate_fuzzy_scale(fuzzy_data)

# Step 3: Calculate consensus
consensus <- calculate_consensus(fuzzy_scale, threshold = 0.2)

# Step 4: Defuzzification
defuzz_values <- defuzzify(fuzzy_data)

# Step 5: Rank items
rankings <- rank_items(defuzz_values)

# View results
print(fuzzy_scale)
print(consensus)
print(rankings)
```

### Export Results

```r
# Run analysis
results <- fuzzy_delphi(expert_data, likert_scale = 5)

# Export all results to CSV files
export_results(results, output_dir = "output", prefix = "my_analysis")

# Generate text report
generate_report(results, output_file = "fuzzy_delphi_report.txt")
```

## Main Functions

### Data Conversion
- `likert5_to_fuzzy()` - Convert Likert-5 scale to fuzzy triangular numbers
- `likert7_to_fuzzy()` - Convert Likert-7 scale to fuzzy triangular numbers

### Analysis Functions
- `calculate_fuzzy_scale()` - Calculate fuzzy distance (d-values)
- `calculate_consensus()` - Calculate expert consensus percentage
- `defuzzify()` - Convert fuzzy numbers to crisp values
- `rank_items()` - Rank items based on defuzzified values

### Main Wrapper
- `fuzzy_delphi()` - Perform complete Fuzzy Delphi analysis

### Utilities
- `export_results()` - Export results to CSV files
- `generate_report()` - Generate text summary report
- `print.fuzzy_delphi()` - Print method for results
- `summary.fuzzy_delphi()` - Summary method for results

## Understanding Results

### d-value (Fuzzy Distance)
- **d ≤ 0.2**: Excellent agreement (consensus achieved)
- **0.2 < d ≤ 0.5**: Moderate agreement
- **d > 0.5**: Low agreement (further rounds needed)

### Consensus Percentage
- **≥ 75%**: Strong consensus
- **50-75%**: Moderate consensus
- **< 50%**: Weak consensus

## Example Output

```r
results <- fuzzy_delphi(expert_data)
print(results)

# Fuzzy Delphi Method Results
# ============================
#
# Overall Results:
#   - Overall d-construct value: 0.15
#   - Overall consensus percentage: 82.5%
#
# Item-level Results:
#   - Average d-value per item:
#     Item1  Item2  Item3  Item4  Item5
#      0.12   0.14   0.13   0.18   0.16
#
#   - Item rankings:
#     Item1  Item2  Item3  Item4  Item5
#        1      3      2      5      4
```

## Data Requirements

Your input data should be structured as:
- **Rows**: Individual experts/respondents
- **Columns**: Items/questions being evaluated
- **Values**: Likert scale responses (1-5 or 1-7)
- **Column names**: Can be any descriptive names (e.g., "Question1", "Factor_A", etc.)

Example:
```
   Item1 Item2 Item3
1      5     4     5
2      4     5     4
3      5     5     5
```

## Package Dependencies

This package uses only base R functions and has no external dependencies for core functionality. Optional dependencies:
- `knitr` and `rmarkdown` for building vignettes

## License

GPL-3

## Citation

If you use this package in your research, please cite:

```
Chan, LK (2025) FuzzyDelphiR  [Computer software]. Retrieved from https://lerlerchan.github.io/FuzzyDelphiR/

The jamovi project (2025). jamovi. (Version 2.6) [Computer Software]. Retrieved from https://www.jamovi.org.
```

## References

For more information on the Fuzzy Delphi Method:
Md Jani, Noraniza & Zakaria, Mohd & Maksom, Zulisman & Shariff, Md & Mustapha, Ramlan. (2018). Consequences of Customer Engagement in Social Networking Sites : Employing Fuzzy Delphi Technique for Validation. International Journal of Advanced Computer Science and Applications. 9. 10.14569/IJACSA.2018.090938

N. A. M. Saffie, N. M. Shukor and K. A. Rasmani, "Fuzzy delphi method: Issues and challenges," 2016 International Conference on Logistics, Informatics and Service Sciences (LISS), Sydney, NSW, Australia, 2016, pp. 1-7, doi: 10.1109/LISS.2016.7854490

## Author

Chan Ler-Kuan (lkchan@sc.edu.my)

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.
