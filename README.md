
<!-- README.md is generated from README.Rmd. Please edit that file -->

# copypaste

<!-- badges: start -->

<!-- badges: end -->

The goal of copypaste is to accelate copyed data reading in R

## Installation

You can install the released version of copypaste from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("copypaste")
# or
remotes::install_git("https://git.rud.is/jcval94/copypaste.git")
```

## Example

This is a basic example which shows you how to solve a common problem:

First, it is necessary to copy a table using Ctrl + C directly from your
browser, excel, google sheets, etc.

<https://en.wikipedia.org/wiki/Standard_normal_table>

``` r
library(copypaste)
#> Loading required package: rstudioapi
## Not run
# copypaste()
```

Check your data with new\_df

``` r
new_df
#> data frame with 0 columns and 0 rows
```

You can also change read.table parameters, for example:

    #> data frame with 0 columns and 0 rows

Also you can use Addins to create a shortcut and be faster:
