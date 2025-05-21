#### EvalMSclassifR Example Workflow ####

# Set working directory (ADAPT THIS PATH TO YOUR LOCAL ENVIRONMENT)
# setwd("./my_project_results_folder") # Example for a relative path if working from the project root

# Define output folder for results (ADAPT THIS PATH TO YOUR LOCAL ENVIRONMENT)
output_folder <- "./results" # Or a specific absolute path like "C:/path/to/my/results"

# Load necessary packages
# Ensure these packages are installed: install.packages("...") or use renv::restore()
require(MSclassifR)
require(MALDIquantForeign)
require(MALDIquant)
require(caTools)
require(stringr)
require(caret)
require(rbenchmark)
require(lubridate)
require(purrr)
require(evalmsclassifr) # Assumes evalmsclassifr is your internal package or part of MSclassifR

# 1. Generate subset for training and testing
# This function prepares the data subsets based on specified ratios and grouping
generateSubsetStrict(PathwayFolder = output_folder, # Use the generic output folder
                     dataSet = ms_spectra_data,    # Generic name for your spectra data
                     target = factor(metadata_df$target_variable), # Generic name for your target variable
                     RatioSplit_sampling = 0.7,
                     GroupSplit = factor(metadata_df$grouping_variable), # Generic name for your grouping variable
                     NbRepeat_sampling = 10,
                     SizeSplit_subset = length(ms_spectra_data),
                     tolPeaks = 2000e-6,
                     tolAlign = 500e-6)

# 2. Performing models
# Set seed for reproducibility of random processes (e.g., in sampling or model training)
set.seed(12345)

# Execute the main evaluation function
results_evaluation = evalmsclassifr::EvalMSclassifRGlobal(dataSet = ms_spectra_data,
                                                          PathwayFolder = output_folder, # Use the generic output folder
                                                          methodes = c("RFERF", "RFEGlmnet", "sPLSDA", "mda", "cvp"),
                                                          models = c("linear", "nnet", "xgb", "rf", "svm"),
                                                          sampling = "no_sampling",
                                                          NbRepeat_sampling = 10,
                                                          SizeSplit_subset = c(1), # Adjust based on actual subset size used for full analysis
                                                          metric = "Kappa",
                                                          methodvalidationSelectionVar = c("repeatedcv"),
                                                          NameLoop = "generic_loop_evaluation_seed12345", # Generic name for the loop
                                                          maxVar = 70,
                                                          minVar = 5,
                                                          numberCV = 3,
                                                          repeatsCV = 3,
                                                          SaveModel = TRUE)

# 3. Plotting results
# Assuming 'performance_metrics' object is part of the 'results_evaluation' output
RES = cbind.data.frame(results_evaluation$performance_metrics) # Adjust based on actual structure of 'results_evaluation'
require(ggplot2) # Ensure ggplot2 is loaded for plotting

p1 <- ggplot(RES, aes(x = as.factor(SamplingMethod), y = as.numeric(Kappa), fill = factor(Model))) + geom_boxplot()
p1 + theme_bw()

p2 <- ggplot(RES, aes(x = as.factor(NbRepeatSubset), y = as.numeric(Kappa), fill = factor(Model))) + geom_boxplot()
p2

p3 <- ggplot(RES, aes(x = as.factor(Model), y = as.numeric(Kappa), fill = factor(Model))) + geom_boxplot()
p3 + theme_bw()

# Session Information for Reproducibility
# This output provides details about the R version and attached packages,
# essential for reproducing the exact computing environment.
sessionInfo()
