# Helper functions for RASSF1 survival analysis

# Function to check if required packages are installed
check_packages <- function() {
  required_packages <- c("UCSCXenaTools", "survminer", "dplyr", 
                         "ggplot2", "survival", "readr")
  
  for (pkg in required_packages) {
    if (!require(pkg, character.only = TRUE)) {
      stop("Package ", pkg, " is not installed. Please run install_packages.R first.")
    }
  }
  cat("All required packages are installed and loaded.\n")
}

# Function to validate data
validate_data <- function(merged_data) {
  if (nrow(merged_data) == 0) {
    stop("No data available after merging. Check your data sources.")
  }
  
  if (sum(!is.na(merged_data$os_time)) == 0 | sum(!is.na(merged_data$os_status)) == 0) {
    stop("Survival data contains only missing values.")
  }
  
  cat("Data validation passed. Proceeding with analysis.\n")
}
