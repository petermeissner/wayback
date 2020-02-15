
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

*lines of R code:* 291, *lines of test code:* 0

**Version**

0.2.1 ( 2020-02-15 22:30:21 )

**Description**

Make sure packages are available at runtime without any setup. Package
installation, reproducability and exchanging code can be frunstrating
especially if code is used on older R versions. Often it is hard puzzle
out which package versions are able to work together after some years
have passed and packages evolved further and further. The `wayback`
package aims to make this process as painless and robust as possible by
using `MRAN`’s `CRAN` snapshots to build local package libraries from
way back.

**License**

GPL-3 <br>Peter Meissner \[aut, cre\], virtual7
\[cph\]

**Citation**

``` r
citation("wayback")
```

``` r
Meissner P (2020). wayback: Solid Package Installation for Legacy R Versions. R package version 0.2.1.
```

**BibTeX for citing**

``` r
BibTeX(citation("wayback"))
```

    @Manual{,
      title = {wayback: Solid Package Installation for Legacy R Versions},
      author = {Peter Meissner},
      year = {2020},
      note = {R package version 0.2.1},
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

## Package Usage

``` r
library(wayback)
```

The main function of the package is `wb_require()`. Once `{wayback}` is
installed this function allows to have required packages loaded from a
library specified. In addition `wb_require()` will install packages that
are not present but required.

The real core strength and purpose of the package is to install packages
and dependencies from a specific point in time. This is provided by the
`date` parameter allowing to go back in time - especially to a point in
time where known to have consistent states of packages and dependencies
for a given version of R.

``` r
suppressPackageStartupMessages(
  wb_require(
    pkg          = "glue", 
    date         = Sys.Date(),
    library_path = "./r_package_library"
  )
)
```

    ## install glue

    ## [1] "glue"
    ## package 'glue' successfully unpacked and MD5 sums checked
    ## 
    ## The downloaded binary packages are in
    ##  C:\Users\peter.meissner\AppData\Local\Temp\Rtmp6dGVZ4\downloaded_packages

    ## Warning: package 'glue' was built under R version 3.6.2

    ## loaded glue

``` r
info <- packageDescription("glue", lib.loc = "./r_package_library")

info$Packaged
```

    ## [1] "2019-03-11 21:03:11 UTC; jhester"

## Package Maxims and Trade Offs

  - given `{wayback}` is installed everything else should just work
  - `{wayback}` will not change how your session works - e.g. normal
    `install.packages()` will work the same with and without `{wayback}`
  - given that no date is provided the parameter `date` will default to
    60 days after the currently used R version was used
  - `{wayback}` will not install anything if the required package is
    already found in the current path
  - if however a explicit library path is provided - best practice -
    than `{wayback}` will assume that all packages and all dependencies
    - except base R packages - should come from this source
  - dependencies are important: `{wayback}` will forcefully install
    dependencies
  - providing a function that does package loading and installation is
    less ‘save’ than the standard usage of `library()` on the other hand
    this is common practice and `{wayback}` scratches this itch in hope
    to provide a solid, effective and robust solution to the problem
  - behaviour should - by default - stem from function parameters only
  - to minimize re-writing function parameters over and over again all
    function parameters can be set via options
