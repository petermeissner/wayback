#' wb_pkg_install
#'
#' Installs packages and its dependencies
#'
#' @inheritParams wb_require
#' @param repo_url url of repository to get packages from
#'
#' @export
#'
wb_pkg_install <-
  function(
    pkg,
    repo_url,
    library_path,
    package_path,
    dependencies
  ) {


    # task queue - create or re-use
    task_list <- wb_task()
    task_list$add_task(pkg)

    # install packages while there are packages to install
    while ( !is.null(tsk <- task_list$get_task()) ) {
      print(tsk$package_name)

      wb_pkg_install_worker(
        pkg          = tsk$package_name,
        repo_url     = repo_url,
        package_path = package_path,
        dependencies = dependencies,
        library_path = library_path
      )


      deps <-
        wb_pkg_dependencies(
          tsk$package_name, library_path = library_path, dep_types = dependencies
        )

      task_list$add_task(deps$package)
    }

  }