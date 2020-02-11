#' wb_pkg_install_worker
#'
#' @inheritParams wb_require
#' @param repo_url url of repository to get packages from
#'
#' @export
#'
#'
wb_pkg_install_worker <-
  function (
    pkg,
    repo_url,
    package_path,
    library_path,
    dependencies
  ) {

    # make warnings errors
    old <- unlist(options("warn"))
    on.exit(options(warn = old))
    options(warn = 2)

    # try to install from binary path?
    if ( is.null(package_path) ) {

      utils::install.packages(
        pkg,
        repos        = repo_url,
        dependencies = FALSE,
        lib          = library_path
      )

    } else {

      bin_packages <-
        list.files(
          path       = package_path,
          pattern    = paste0(pkg, "_[0-9.]+\\.zip$"),
          full.names = TRUE
        )

      if ( length(bin_packages) > 0  ){

        utils::install.packages(
          pkgs         = utils::tail(sort( bin_packages ), 1),
          repos        = NULL,
          dependencies = FALSE,
          lib          = library_path
        )

      } else {

        utils::install.packages(
          pkgs         = pkg,
          repos        = repo_url,
          dependencies = FALSE,
          lib          = library_path
        )

      }

    }
  }