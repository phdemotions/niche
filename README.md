# niche

<!-- badges: start -->
<!-- badges: end -->

## Overview

`niche` is the primary entry point for the niche R universe, which supports reproducible, audit-ready consumer psychology research. This package provides a minimal, stable interface for defining, building, and executing research workflows.

The niche universe is structured as follows:

- **niche** (this package): User-facing entry point with three core functions
- **nicheCore**: Defines structural contracts (classes, validators, and determinism utilities)
- **vision**: Handles specification parsing and recipe building
- **Domain packages** (e.g., fury, forge, shuri, strange, banner): Extend functionality with data processing, modeling, scoring, and reporting capabilities (not required for minimal workflow)

## Installation

You can install the development version of niche from GitHub:

``` r
# install.packages("devtools")
devtools::install_github("phdemotions/niche")
```

## Minimal Example

This example demonstrates the complete minimal workflow without requiring external data:

``` r
library(niche)

# Create a temporary spec file
tmp <- tempfile(fileext = ".yml")
vision::write_spec_template(tmp)

# Step 1: Read the specification
spec <- niche_spec(tmp)

# Step 2: Build the recipe
recipe <- niche_build(spec)

# Step 3: Execute the workflow
result <- niche_run(recipe)

# Inspect the result
print(result)
```

The `niche_run()` function performs minimal execution: it validates the recipe, creates output directories, writes the recipe JSON artifact, and returns a `niche_result` object. Data processing, modeling, and reporting are delegated to domain-specific packages.

## Core Functions

- `niche_spec(path)`: Read and validate a YAML specification file
- `niche_build(spec)`: Build an execution recipe from a specification
- `niche_run(recipe)`: Execute the minimal workflow and return results

## License

MIT License. Copyright (c) 2026 Josh Gonzales.
