# This script creates a package for SCOPE_run.R

# Install packages and load libraries
install.packages(c("devtools", "roxygen2"))
library(usethis)
library(devtools)
library(roxygen2)


# Creating framework of the SCOPE_run package
devtools::create("SCOPEr1")

devtools::document()

usethis::use_vignette("introduction")
