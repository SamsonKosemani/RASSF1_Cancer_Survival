# RASSF1 Survival Analysis in TCGA-BRCA
# This script performs survival analysis of RASSF1 expression in breast cancer

# Load required libraries
library(UCSCXenaTools)
library(dplyr)
library(survminer)
library(ggplot2)
library(survival)
library(readr)

# Set seed for reproducibility
set.seed(123)

# 1. Download RASSF1 expression data
cat("Downloading RASSF1 expression data...\n")
host <- "https://toil.xenahubs.net"
expr_dataset <- "TcgaTargetGtex_rsem_gene_tpm"

RASSF1_expr <- fetch_dense_values(host, expr_dataset, 
                                  identifiers = "RASSF1", 
                                  use_probeMap = TRUE)

RASSF1_df <- data.frame(sample_id = colnames(RASSF1_expr), 
                        RASSF1_expr = as.numeric(RASSF1_expr[1,]))

# 2. Download clinical data for BRCA
cat("Downloading clinical data...\n")
clinical_url <- "https://tcga-xena-hub.s3.us-east-1.amazonaws.com/download/TCGA.BRCA.sampleMap%2FBRCA_clinicalMatrix"
clinical_df <- read.delim(clinical_url, check.names = FALSE)

# 3. Merge and prepare data
cat("Merging and preparing data...\n")
merged_data <- clinical_df %>%
  dplyr::select(sampleID, OS_Time_nature2012, OS_event_nature2012) %>%
  dplyr::rename(sample_id = sampleID,
                os_time = OS_Time_nature2012,
                os_status = OS_event_nature2012) %>%
  dplyr::inner_join(RASSF1_df, by = "sample_id") %>%
  dplyr::filter(!is.na(os_time) & !is.na(os_status))

# 4. Classify into High/Low expression groups
median_expr <- median(merged_data$RASSF1_expr)
merged_data$RASSF1_group <- ifelse(merged_data$RASSF1_expr > median_expr, "High", "Low")

cat(paste("Median RASSF1 expression:", round(median_expr, 2), "\n"))
cat(paste("Number of patients with high expression:", sum(merged_data$RASSF1_group == "High"), "\n"))
cat(paste("Number of patients with low expression:", sum(merged_data$RASSF1_group == "Low"), "\n"))

# 5. Perform survival analysis
cat("Performing survival analysis...\n")
surv_object <- Surv(time = merged_data$os_time, event = merged_data$os_status)
fit <- survfit(surv_object ~ RASSF1_group, data = merged_data)

# 6. Create Kaplan-Meier plot
cat("Generating Kaplan-Meier plot...\n")
km_plot <- ggsurvplot(
  fit,
  data = merged_data,
  pval = TRUE,
  conf.int = TRUE,
  risk.table = TRUE,
  legend.labs = c("High Expression", "Low Expression"),
  legend.title = "RASSF1",
  title = "Overall Survival in TCGA-BRCA by RASSF1 Expression",
  xlab = "Time (Days)",
  ylab = "Overall Survival Probability",
  palette = c("#E7B800", "#2E9FDF"),
  ggtheme = theme_minimal()
)

# 7. Save results
cat("Saving results...\n")
ggsave("../results/RASSF1_KM_Plot_BRCA.png", plot = km_plot$plot, 
       width = 8, height = 10, dpi = 300)
write_csv(merged_data, "../results/survival_analysis_data_BRCA.csv")

cat("Analysis complete! Results saved to the results folder.\n")
print(km_plot)
