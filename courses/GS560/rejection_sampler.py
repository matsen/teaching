# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "marimo",
#     "numpy",
#     "scipy",
#     "matplotlib",
# ]
# ///
"""Marbles: rejection sampling as a picture of Bayes' theorem.

Draw theta from the prior, simulate a draw of n marbles, keep theta only if the
simulated blue count matches the observed b. The kept theta's are the posterior.
Companion to simulation-and-inference.tex.
"""

import marimo

__generated_with = "0.23.6"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo
    import numpy as np
    from scipy import stats
    import matplotlib.pyplot as plt

    return mo, np, plt, stats


@app.cell
def _(mo):
    mo.md(r"""
    # Simulate, then keep what matches

    **The recipe.** (1) draw $\theta \sim \text{prior}$, (2) simulate
    $b' \sim \text{Binomial}(n, \theta)$, (3) keep $\theta$ only if $b' = b$.
    The kept $\theta$'s are distributed as the posterior $p(\theta \mid b)$.
    """)
    return


@app.cell
def _(b, mo, n, n_prop, prior, rejection_figure):
    # The live view: formula, controls, and plot together, one call. Everything
    # below this cell is the implementation -- collapse it or ignore it.
    mo.vstack(
        [
            mo.md(r"$$\huge p(\theta \mid b)\;\propto\;p(b \mid \theta)\,p(\theta)$$"),
            n,
            b,
            prior,
            n_prop,
            rejection_figure(n.value, b.value, prior.value, n_prop.value),
        ]
    )
    return


@app.cell
def _(mo):
    n = mo.ui.slider(1, 50, value=20, label=r"total drawn $n$")
    prior = mo.ui.slider(
        0.5, 5.0, step=0.5, value=1.0, label=r"prior strength $\alpha=\beta$"
    )
    n_prop = mo.ui.slider(
        2000, 100000, step=2000, value=40000, label="proposals from prior"
    )
    return n, n_prop, prior


@app.cell
def _(mo, n):
    b = mo.ui.slider(0, n.value, value=min(12, n.value), label=r"observed blue $b$")
    return (b,)


@app.cell
def _(np, plt, stats):
    def rejection_figure(n_val, b_val, prior_val, n_prop_val):
        b_val = min(b_val, n_val)
        rng = np.random.default_rng(0)
        theta_prop = rng.beta(prior_val, prior_val, size=n_prop_val)
        b_sim = rng.binomial(n_val, theta_prop)
        accepted = b_sim == b_val
        theta_kept = theta_prop[accepted]

        x = np.linspace(0.0, 1.0, 400)
        posterior = stats.beta(b_val + prior_val, n_val - b_val + prior_val)
        prior_dist = stats.beta(prior_val, prior_val)

        fig, (ax0, ax1) = plt.subplots(
            2, 1, figsize=(8, 6), sharex=True, gridspec_kw={"height_ratios": [1, 2.4]}
        )

        # Top: each proposal as a point, green if its simulation matched the data.
        m = min(3000, theta_prop.size)
        jitter = np.random.default_rng(1).uniform(0, 1, m)
        rej = ~accepted[:m]
        acc = accepted[:m]
        ax0.scatter(theta_prop[:m][rej], jitter[rej], s=4, c="0.8", label="rejected")
        ax0.scatter(
            theta_prop[:m][acc], jitter[acc], s=8, c="C2", label=r"kept ($b'=b$)"
        )
        ax0.set_yticks([])
        ax0.set_ylabel("proposals")
        ax0.legend(loc="upper right", frameon=False, markerscale=1.5)
        rate = theta_kept.size / theta_prop.size
        ax0.set_title(
            f"kept {theta_kept.size:,} of {theta_prop.size:,}  "
            f"(acceptance rate {rate:.1%})"
        )

        # Bottom: the kept theta's recover the analytical posterior.
        if theta_kept.size > 1:
            ax1.hist(
                theta_kept,
                bins=40,
                range=(0, 1),
                density=True,
                color="C2",
                alpha=0.35,
                label=r"kept $\theta$ (histogram)",
            )
        ax1.plot(x, posterior.pdf(x), "C3", lw=2.5, label="analytical posterior")
        ax1.plot(x, prior_dist.pdf(x), "C0--", lw=1.5, label="prior")
        ax1.set_xlim(0, 1)
        ax1.set_yticks([])
        ax1.set_xlabel(r"$\theta$  (fraction blue)")
        ax1.legend(loc="upper right", frameon=False)

        fig.tight_layout()
        return fig

    return (rejection_figure,)


if __name__ == "__main__":
    app.run()
