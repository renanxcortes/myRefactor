
# myRefactor

The goal of `myRefactor` is to present how to refactor some badly-written code.

## Installation

You can install the development version of `myRefactor` with:

``` r
devtools::install_github("renanxcortes/myRefactor@main")
```

## Example

This is a basic example which shows you how to check the documentation of the `total_price` function:

``` r
library(myRefactor)
help(total_price)
```

## Unit Tests

This package is also unit tested. After installing and loading it, you can run the tests by running:

``` r
testthat::test_package("myRefactor")
```

# Acknowledgment

The structure of this package was developed using [usethis](https://usethis.r-lib.org/).