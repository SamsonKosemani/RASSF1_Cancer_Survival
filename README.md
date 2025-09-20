# RASSF1 Survival Analysis in TCGA-BRCA

![R Language](https://img.shields.io/badge/R-Language-blue.svg)
![Bioinformatics](https://img.shields.io/badge/Bioinformatics-Project-green.svg)
![TCGA Data](https://img.shields.io/badge/Data-TCGA_BRCA-lightgrey.svg)

## 📖 Project Overview

This repository contains a comprehensive bioinformatics analysis examining the prognostic value of **RASSF1** (Ras Association Domain Family Member 1) gene expression in breast cancer using data from The Cancer Genome Atlas (TCGA).

RASSF1 is a well-known tumor suppressor gene involved in cell cycle regulation, apoptosis, and genomic stability. This project investigates whether RASSF1 expression levels serve as a biomarker for patient survival outcomes in breast cancer.

## 🧪 Research Hypothesis

**Primary Hypothesis:** High expression of RASSF1 is associated with improved overall survival in breast cancer patients, consistent with its role as a tumor suppressor gene.

**Rationale:** As a tumor suppressor, RASSF1 is involved in:
- Cell cycle arrest and apoptosis
- Maintenance of genomic stability
- Regulation of microtubule dynamics
- DNA damage response pathways

We hypothesize that loss of RASSF1 expression (a common event in cancers through promoter hypermethylation) would correlate with poorer patient outcomes.

## 📊 Methodology

### Data Acquisition
- **Gene Expression Data:** Downloaded from UCSC Xena Browser using the `UCSCXenaTools` R package
- **Clinical Data:** TCGA-BRCA clinical matrix containing survival outcomes and patient metadata
- **Sample Size:** Analysis includes all available breast cancer samples from TCGA with complete clinical and expression data

### Analytical Approach
1. **Data Preprocessing:** Merged expression and clinical data, handled missing values
2. **Stratification:** Divided patients into "High" and "Low" RASSF1 expression groups based on median expression
3. **Survival Analysis:** Performed Kaplan-Meier survival analysis and log-rank tests
4. **Visualization:** Created publication-quality survival curves

### Statistical Methods
- Kaplan-Meier survival estimates
- Log-rank test for survival difference significance
- Median expression cutoff for group stratification

## 🗂️ Project Structure

