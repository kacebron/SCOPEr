
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SCOPEr

<!-- badges: start -->
<!-- badges: end -->

The goal of SCOPEr is to run SCOPE model in R language so that you can
properly document your model configuration runs

## Installation

You can install the development version of SCOPEr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kacebron/SCOPEr")
```

## Verification run

This is an initial run of SCOPE using function run_scope() to test the
integrity of the copy of your model. If output is the same as the
verification dataset, it means that your model is intact and working
good.

``` r
library(SCOPEr)

run_scope(SCOPE_path = "~/Documents/1_postdoc_projects/1_serc_nasa_roses/02_projects/SCOPE/SCOPE.m") # copy the filepath where SCOPE.m is located in your computer then paste it as the SCOPE_path argument
#> [1] "/Users/kelvinacebron/Documents/1_postdoc_projects/1_serc_nasa_roses/02_projects/SCOPEr_project/SCOPEr"
#> File path for SCOPE.m has already been set!
#> Warning in get_matlab(desktop = desktop, splash = splash, display = display, :
#> Setting matlab.path to /Applications/MATLAB_R2022a.app/bin
#> Command run is:
#> '/Applications/MATLAB_R2022a.app/bin'/matlab  -nodesktop -nosplash -nodisplay -r  "try, run('~/Documents/1_postdoc_projects/1_serc_nasa_roses/02_projects/SCOPE/SCOPE.m'); catch err, disp(err.message); exit(1); end; exit(0);"
#> [1] 0
```

## Turn off simulation mode

``` r
set_options(verify = FALSE)
```

## Select simulation mode: 0 = individual runs, 1 = time series, 2 = look-up table

``` r
set_options(simulation = 1)
```
