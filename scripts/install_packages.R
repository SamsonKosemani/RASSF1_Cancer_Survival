# Install required packages for RASSF1 survival analysis
# Run this script first to install all dependencies

# Install from CRAN
install.packages(c("UCSCXenaTools", "survminer", "dplyr", "ggplot2", "readr"))

# Install from Bioconductor
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("SummarizedExperiment")

cat("All required packages installed successfully!\n")
