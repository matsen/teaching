# GS560 — Bayesian guest lecture

A one-session introduction to Bayesian analysis, taught May 2025. The format is
guided hands-on: short verbal framings, then students drive interactive
notebooks and R scripts while the instructor poses questions. No slides.

For the R/`rethinking` environment setup, see [CLAUDE.md](CLAUDE.md).

## Teaching arc

1. **Pitch + classroom prompt.** Laptops closed. Sell Bayesian analysis (unified,
   gives you what you want, priors, small samples, multilevel). Ask the class
   what they already know and want to hear.
2. **Frequentist warmup** — students play with `marbles-frequentist.ipynb` on
   Colab. Slider over total marbles and blue ratio; the binomial test result
   mixes effect size and sample size, which doesn't feel as informative as one
   would like.
3. **Motivate the posterior.** Imagine an ideal procedure. Bayesian inference
   isn't magic but it directly estimates what you care about, with uncertainty.
4. **Posterior hands-on** — `marbles-posterior.ipynb` on Colab
   (`bit.ly/marbles-posterior`). Prompts:
   - As N grows, what happens to uncertainty?
   - What if you have no data? One observation?
   - Does the prior matter when signal is strong vs. weak?
5. **Switch to R.** Run `map-marbles.R`, then `hierarchical-marbles.R`. The key
   idea is that simulation and inference are tied — "simulate, throw out the
   sims that don't match the data" as the intuition for Bayes' rule.

## Files in this directory

| File | Role in lecture |
|------|-----------------|
| `bayesian_description.md` | Instructor's speaker notes — the script for the session. |
| `simple-example.R` | Two-group gene-expression comparison with `quap()`. Not used in the marbles arc; kept as a standalone Bayesian-vs-t-test example. |
| `map-marbles.R` | Step 5a: single-can marbles with `quap()`, flat Beta(1,1) prior. Compares analytical posterior, quadratic approximation, and posterior predictive simulation. |
| `hierarchical-marbles.R` | Step 5b: marble factory with multiple machines. Hierarchical Beta-binomial — simulate from a population, then recover both per-machine θ and the hyperparameters. Partial pooling is visible in the inferred vs. observed plot. |
| `install.R` | Idempotent setup for `rethinking` + `cmdstanr`. See CLAUDE.md. |
| `_ignore/` | Earlier drafts (`frequentist-marbles.R`, `simple-example-2.R`, `stan.R`) — not part of the taught session. |

## Companion notebooks (live outside this directory)

The two Colab notebooks students used in steps 2 and 4 are checked in at:

- `../../notebooks/marbles-frequentist.ipynb`
- `../../notebooks/marbles-posterior.ipynb`

Both have a Colab link in their first cell. The posterior notebook is also
reachable via `bit.ly/marbles-posterior`.
