# MSclassifR Pipelines – Reproducibility Resources

This repository provides an example workflow used in the article:

"MSclassifR: an R Package for Supervised Classification of Mass Spectra with Machine Learning Methods"  
Alexandre Godmer et al., 2024.  
Submitted to *Expert Systems with Applications*.

## Contents

- A script (`run_pipeline.R`) that reproduces a key evaluation pipeline using MALDI-TOF spectra.
- The compiled binary package `EvaLMSclassifR_0.3.0.tar.gz`, containing internal functions used in the paper.
- Instructions for installation and usage.

## Installation

To install the `EvaLMSclassifR` package directly from GitHub without accessing the source code:

```r
if (!requireNamespace("remotes", quietly = TRUE))
  install.packages("remotes")

remotes::install_url(
  "https://github.com/agodmer/MSclassifR_pipelines/raw/main/evalmsclassifr_0.1.0.zip",
  repos = NULL,
  type = ifelse(.Platform$OS.type == "windows", "win.binary", "source")
)

