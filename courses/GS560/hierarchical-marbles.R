# Hierarchical Marbles: Simulation and Inference with map
# Simple demonstration of hierarchical modeling with consistency between simulation and inference
library(rethinking)

# Set seed for reproducibility
set.seed(123)

###############################################################################
# PART A: HIERARCHICAL SIMULATION
# Marble factory with multiple machines, each with its own proportion
###############################################################################

# MODIFY THESE PARAMETERS
n_machines <- 20        # Number of marble-making machines
n_draws <- 50          # Marbles sampled from each machine

# Generate a more consistent hierarchical model
# We'll use a Beta distribution for both simulation and inference

# Hyperparameters for the Beta distribution
alpha <- 4             # Higher values = more blue
beta <- 2              # Higher values = more red

# First, simulate machine-level parameters from a common Beta distribution
# This represents the factory-wide variation in machine calibration
true_thetas <- rbeta(n_machines, alpha, beta)

# Now simulate observed data (marble draws) for each machine
blue_draws <- rbinom(n_machines, size = n_draws, prob = true_thetas)
red_draws <- n_draws - blue_draws

# Create a dataframe for easier handling
factory_data <- data.frame(
  machine = 1:n_machines,
  true_theta = true_thetas,
  blue = blue_draws,
  red = red_draws,
  observed_prop = blue_draws / n_draws
)

# Display the simulation results
cat("Factory Simulation Results:\n")
cat("Hyperparameters: alpha =", alpha, ", beta =", beta, "\n")
cat("Expected factory-wide mean proportion:", alpha/(alpha+beta), "\n\n")

print(factory_data)

# Plot the true thetas and observed proportions
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))

# True theta distribution
curve(dbeta(x, alpha, beta), from = 0, to = 1, 
      main = "Factory-wide Distribution", 
      xlab = "True Proportion of Blue (θ)", 
      ylab = "Density")
points(true_thetas, rep(0, n_machines), pch = 16, col = "blue")
rug(true_thetas, col = "blue")

# Observed data by machine
barplot(t(cbind(blue_draws, red_draws)), 
        beside = FALSE, 
        col = c("skyblue", "coral"),
        names.arg = 1:n_machines,
        main = "Observed Marbles by Machine",
        xlab = "Machine", 
        ylab = "Count")
legend("topright", legend = c("Blue", "Red"), 
       fill = c("skyblue", "coral"))

###############################################################################
# PART B: HIERARCHICAL INFERENCE
# Use a simple approach with map to mimic our simulation
###############################################################################

# Prepare data list for inference
data_list <- list(
  blue = blue_draws,
  total = rep(n_draws, n_machines),
  machine = 1:n_machines
)

# For map, we'll directly estimate individual machine parameters
# and fixed hyperparameters
model_formula <- alist(
  # Likelihood for each machine
  blue ~ dbinom(total, theta[machine]),
  
  # Prior for each machine's proportion
  theta ~ dbeta(a, b),
  
  # Hyperpriors for the Beta parameters
  a ~ dexp(1),
  b ~ dexp(1)
)

# Start values that are in a reasonable range
start_list <- list(
  a = 1,
  b = 1,
  theta = rep(0.5, n_machines)
)

# Fit the model
model <- map(model_formula, data = data_list, start = start_list)

# Display results
cat("\nInference Results:\n")
print(precis(model, depth = 2))  # depth=2 shows vector parameters too

# Extract the inferred values
inferred_a <- coef(model)["a"]
inferred_b <- coef(model)["b"]
inferred_thetas <- coef(model)[grep("theta\\[", names(coef(model)))]

# Create comparison table
results_table <- data.frame(
  machine = 1:n_machines,
  true_theta = true_thetas,
  inferred_theta = inferred_thetas,
  observed_prop = blue_draws / n_draws
)

cat("\nTrue vs Inferred Machine Proportions:\n")
print(results_table)

cat("\nHyperparameters:\n")
cat("True: alpha =", alpha, ", beta =", beta, "\n")
cat("Inferred: a =", inferred_a, ", b =", inferred_b, "\n")

# Visualize the results
par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))

# Plot inferred vs true thetas
plot(true_thetas, inferred_thetas, 
     pch = 16, col = "blue",
     xlim = c(0, 1), ylim = c(0, 1),
     xlab = "True Proportion (θ)", 
     ylab = "Inferred Proportion (θ)",
     main = "True vs Inferred")
abline(0, 1, lty = 2)  # Identity line

# Simple visualization of the hierarchical structure
plot(1:n_machines, true_thetas, 
     ylim = c(0, 1),
     xlab = "Machine", 
     ylab = "Proportion of Blue Marbles",
     main = "Hierarchical Structure",
     pch = 16, col = "blue")
# Add observed proportions
points(1:n_machines, blue_draws/n_draws, pch = 17, col = "red")
# Add inferred proportions
points(1:n_machines, inferred_thetas, pch = 15, col = "green")

# Connect the points with lines to show the pattern
lines(1:n_machines, true_thetas, col = "blue")
lines(1:n_machines, blue_draws/n_draws, col = "red", lty = 2)
lines(1:n_machines, inferred_thetas, col = "green", lty = 3)

# Add reference lines for the means
abline(h = alpha/(alpha+beta), lty = 2, col = "blue")
abline(h = inferred_a/(inferred_a+inferred_b), lty = 2, col = "green")

# Add legend
legend("bottomright", 
       legend = c("True θ", "Observed Prop", "Inferred θ", 
                  "True Mean", "Inferred Mean"), 
       col = c("blue", "red", "green", "blue", "green"),
       pch = c(16, 17, 15, NA, NA),
       lty = c(1, 2, 3, 2, 2))

# Plot true and inferred distributions
par(mfrow = c(1, 1))
curve(dbeta(x, alpha, beta), from = 0, to = 1, 
      main = "Population Distributions", 
      xlab = "Proportion of Blue (θ)", 
      ylab = "Density",
      col = "blue", lwd = 2)
curve(dbeta(x, inferred_a, inferred_b), from = 0, to = 1, 
      col = "green", lwd = 2, add = TRUE)
legend("topright", 
       legend = c("True Distribution", "Inferred Distribution"), 
       col = c("blue", "green"), 
       lwd = 2)

# The key insight: The hierarchical model connects simulation and inference
# by allowing us to model both individual-level parameters and the
# distribution from which they come. This bidirectional process shows
# how we can:
#
# 1. Simulate from a hierarchical process (distribution -> parameters -> data)
# 2. Infer hierarchical structure from data (data -> parameters -> distribution)
#
# The partial pooling is visible in how the inferred population parameters
# influence our estimates of each machine's true proportion.