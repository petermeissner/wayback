
#' Use Packages from Way-Back-Then
#'
#' This function will make sure a specified package is available within the
#' current R session. If the package is not available it will attempt to
#' install it and load it thereafter. If its already installed it will only
#' load the package.
#'
#' Other than the normal \code{install.packages} function this function will not
#' use the newest package available but one that was available at a specific
#' point in time on CRAN. For CRAN snapshots the Microsoft R Open snapshots and
#' the checkpoint package are used.
#'
#' The default date is the date of the release of the R version currently in use
#' plus an additional 60 days.
#'
#' The \code{lib_path} argument can be used to make use a project specific
#' R package library path.
#'
#' Also, its possible to specify a path were binary packages can be found and
#' installed from.
#'
#'
#'
#'
#' @param pkg `character` - package name specified as cha
#'
#' @param date `character` - date specified in ISO format, defaults to date
#'     specified in \code{sessionInfo()$R.version$version.string}
#'
#' @param date_shift `integer` - number of days to add to date
#' @param library_path `character` - lib_path to use first
#' @param package_path `character` - path to look for binary packages to install
#' @param dependencies `character vector` - specifies which types of dependencies
#'   should be installed also
#' @param url_fun function transforming a date into a repository url
#'
#' @export
#'
#' @import checkpoint
#' @import utils
#'
#' @examples
#'
#' \dontrun{
#'
#' # set options
#' options(wb_require_lib_path = "./r_lib_path")
#'
#' # make sure package is available
#' wb_require("data.table")
#'
#' # use packages released up to 365 days younger than the current R-versions
#' # release date
#' wb_require("data.table", date_shift = 365)
#'
#' # use a specific lib path for loading and installing
#' wb_require("data.table", lib_path = "./r_lib_path")
#'
#' }
#'
wb_require <-
  function (
    pkg,
    library_path = getOption("wb_require_lib_path", NULL),
    date         = getOption("wb_require_date", NULL),
    date_shift   = getOption("wb_require_shift_date", NULL),
    package_path = getOption("wb_require_package_path", NULL),
    dependencies = getOption("wb_require_dependencies", c("Depends", "Imports", "LinkingTo")),
    url_fun      = getOption("wb_require_url", wb_repo_url)
  ) {

    # process options
    date         = unlist(date)
    lib_path     = unlist(library_path)
    package_path = unlist(package_path)
    date_shift   = unlist(date_shift)


    # check that library path is set
    if ( is.null(library_path) ) {
      stop(
        "library_path is not set.
  Set it as function parameter, e.g.: library_path = './library' or
  via options, e.g. options(wb_require_lib_path = './library')"
        )
    }

    # check if library_path exists, if not create it.
    if ( !is.null(library_path) && !dir.exists(library_path) ) {

      # create path
      dir.create(library_path)

      # add .gitignore
      writeLines(text = "*", con = paste(library_path, ".gitignore", sep="/"))
    }


    # process appropriate date to use for snapshot
    #
    # - use date and date_shift as-is if specified
    # - use R version date + 60 days if neither is specified
    # - use R version date + date_shift if only date_shift is specified
    # - use date + 0 if only date is specified
    #
    if ( is.null(date) ){
      r_version_date_string <-
        gsub(
          x           = utils::sessionInfo()$R.version$version.string,
          pattern     = "^.*(\\d{4}-\\d{2}-\\d{2}).*$",
          replacement = "\\1"
        )

      date <- as.Date(r_version_date_string)

      if ( is.null(date_shift) ){
        date <- min(date + 60, Sys.Date() - 5)
      } else {
        date <- min(date + date_shift, Sys.Date() - 5)
      }

      message(
        "No date specified.\n",
        "Automatically choosing appropriate date based\n",
        "upon publication date of R version in use.\n",
        date
      )

    } else {
      date <- as.Date(date)

      if ( is.null(date_shift) ){
        date <- min(date + 0, Sys.Date() - 5)
      } else {
        date <- min(date + date_shift, Sys.Date() - 5)
      }
    }


    # loaded packages
    si <- utils::sessionInfo()
    packages_loaded <-
      c(
        names(si$otherPkgs),
        names(si$basePkgs),
        names(si$loadedOnly)
      )

    if ( !(pkg %in% packages_loaded) ){
      tryCatch(

        expr  =
          {
            library(
              pkg,
              character.only = TRUE,
              lib.loc        = library_path
            )
            message("loaded ", pkg)
          },

        error =
          function(e){
            message("install ", pkg)

            # get repo url to use
            if ( is.null(package_path) ){
              repo_url <- url_fun(date)
            }

            # install package
            wb_install(
              pkg          = pkg,
              repo_url     = repo_url,
              package_path = package_path,
              library_path = library_path,
              dependencies = dependencies
            )

            # load package
            library(
              pkg,
              character.only = TRUE,
              lib.loc        = library_path
            )
            message("loaded ", pkg)
          }
      )
    }

  }
