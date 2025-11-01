# Installation Instructions for FuzzyDelphiR

## Prerequisites

Make sure you have R installed (version 3.5.0 or higher).

## Step 1: Generate Sample Data

Before installing the package, you need to create the sample dataset:

1. Open R or RStudio
2. Navigate to the FuzzyDelphiR directory:
   ```r
   setwd("C:/Users/LerLerChan/Documents/GitHub/FuzzyDelphiR")
   ```

3. Run the data creation script:
   ```r
   source("create_data.R")
   ```

This will create the file `data/expert_data.rda`.

## Step 2: Install Required Packages

```r
# Install development tools
install.packages("devtools")
install.packages("roxygen2")

# Optional: for building vignettes
install.packages("knitr")
install.packages("rmarkdown")
```

## Step 3: Build Documentation

```r
# Set working directory to package root
setwd("C:/Users/LerLerChan/Documents/GitHub/FuzzyDelphiR")

# Generate documentation from roxygen comments
library(roxygen2)
roxygenise()
```

## Step 4: Install the Package

### Option A: Install from Source

```r
library(devtools)
setwd("C:/Users/LerLerChan/Documents/GitHub")
install("FuzzyDelphiR")
```

### Option B: Build and Install

```r
# From the parent directory
setwd("C:/Users/LerLerChan/Documents/GitHub")

# Build the package
devtools::build("FuzzyDelphiR")

# Install the built package
install.packages("FuzzyDelphiR_1.0.0.tar.gz", repos = NULL, type = "source")
```

## Step 5: Verify Installation

```r
# Load the package
library(FuzzyDelphiR)

# Check if functions are available
?fuzzy_delphi

# Load sample data
data(expert_data)
head(expert_data)

# Run a quick test
results <- fuzzy_delphi(expert_data, likert_scale = 5)
print(results)
```

## Troubleshooting

### Issue: "there is no package called 'roxygen2'"
**Solution:** Install roxygen2 first:
```r
install.packages("roxygen2")
```

### Issue: "Error in loadNamespace(name) : there is no package called 'FuzzyDelphiR'"
**Solution:** Make sure you've completed Steps 1-4 in order.

### Issue: Sample data not found
**Solution:** Run `source("create_data.R")` from the package directory to create the data file.

### Issue: Documentation not building
**Solution:**
```r
# Clear any existing documentation
unlink("man", recursive = TRUE)

# Regenerate
library(roxygen2)
roxygenise()
```

## Complete Installation Script

Here's a complete script that does everything:

```r
# Set the package directory
pkg_dir <- "C:/Users/LerLerChan/Documents/GitHub/FuzzyDelphiR"
setwd(pkg_dir)

# Step 1: Create sample data
source("create_data.R")

# Step 2: Install dependencies
install.packages(c("devtools", "roxygen2", "knitr", "rmarkdown"))

# Step 3: Generate documentation
library(roxygen2)
roxygenise()

# Step 4: Install package
library(devtools)
setwd("..")  # Go to parent directory
install("FuzzyDelphiR")

# Step 5: Test
library(FuzzyDelphiR)
data(expert_data)
results <- fuzzy_delphi(expert_data)
print(results)
```

## Next Steps

After successful installation:

1. Read the vignette: `vignette("fuzzy_delphi_tutorial", package = "FuzzyDelphiR")`
2. Check the README: `C:/Users/LerLerChan/Documents/GitHub/FuzzyDelphiR/README.md`
3. Explore examples: `example(fuzzy_delphi)`

## Contact

For issues or questions, please refer to the package documentation or contact the maintainer.
