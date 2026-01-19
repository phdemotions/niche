#' Read a niche specification from a YAML file
#'
#' This function reads and validates a niche specification file, delegating to
#' \code{vision::read_spec()}. The specification defines research parameters,
#' data sources, and processing requirements for a consumer psychology workflow.
#'
#' @param path Character scalar. Path to a YAML specification file.
#'
#' @return A \code{niche_spec} object as defined by \code{nicheCore}.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' tmp <- tempfile(fileext = ".yml")
#' vision::write_spec_template(tmp)
#' spec <- niche_spec(tmp)
#' }
niche_spec <- function(path) {
  # Minimal input validation
  if (!is.character(path) || length(path) != 1L) {
    stop("'path' must be a character scalar", call. = FALSE)
  }

  # Delegate to vision
  vision::read_spec(path)
}
