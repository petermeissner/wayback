
wb_task <- function(){
  self       <- new.env()
  self$tasks <- list()

  self$add_task <-
    function(
      pkg
    ) {
      # get tasks already in queue
      pkg_names <- unlist(lapply(self$tasks, `[[`, "package_name"))

      # add tasks
      for ( i in seq_along(pkg) ){
        # add task if not already done
        if ( !( pkg[i] %in% pkg_names) ) {
          self$tasks[[pkg[i]]] <<-
            list(
              package_name = pkg[i],
              done         = FALSE
            )
        }
      }

      # return self invisible
      invisible(self)
    }


  self$get_task <-
    function(){
      iffer <-
        lapply(
          X   = self$tasks,
          FUN = function(x){x$done == FALSE}
        )

      if ( sum(unlist(iffer)) > 0 ){

        tsk <- head(self$tasks[unlist(iffer)], 1)[[1]]
        self$close_task(tsk$package_name)
        return(tsk)

      } else {

        return(NULL)

      }
    }

  self$close_task <-
    function(pkg){
      # close task

      for ( i in seq_along(pkg) ){
      self$tasks[[
        which(
          unlist(
            lapply(
              X   = self$tasks,
              FUN = function(x){x$package_name == pkg[i]}
            )
          )
        )
        ]]$done <- TRUE
      }
    }

  self$as_df <-
    function(){
      do.call(rbind, self$tasks)
    }

  self
}
