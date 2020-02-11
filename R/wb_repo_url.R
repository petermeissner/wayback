#' wb_repo_url
#'
#' @param date date for which to get repo url
#'
#'
wb_repo_url <-
  function(date) {
  # available checkpoints
  checkpoint_dates <- checkpoint::getValidSnapshots()

  # determine nearest available date
  min_date <- min(checkpoint_dates[checkpoint_dates > date])

  repo_url <- paste0(checkpoint::mranUrl(), min_date)
}
