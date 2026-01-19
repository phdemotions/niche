test_that("niche_build delegates to vision::build_recipe correctly", {
  # Create spec
  tmp <- tempfile(fileext = ".yml")
  on.exit(unlink(tmp), add = TRUE)

  vision::write_spec_template(tmp)
  spec <- niche_spec(tmp)

  # Build recipe
  recipe <- niche_build(spec)

  # Assert it returns a niche_recipe object
  expect_s3_class(recipe, "niche_recipe")
})

test_that("niche_build validates input type", {
  expect_error(
    niche_build("not a spec"),
    "'spec' must be a niche_spec object"
  )
})
