test_that("niche_run executes minimal contract correctly", {
  # Create spec and recipe in tempdir
  tmp_spec <- tempfile(fileext = ".yml")
  tmp_out <- file.path(tempdir(), "niche_test_output")
  on.exit({
    unlink(tmp_spec)
    unlink(tmp_out, recursive = TRUE)
  }, add = TRUE)

  # Write spec template and customize output path
  vision::write_spec_template(tmp_spec)
  spec <- niche_spec(tmp_spec)

  # Build recipe
  recipe <- niche_build(spec)

  # Run the recipe
  result <- niche_run(recipe)

  # Assert result is niche_result
  expect_s3_class(result, "niche_result")

  # Assert outputs match recipe$outputs
  expect_identical(result$outputs, recipe$outputs)

  # Assert artifacts contains recipe_json and file exists
  expect_true("recipe_json" %in% names(result$artifacts))
  expect_true(file.exists(result$artifacts$recipe_json))

  # Assert session_info is present
  expect_true(!is.null(result$session_info))

  # Assert created is ISO-8601-like character(1)
  expect_type(result$created, "character")
  expect_length(result$created, 1L)
  expect_match(result$created, "\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}")
})

test_that("niche_run creates output directories if missing", {
  # Create spec and recipe
  tmp_spec <- tempfile(fileext = ".yml")
  tmp_out <- file.path(tempdir(), paste0("niche_dir_test_", as.integer(Sys.time())))
  on.exit({
    unlink(tmp_spec)
    unlink(tmp_out, recursive = TRUE)
  }, add = TRUE)

  vision::write_spec_template(tmp_spec)
  spec <- niche_spec(tmp_spec)
  recipe <- niche_build(spec)

  # Ensure output directory does NOT exist before running
  if (dir.exists(tmp_out)) {
    unlink(tmp_out, recursive = TRUE)
  }
  expect_false(dir.exists(tmp_out))

  # Manually set an output path that doesn't exist
  recipe$outputs$test_dir <- tmp_out

  # Run recipe
  result <- niche_run(recipe)

  # Assert directory was created
  expect_true(dir.exists(tmp_out))
})

test_that("niche_run writes recipe.json via vision", {
  tmp_spec <- tempfile(fileext = ".yml")
  on.exit(unlink(tmp_spec), add = TRUE)

  vision::write_spec_template(tmp_spec)
  spec <- niche_spec(tmp_spec)
  recipe <- niche_build(spec)

  result <- niche_run(recipe)

  # Check that recipe_json artifact exists and is valid JSON
  expect_true(file.exists(result$artifacts$recipe_json))

  # Read and validate JSON structure
  json_content <- jsonlite::fromJSON(result$artifacts$recipe_json)
  expect_true(is.list(json_content))
})
