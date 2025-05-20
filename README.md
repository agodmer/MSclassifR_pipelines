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
install.packages("devtools") # if not already installed

devtools::install_url("https://github.com/<ton_user>/EvaLMSclassifR-binary/raw/main/EvaLMSclassifR_0.3.0.tar.gz",
                      type = "source")
