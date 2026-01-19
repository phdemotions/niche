test_that("niche_spec delegates to vision::read_spec correctly", {
  # Create a temporary spec file using vision
  tmp <- tempfile(fileext = ".yml")
  on.exit(unlink(tmp), add = TRUE)

  # Write a template spec
  vision::write_spec_template(tmp)

  # Read it via niche_spec
  spec <- niche_spec(tmp)

  # Assert it returns a niche_spec object
  expect_s3_class(spec, "niche_spec")
})

test_that("niche_spec validates input type", {
  expect_error(
    niche_spec(123),
    "'path' must be a character scalar"
  )

  expect_error(
    niche_spec(c("a", "b")),
    "'path' must be a character scalar"
  )
})
