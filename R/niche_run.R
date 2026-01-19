#' Execute a niche recipe
#'
#' This function executes a minimal workflow: validates the recipe, ensures output
#' directories exist, writes the recipe artifact to JSON, and returns a
#' \code{niche_result} object. It does NOT perform data processing, modeling,
#' scoring, or reporting. Those tasks are delegated to domain-specific packages.
#'
#' @param recipe A \code{niche_recipe} object, typically created by \code{niche_build()}.
#'
#' @return A \code{niche_result} object as defined by \code{nicheCore}, containing:
#'   \itemize{
#'     \item \code{recipe}: The input recipe
#'     \item \code{outputs}: Named list of output directory paths
#'     \item \code{artifacts}: List containing \code{recipe_json} path
#'     \item \code{session_info}: Session information from \code{utils::sessionInfo()}
#'     \item \code{warnings}: List of warnings (empty for minimal execution)
#'     \item \code{created}: ISO-8601 timestamp
#'   }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' tmp <- tempfile(fileext = ".yml")
#' vision::write_spec_template(tmp)
#' spec <- niche_spec(tmp)
#' recipe <- niche_build(spec)
#' result <- niche_run(recipe)
#' }
niche_run <- function(recipe) {
  # Validate recipe
  nicheCore::validate_niche_recipe(recipe)

  # Ensure output directories exist (idempotent, safe)
  if (!is.null(recipe$outputs) && is.list(recipe$outputs)) {
    for (out_path in recipe$outputs) {
      if (is.character(out_path) && length(out_path) == 1L) {
        fs::dir_create(out_path)
      }
    }
  }

  # Write recipe JSON using vision's default-path behavior
  recipe_json_path <- vision::write_recipe(recipe)

  # Construct niche_result
  result <- nicheCore::new_niche_result(list(
    recipe = recipe,
    outputs = recipe$outputs,
    artifacts = list(recipe_json = recipe_json_path),
    session_info = utils::sessionInfo(),
    warnings = list(),
    created = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z", tz = "UTC")
  ))

  result
}
