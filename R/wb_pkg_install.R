#' wb_pkg_install
#'
#' @param pkg
#' @param repo_url
#' @param binary_path
#' @param dependencies
#'
#' @export
#'
wb_pkg_install <-
  function(
    pkg,
    repo_url,
    library_path,
    package_path,
    dependencies,
    tasks = NULL
  ) {


    # task queue - create or re-use
    if ( is.null(tasks) ) {
      task_list <- wb_task()
      task_list$add_task(pkg)
    } else {
      task_list <- tasks
    }

    # install packages while there are packages to install
    while ( !is.null(tsk <- task_list$get_task()) ) {
      print(tsk$package_name)

      browser()

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