#' Build a niche recipe from a specification
#'
#' This function constructs a \code{niche_recipe} object from a \code{niche_spec},
#' delegating to \code{vision::build_recipe()}. The recipe defines the complete
#' execution plan for the research workflow.
#'
#' @param spec A \code{niche_spec} object, typically created by \code{niche_spec()}.
#'
#' @return A \code{niche_recipe} object as defined by \code{nicheCore}.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' tmp <- tempfile(fileext = ".yml")
#' vision::write_spec_template(tmp)
#' spec <- niche_spec(tmp)
#' recipe <- niche_build(spec)
#' }
niche_build <- function(spec) {
  # Minimal input validation (type check handled by vision)
  if (!inherits(spec, "niche_spec")) {
    stop("'spec' must be a niche_spec object", call. = FALSE)
  }

  # Delegate to vision
  vision::build_recipe(spec)
}
