# FuzzyDelphiR Package Summary

## Package Overview

**FuzzyDelphiR** is a comprehensive R package for conducting Fuzzy Delphi Method analysis. It provides all necessary tools to convert Likert scale data to fuzzy numbers, calculate consensus metrics, and rank items based on expert agreement.

## Created Files

### Core Package Files

1. **DESCRIPTION** - Package metadata and dependencies
2. **NAMESPACE** - Exported functions
3. **.Rbuildignore** - Files to ignore during build

### R Functions (R/ directory)

1. **likert_conversion.R**
   - `likert5_to_fuzzy()` - Convert Likert-5 scale to fuzzy triangular numbers
   - `likert7_to_fuzzy()` - Convert Likert-7 scale to fuzzy triangular numbers

2. **fuzzy_analysis.R**
   - `calculate_fuzzy_scale()` - Calculate fuzzy distance (d-values)
   - `calculate_consensus()` - Calculate expert consensus percentage
   - `defuzzify()` - Convert fuzzy numbers to crisp values
   - `rank_items()` - Rank items based on defuzzified values

3. **fuzzy_delphi.R**
   - `fuzzy_delphi()` - Main wrapper function for complete analysis
   - `print.fuzzy_delphi()` - Print method for results
   - `summary.fuzzy_delphi()` - Summary method for results

4. **utilities.R**
   - `export_results()` - Export results to CSV files
   - `generate_report()` - Generate text summary report

5. **data.R**
   - Documentation for sample dataset

### Data Files (data/ directory)

1. **expert_data.R** - Script to create sample data
2. **expert_data.rda** - Sample dataset (created by running create_data.R)

### Documentation

1. **README.md** - Main package documentation with installation and usage
2. **INSTALL_INSTRUCTIONS.md** - Detailed installation guide
3. **QUICK_REFERENCE.md** - Quick reference guide for common tasks
4. **PACKAGE_SUMMARY.md** - This file

### Vignettes (vignettes/ directory)

1. **fuzzy_delphi_tutorial.Rmd** - Comprehensive tutorial vignette

### Setup Scripts

1. **create_data.R** - Script to generate sample dataset

## Key Features

### 1. Data Conversion
- Supports both Likert-5 and Likert-7 scales
- Converts responses to fuzzy triangular numbers (m1, m2, m3)
- Handles missing values appropriately

### 2. Analysis Functions
- Calculates fuzzy distance for expert-item agreement
- Determines consensus percentage (threshold-based)
- Performs defuzzification using centroid method
- Ranks items based on defuzzified values

### 3. Main Workflow Function
- Single function call for complete analysis
- Returns structured results object
- Customizable consensus threshold
- Automatic calculation of overall metrics

### 4. Output and Export
- Print and summary methods for easy viewing
- CSV export for all result components
- Text report generation
- Formatted tables for publication

### 5. Documentation
- Roxygen2 documentation for all functions
- Comprehensive examples
- Detailed vignette tutorial
- Quick reference guide

## Function Summary

| Function | Input | Output | Purpose |
|----------|-------|--------|---------|
| `likert5_to_fuzzy()` | Data frame with Likert-5 values | Fuzzy triangular numbers | Convert to fuzzy |
| `likert7_to_fuzzy()` | Data frame with Likert-7 values | Fuzzy triangular numbers | Convert to fuzzy |
| `calculate_fuzzy_scale()` | Fuzzy data | d-values matrix | Measure agreement |
| `calculate_consensus()` | Fuzzy scale data | Consensus % | Determine consensus |
| `defuzzify()` | Fuzzy data | Crisp values | Convert to numbers |
| `rank_items()` | Defuzzified data | Rankings | Rank items |
| `fuzzy_delphi()` | Raw Likert data | Complete results | Full analysis |
| `export_results()` | Results object | CSV files | Export to files |
| `generate_report()` | Results object | Text report | Create report |

## Package Dependencies

**No external dependencies for core functionality!**

All analysis functions use base R only.

Optional dependencies:
- `knitr` - For building vignettes
- `rmarkdown` - For building vignettes
- `devtools` - For installation
- `roxygen2` - For documentation generation

## Installation Steps

1. Navigate to package directory
2. Run `source("create_data.R")` to create sample data
3. Run `roxygen2::roxygenise()` to generate documentation
4. Run `devtools::install("FuzzyDelphiR")` to install

## Usage Example

```r
# Load package
library(FuzzyDelphiR)

# Load sample data
data(expert_data)

# Run analysis
results <- fuzzy_delphi(expert_data, likert_scale = 5)

# View results
print(results)
summary(results)

# Export
export_results(results, output_dir = "output")
generate_report(results, output_file = "report.txt")
```

## Data Requirements

Input data should be structured as:
- **Rows**: Individual experts/respondents
- **Columns**: Items/questions being evaluated
- **Values**: Likert scale responses (1-5 or 1-7)
- **Column names**: Any descriptive names (no longer requires "Item" prefix!)

## Interpretation Guidelines

### Overall Metrics

**d-construct value:**
- ≤ 0.2: Excellent consensus
- 0.2-0.5: Moderate agreement
- > 0.5: Low agreement

**Consensus percentage:**
- ≥ 75%: Strong consensus
- 50-75%: Moderate consensus
- < 50%: Weak consensus

### Item Acceptance Criteria

An item is typically accepted if:
- d-value ≤ 0.2 **AND**
- Consensus percentage ≥ 75%

## Package Structure

```
FuzzyDelphiR/
├── R/                          # Function files
│   ├── likert_conversion.R
│   ├── fuzzy_analysis.R
│   ├── fuzzy_delphi.R
│   ├── utilities.R
│   └── data.R
├── data/                       # Data files
│   ├── expert_data.R
│   └── expert_data.rda
├── man/                        # Documentation (auto-generated)
├── vignettes/                  # Tutorials
│   └── fuzzy_delphi_tutorial.Rmd
├── tests/                      # Tests (empty for now)
├── DESCRIPTION                 # Package metadata
├── NAMESPACE                   # Exports
├── .Rbuildignore              # Build ignore list
├── README.md                   # Main documentation
├── INSTALL_INSTRUCTIONS.md     # Installation guide
├── QUICK_REFERENCE.md          # Quick reference
├── PACKAGE_SUMMARY.md          # This file
└── create_data.R              # Data creation script
```

## Next Steps for Development

### Potential Enhancements

1. **Additional Features**
   - Plot functions for visualization
   - Multiple round support
   - Weighted expert opinions
   - Alternative defuzzification methods

2. **Validation**
   - Unit tests using testthat
   - Input validation
   - Error handling improvements

3. **Documentation**
   - More examples
   - Case studies
   - Published paper citation

4. **CRAN Submission**
   - Add LICENSE file
   - Complete all CRAN checks
   - Add NEWS.md file
   - Add cran-comments.md

## Comparison with Jamovi Module

This R package is based on the FuzzyDelphiJmv jamovi module with these improvements:

1. **Flexibility**: Works with any column names (not just "Item1", "Item2", etc.)
2. **Modularity**: Separate functions for each step
3. **Portability**: Works in any R environment, not just jamovi
4. **Extensibility**: Easy to add new features
5. **Documentation**: Comprehensive help and tutorials
6. **Export**: Multiple export formats

## Contact

Package created for PhD research purposes.

For questions or contributions, please contact the package maintainer.

## Version History

**Version 1.0.0** (Current)
- Initial release
- Core Fuzzy Delphi Method implementation
- Support for Likert-5 and Likert-7 scales
- Export and reporting functions
- Sample dataset and vignette

---

**Package Status**: Ready for testing and use

**Date Created**: 2025-11-01
