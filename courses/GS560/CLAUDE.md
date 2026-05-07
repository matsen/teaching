# GS560 — R environment for course scripts

This directory holds three R scripts for a Bayesian-stats course:

- `simple-example.R` — two-group comparison with `map()` (quadratic approximation).
- `map-marbles.R` — beta-binomial inference with `map()`.
- `hierarchical-marbles.R` — partial pooling with `ulam()` (Stan-backed).

All three depend on Richard McElreath's `rethinking` package (GitHub-only) and `ggplot2`.

## Reproducible setup

`install.R` is the single source of truth for the package install. Idempotent — safe to re-run anytime.

```sh
Rscript install.R
```

Run it after any R minor-version upgrade (4.5 → 4.6 etc.), which wipes `/opt/homebrew/lib/R/<version>/site-library`.

## Why the env keeps breaking

This setup has three brittle pieces; the install script + `~/.R/Makevars` together insulate against all three.

1. **R minor-version upgrades wipe packages.** Homebrew's R puts compiled packages under `/opt/homebrew/lib/R/<minor>/site-library`. Bumping R from 4.4 → 4.5 (or 4.5 → 4.6) creates a new path, leaving the previous library orphaned. Re-run `install.R` to repopulate.
2. **`rethinking` is not on CRAN.** Must come from `remotes::install_github("rmcelreath/rethinking")`. The script handles this.
3. **rstan needs a working C++/Fortran toolchain.** Configured in `~/.R/Makevars`. Earlier versions of that file hardcoded a specific `gcc` cellar path (`14.2.0_1`) and a specific macOS SDK (`MacOSX15.2.sdk`), both of which broke on subsequent upgrades. The current Makevars uses Homebrew's stable `/opt/homebrew/opt/gcc/...` symlink and lets `clang` pick the SDK via `xcrun`, so it should survive future Xcode/gcc upgrades.
4. **`cmdstanr` is also off-CRAN.** Lives on `https://stan-dev.r-universe.dev`. `rethinking` 2.42 made it a hard dep, so the install fails late if you forget. The script handles it.

### CmdStan binary (separate from cmdstanr)

`cmdstanr` is the R interface; the CmdStan toolchain it drives is a separate install at `~/.cmdstan/cmdstan-<version>/`. Already present from a previous setup. If it ever goes missing, `ulam()` will fail with a CmdStan-not-found error — restore with:

```r
cmdstanr::install_cmdstan()
```

`map()` / `quap()` (used in `simple-example.R` and `map-marbles.R`) does *not* need CmdStan; only `ulam()` (used in `hierarchical-marbles.R`) does.

## When something breaks

Diagnostic order:

1. `R --version` — confirm R is on PATH.
2. `R -e '.libPaths()'` — check the site-library path; if `<minor>` changed, the old library is dead.
3. `Rscript -e 'library(rethinking)'` — should succeed silently.
4. If a compile fails inside `install.R`, check `~/.R/Makevars` against current Homebrew/Xcode state (mainly: `ls /opt/homebrew/opt/gcc/lib/gcc/current/` should show `libgfortran*`, and `xcrun --show-sdk-path` should resolve to a real SDK).

## Notes

- Default CRAN mirror is set in `~/.Rprofile` (OSU). `install.R` overrides to `cloud.r-project.org` for non-interactive runs.
- Backup of the original (Jan 2025) Makevars is at `~/.R/Makevars.2025-01.bak`.
- `ulam()` (used in `hierarchical-marbles.R`) compiles a Stan model on first run; expect ~1 min the first time, cached after.
