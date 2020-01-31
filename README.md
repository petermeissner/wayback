
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- -->
<!-- FILL OUT OPTIONS !!! -->
<!-- -->
<!-- -->
<!-- -->
Scaffolding and Skeletton Framework
===================================

**Status**

<a href="https://travis-ci.org/petermeissner/scaffold"><img src="https://api.travis-ci.org/petermeissner/scaffold.svg?branch=master"><a/> [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/petermeissner/scaffold?branch=master&svg=true)](https://ci.appveyor.com/project/petermeissner/scaffold) <a href="https://codecov.io/gh/petermeissner/scaffold"><img src="https://codecov.io/gh/petermeissner/scaffold/branch/master/graph/badge.svg" alt="Codecov" /></a> <a href="https://cran.r-project.org/package=scaffold"> <img src="http://www.r-pkg.org/badges/version/scaffold"> </a> <img src="http://cranlogs.r-pkg.org/badges/grand-total/scaffold"> <img src="http://cranlogs.r-pkg.org/badges/scaffold">

*lines of R code:* 3, *lines of test code:* 0

**Version**

0.1.0 ( 2020-01-31 12:11:14 )

**Description**

Having file and folder structures as templates for projects, packages, Shiny apps, ... is a common pattern found e.g. among programmers, statisticianc, data scientists, and practitioners. `{scaffold}` is a framework to easily build up file and folder skelletons and fill out templates on the go. By providing and easy and consistent way to copy files and folders from template folders and files in the local files system or installed in a package. Furthermore `{scaffold}` allows for a templating functions that can transform general templating files into specific - filled out - files and folders.

**License**

MIT + file LICENSE <br>Peter Meissner \[aut, cre\] (<https://orcid.org/0000-0001-6501-1841>)

**Citation**

``` r
citation("scaffold")
```

``` r
Meissner P (2019). scaffold: Scaffolding and Skeletton Framework. R package version 0.1.0.
```

**BibTex for citing**

``` r
toBibtex(citation("scaffold"))
```

    @Manual{,
      title = {scaffold: Scaffolding and Skeletton Framework},
      author = {Peter Meissner},
      year = {2019},
      note = {R package version 0.1.0},
    }

**Installation**

Stable version from CRAN:

``` r
install.packages("scaffold")
```

<!-- Latest development version from Github: -->
<!-- ```{r, eval=FALSE} -->
<!-- devtools::install_github("user_name/repo_name") -->
<!-- ``` -->
**Usage**

*starting up ...*

    library("scaffold")
