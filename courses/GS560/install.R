## Bootstrap R environment for GS560 course scripts.
## Run after any R minor-version upgrade (which wipes the package library).
##
## Usage:
##   Rscript install.R
##
## Installs into the default site-library; idempotent (skips already-installed packages).
## See CLAUDE.md in this directory for background.

install_if_missing <- function(pkgs) {
  missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
  if (length(missing)) {
    cat("Installing:", paste(missing, collapse = ", "), "\n")
    install.packages(missing, dependencies = TRUE)
  } else {
    cat("All present:", paste(pkgs, collapse = ", "), "\n")
  }
}

## CRAN mirror (also set in ~/.Rprofile, but be explicit for non-interactive runs)
options(repos = c(CRAN = "https://cloud.r-project.org"))

## 1. Plotting + rethinking-slim dependencies on CRAN
install_if_missing(c(
  "ggplot2",
  "remotes",
  "coda", "mvtnorm", "loo", "dagitty", "shape"
))

## 2. rethinking is GitHub-only. We use the @slim branch — quap() only,
##    no Stan/cmdstanr/rstan. All three GS560 scripts use quap().
if (!requireNamespace("rethinking", quietly = TRUE)) {
  cat("Installing rethinking (slim) from GitHub...\n")
  remotes::install_github("rmcelreath/rethinking@slim")
} else {
  cat("rethinking already installed\n")
}

## 3. Sanity check — load and print versions
suppressPackageStartupMessages({
  library(ggplot2)
  library(rethinking)
})
cat("\n--- Versions ---\n")
cat("R:          ", as.character(getRversion()), "\n")
cat("ggplot2:    ", as.character(packageVersion("ggplot2")), "\n")
cat("rethinking: ", as.character(packageVersion("rethinking")), "\n")
cat("\nDone.\n")
