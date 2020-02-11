#' wb_info_split
#'
#' @param x list of package dependencies
#'
#'
wb_info_split <-
  function(x){
    tryCatch(
      expr =
        {
          x <- unlist(strsplit(x, ",[ \n]*"))
          x <- gsub(x = x, pattern = " *\\(.*$", replacement = "")
        },
      error =
        function(e){
          x <<- character(0)
        }
    )
    # return
    x
  }