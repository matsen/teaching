# Marbles: Demonstrating the Connection Between Simulation and Inference
# Install and load necessary packages if not already installed
# install.packages(c("rethinking", "ggplot2"))
library(rethinking)
library(ggplot2)

# Set seed for reproducibility
set.seed(123)

###############################################################################
# PART 1: SIMULATION
# Modify these parameters to simulate different scenarios
###############################################################################

# True proportion of blue marbles (parameter we want to infer)
true_theta <- 0.7  # MODIFY THIS: Try values between 0 and 1

# Number of draws in our simulation
n_draws <- 50  # MODIFY THIS: Try different sample sizes to see the effect

# Simulate binomial data (drawing marbles with replacement)
blue_draws <- rbinom(1, size = n_draws, prob = true_theta)
red_draws <- n_draws - blue_draws

# Print observed data from simulation
cat("Simulation parameters:\n")
cat("True proportion of blue marbles (theta):", true_theta, "\n")
cat("Number of draws:", n_draws, "\n\n")
cat("Observed data from simulation:\n")
cat("Blue marbles drawn:", blue_draws, "\n")
cat("Red marbles drawn:", red_draws, "\n")
cat("Observed proportion of blue:", blue_draws/n_draws, "\n\n")

# Plot the simulation result
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
barplot(c(blue_draws, red_draws), names.arg = c("Blue", "Red"), 
        col = c("skyblue", "coral"), main = "Simulation Results",
        ylab = "Count", ylim = c(0, max(n_draws, blue_draws + 10)))
abline(h = n_draws * true_theta, lty = 2, col = "blue")
abline(h = n_draws * (1 - true_theta), lty = 2, col = "red")
legend("topright", legend = c("Expected blue", "Expected red"), 
       lty = 2, col = c("blue", "red"))

###############################################################################
# PART 2: INFERENCE
# Using the simulated data, infer the original parameter
###############################################################################

# Define the model using map
# This model uses a flat Beta(1,1) prior on theta
# The likelihood is Binomial with probability theta

# Prepare the data list for map
data_list <- list(
  blue = blue_draws,
  total = n_draws
)

# Define the model formula
formula <- alist(
  blue ~ dbinom(total, theta),  # Likelihood: binomial with parameter theta
  theta ~ dbeta(1, 1)           # Prior: uniform prior on theta
)

# Fit the model using map (quadratic approximation)
model <- map(formula, data = data_list)

# Extract the posterior distribution
post <- extract.samples(model, n = 10000)

# Calculate summary statistics of the posterior
post_mean <- mean(post$theta)
post_CI <- PI(post$theta, prob = 0.95)

# Print inference results
cat("Inference results:\n")
cat("MAP estimate of theta:", coef(model)["theta"], "\n")
cat("Posterior mean of theta:", post_mean, "\n")
cat("95% credible interval:", post_CI[1], "to", post_CI[2], "\n\n")
cat("True theta was:", true_theta, "\n")

# Compare the analytical and approximate posteriors
# The analytical posterior is Beta(blue_draws + 1, red_draws + 1)
# The approximate posterior comes from map

# Create a sequence of theta values for plotting
theta_seq <- seq(0, 1, length.out = 1000)

# Calculate the analytical posterior density (Beta distribution)
analytical_posterior <- dbeta(theta_seq, 
                              blue_draws + 1, 
                              red_draws + 1)

# Plot the posterior distributions
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
plot(theta_seq, analytical_posterior, type = "l", col = "blue",
     xlab = "Proportion of Blue Marbles (θ)", 
     ylab = "Posterior Density",
     main = "Posterior Distribution of θ")

# Add the true value
abline(v = true_theta, lty = 2, col = "green")

# Add the MAP estimate
abline(v = coef(model)["theta"], lty = 3, col = "red")

# Add legend
legend("topright", 
       legend = c("Analytical Posterior", "True Value", "MAP Estimate"),
       lty = c(1, 2, 3), 
       col = c("blue", "green", "red"))

# Add density from the approximation (samples from map)
lines(density(post$theta), col = "orange", lty = 2)
legend("topleft", 
       legend = c("Quadratic Approximation"),
       lty = 2, 
       col = "orange")

###############################################################################
# PART 3: FORWARD SIMULATION FROM THE INFERRED MODEL
# This demonstrates the complete cycle of simulation -> inference -> simulation
###############################################################################

# Number of predictive simulations
n_sims <- 100  # MODIFY THIS: Number of forward simulations

# Use the posterior distribution to simulate new datasets
sim_blues <- rbinom(n_sims, size = n_draws, prob = post$theta)

# Plot the distribution of simulated outcomes
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1))
hist(sim_blues, breaks = seq(-0.5, n_draws + 0.5, by = 1),
     xlab = "Number of Blue Marbles", 
     ylab = "Frequency",
     main = "Predictive Simulation from Posterior")

# Add the actual observed value
abline(v = blue_draws, lty = 2, col = "red", lwd = 2)
text(blue_draws, 0, "Observed Data", pos = 3, col = "red")

# Add the expected value based on true theta
abline(v = n_draws * true_theta, lty = 2, col = "green", lwd = 2)
text(n_draws * true_theta, 0, "Expected (True Theta)", pos = 3, col = "green")

# This completes the cycle:
# 1. We simulated data using a known theta
# 2. We performed inference to recover the distribution of theta
# 3. We simulated new data from our inferred theta distribution
#
# This demonstrates the symmetry between forward simulation and inverse inference
# in Bayesian modeling.