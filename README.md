
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- -->

<!-- FILL OUT OPTIONS !!! -->

<!-- -->

<!-- -->

<!-- -->

# Solid Package Installation for Legacy R Versions

**Status**

<a href="https://travis-ci.org/petermeissner/wayback"><img src="https://api.travis-ci.org/petermeissner/wayback.svg?branch=master"><a/>
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/petermeissner/wayback?branch=master&svg=true)](https://ci.appveyor.com/project/petermeissner/wayback)
<a href="https://codecov.io/gh/petermeissner/wayback"><img src="https://codecov.io/gh/petermeissner/wayback/branch/master/graph/badge.svg" alt="Codecov" /></a>
<!--<a href="https://cran.r-project.org/package=wayback">
<img src="https://www.r-pkg.org/badges/version/wayback">
</a>
<img src="https://cranlogs.r-pkg.org/badges/grand-total/wayback">
<img src="https://cranlogs.r-pkg.org/badges/wayback">
-->

*lines of R code:* 94, *lines of test code:* 0

**Version**

0.1.0 ( 2020-01-31 22:00:44 )

**Description**

Make sure packages are available at runtime without any setup. Package
installation, reproducability and exchanging code can be frunstrating
especially id code is used on older R versions. The `wayback` package
aims to make this process as painless and robust as possible.

**License**

GPL-3 <br>Peter Meissner \[aut, cre\], virtual7
\[cph\]

**Citation**

``` r
citation("wayback")
```

``` r
Meissner P (2020). wayback: Solid Package Installation for Legacy R Versions. R package version 0.1.0.
```

**BibTex for citing**

``` r
toBibtex(citation("wayback"))
```

    @Manual{,
      title = {wayback: Solid Package Installation for Legacy R Versions},
      author = {Peter Meissner},
      year = {2020},
      note = {R package version 0.1.0},
    }

**Installation**

Stable version from CRAN:

``` r
install.packages("wayback")
```

<!-- Latest development version from Github: -->

<!-- ```{r, eval=FALSE} -->

<!-- devtools::install_github("user_name/repo_name") -->

<!-- ``` -->

**Usage**

*starting up …*

    library("wayback")

``` r
suppressPackageStartupMessages(
  wb_require(pkg = "stringr", date = "2017-01-01", lib_path = "./r_package_library")
)
```

    ## install stringr

    ## Installing package into '/home/peter/wayback/r_package_library'
    ## (as 'lib' is unspecified)

    ## loading stringr

``` r
info <- packageDescription("dplyr", lib.loc = "./r_package_library")

info$Packaged
```

    ## [1] "2016-06-23 21:54:41 UTC; hadley"
