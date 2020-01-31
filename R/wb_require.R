
#' wb_require
#'
#' This function will make sure a specified package is available within the
#' current R session. If the package is not available it will attempt to
#' install it and load it thereafter. If its already installed it will only
#' load the package.
#'
#' Other than the normal \code{install.packages} function this function will not
#' use the newest package available but one that was available at a specific
#' point in time on CRAN. For CRAN snapshots the Microsoft R Open snapshots and
#' the checkpoiunt package are used.
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
#' @param lib_path `character` - lib_path to use first
#' @param binary_path `character` - path to look for binary packages to install
#'
#' @export
#'
#' @import checkpoint
#'
#'
#' @examples
#'
#' \dontrun{
#'
#' # make sure apckage is available
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
    date         = options("wb_require_date"),
    date_shift   = options("wb_require_shift_date"),
    lib_path     = options("wb_require_lib_path"),
    binary_path  = options("wb_require_binary_path"),
    dependencies = getOption("wb_require_dependencies", c("Depends", "Imports", "LinkingTo"))
  ) {

    # process options
    date        = unlist(date)
    lib_path    = unlist(lib_path)
    binary_path = unlist(binary_path)
    date_shift  = unlist(date_shift)

    # set lib path?
    if ( !is.null(lib_path) ){

      # check if lib path exists, if not create it.
      if ( !dir.exists(lib_path) ){
        dir.create(lib_path)
      }

      # ensure function restores settings on exit
      lib_path_old <- .libPaths()
      on.exit({
        .libPaths("")
        .libPaths(lib_path_old)
      })

      # set new lib_path
      .libPaths(lib_path)

      # get installed packages
      installed_packages <-
        rownames(
          utils::installed.packages(
            lib.loc = lib_path
          )
        )
    } else {

      # get installed packages
      installed_packages <-
        rownames(utils::installed.packages())
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
        date <- date + 60
      } else {
        date <- date + date_shift
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
        date <- date + 0
      } else {
        date <- date + date_shift
      }
    }


    # available checkpoints
    checkpoint_dates <- checkpoint::getValidSnapshots()

    # determine nearest available date
    min_date <- min(checkpoint_dates[checkpoint_dates > date])

    repo_url <- paste0(checkpoint::mranUrl(), min_date)



    # check if package should be installed and loaded or simply loaded
    if ( pkg %in% installed_packages ){

      message("loading ", pkg)
      library(pkg, character.only = TRUE)

    } else {

      message("install ", pkg)

      # try to install from binary path?
      if ( is.null(binary_path) ) {

        utils::install.packages(pkg, repos = repo_url, dependencies = dependencies)

      } else {
        bin_packages <-
          list.files(
            path       = binary_path,
            pattern    = paste0(pkg, "_[0-9.]+\\.zip$"),
            full.names = TRUE
          )

        if ( length(bin_packages) > 0  ){
          utils::install.packages(
            pkgs  = utils::tail(sort( bin_packages ), 1),
            repos = NULL
          )
        } else {
          utils::install.packages(
            pkgs         = pkg,
            repos        = repo_url,
            dependencies = dependencies
          )
        }
      }


      message("loading ", pkg)
      library(pkg, character.only = TRUE)

    }
  }
