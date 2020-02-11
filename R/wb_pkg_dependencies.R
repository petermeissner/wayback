
#' wb_pkg_dependencies
#'
#' @param pkg
#' @param library_path
#' @param dep_types
#'
#' @export
#'
wb_pkg_dependencies <-
  function(
    pkg,
    library_path = NULL,
    dep_types    = c("imports", "depends", "linkingto")
  ){


    pkg_desc <-
      utils::packageDescription(
        pkg     = pkg,
        lib.loc = library_path,
        drop    = FALSE
      )

    imports    <- wb_info_split(pkg_desc$Imports)
    suggests   <- wb_info_split(pkg_desc$Suggests)
    depends    <- wb_info_split(pkg_desc$Depends)
    linkingto  <- wb_info_split(pkg_desc$LinkingTo)


    dep_df <-
      rbind(
        data.frame(
          type             = rep("imports", length(imports)),
          package          = imports,
          stringsAsFactors = FALSE
        ),
        data.frame(
          type             = rep("suggests", length(suggests)),
          package          = suggests,
          stringsAsFactors = FALSE
        ),
        data.frame(
          type             = rep("depends", length(depends)),
          package          = depends,
          stringsAsFactors = FALSE
        ),
        data.frame(
          type             = rep("linkingto", length(linkingto)),
          package          = linkingto,
          stringsAsFactors = FALSE
        )
      )

    # remove R from dependencies
    dep_df <- dep_df[dep_df$package != "R", ]

    # remove base R packages from dependencies
    dep_df <- dep_df[ !(dep_df$package %in% wb_pkg_base_packages()), ]

    # return
    if ( is.null(dep_types) ){
      return(dep_df)
    } else {
      return(dep_df[dep_df$type %in% tolower(dep_types), ])
    }
  }


