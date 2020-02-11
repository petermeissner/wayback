#' wb_pkg_base_packages
#'
#' @return character vector with packages already part of the R installation
#' @export
#'
wb_pkg_base_packages <-
  function(){
    cache <- NULL
    function(){

      # fill cache?
      if ( is.null(cache) ){
        pkg_inst <- as.data.frame(installed.packages(), stringsAsFactors = FALSE)
        cache <<- pkg_inst[pkg_inst$Priority %in% c("base", "recommended"), "Package"]
      }

      # return cache
      cache
    }
  }()
