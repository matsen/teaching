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

## 1. Plotting + rethinking dependencies on CRAN
install_if_missing(c(
  "ggplot2",
  "remotes",
  "coda", "mvtnorm", "loo", "dagitty", "shape",
  "rstan", "StanHeaders"
))

## 2. cmdstanr — required by rethinking, but not on CRAN. Lives on Stan's r-universe.
##    Note: cmdstanr (the R package) is enough to install rethinking. To actually run
##    ulam() / Stan models you also need the cmdstan toolchain, installed once via
##    cmdstanr::install_cmdstan().  map()/quap() does not need cmdstan.
if (!requireNamespace("cmdstanr", quietly = TRUE)) {
  cat("Installing cmdstanr from stan-dev.r-universe.dev...\n")
  install.packages(
    "cmdstanr",
    repos = c("https://stan-dev.r-universe.dev", getOption("repos"))
  )
} else {
  cat("cmdstanr already installed\n")
}

## 3. rethinking is GitHub-only (not on CRAN)
if (!requireNamespace("rethinking", quietly = TRUE)) {
  cat("Installing rethinking from GitHub...\n")
  remotes::install_github("rmcelreath/rethinking")
} else {
  cat("rethinking already installed\n")
}

## 3. Sanity check — load and print versions
suppressPackageStartupMessages({
  library(ggplot2)
  library(rstan)
  library(rethinking)
})
cat("\n--- Versions ---\n")
cat("R:          ", as.character(getRversion()), "\n")
cat("ggplot2:    ", as.character(packageVersion("ggplot2")), "\n")
cat("rstan:      ", as.character(packageVersion("rstan")), "\n")
cat("rethinking: ", as.character(packageVersion("rethinking")), "\n")
cat("\nDone.\n")
