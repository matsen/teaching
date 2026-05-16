# GS560 — R environment for course scripts

This directory holds three R scripts for a Bayesian-stats course:

- `simple-example.R` — two-group comparison with `quap()` (quadratic approximation).
- `map-marbles.R` — beta-binomial inference with `quap()`.
- `hierarchical-marbles.R` — partial pooling with `quap()`.

All three use `quap()` only — no MCMC, no Stan. They depend on Richard McElreath's `rethinking` package (GitHub-only, **`@slim` branch**) and `ggplot2`.

## Reproducible setup

`install.R` is the single source of truth for the package install. Idempotent — safe to re-run anytime.

```sh
Rscript install.R
```

Run it after any R minor-version upgrade (4.5 → 4.6 etc.), which wipes `/opt/homebrew/lib/R/<version>/site-library`.

## Why the env keeps breaking

Two brittle pieces remain after the switch to slim:

1. **R minor-version upgrades wipe packages.** Homebrew's R puts compiled packages under `/opt/homebrew/lib/R/<minor>/site-library`. Bumping R from 4.4 → 4.5 (or 4.5 → 4.6) creates a new path, leaving the previous library orphaned. Re-run `install.R` to repopulate.
2. **`rethinking` is not on CRAN.** Must come from `remotes::install_github("rmcelreath/rethinking@slim")`. The script handles this.

The slim branch drops the Stan/cmdstanr/rstan stack, which used to be the main source of breakage (Fortran toolchain, SDK path, off-CRAN repos, separate CmdStan binary). If you ever need `ulam()` again, follow the full-install instructions at <https://github.com/rmcelreath/rethinking#installation>.

## When something breaks

Diagnostic order:

1. `R --version` — confirm R is on PATH.
2. `R -e '.libPaths()'` — check the site-library path; if `<minor>` changed, the old library is dead.
3. `Rscript -e 'library(rethinking)'` — should succeed silently.
4. If a compile fails inside `install.R` for one of the CRAN deps, check `~/.R/Makevars` against current Homebrew/Xcode state (`xcrun --show-sdk-path` should resolve to a real SDK).

## Notes

- Default CRAN mirror is set in `~/.Rprofile` (OSU). `install.R` overrides to `cloud.r-project.org` for non-interactive runs.
- Backup of the original (Jan 2025) Makevars is at `~/.R/Makevars.2025-01.bak`.
