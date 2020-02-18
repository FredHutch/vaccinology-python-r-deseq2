################################################################################
### Install DESeq2

if (!requireNamespace("BiocManager", quietly = TRUE)) {
    update.packages(ask=FALSE)
    install.packages("BiocManager")
}
BiocManager::install(version = "3.10")


BiocManager::install("DESeq2")
install.packages("readr")
install.packages("dplyr")
BiocManager::install("apeglm")

