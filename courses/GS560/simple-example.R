# Load required libraries
library(rethinking)

# Set seed for reproducibility
set.seed(123)

# Simulate data for a single gene measured in two cell types
n_samples_per_group <- 25  # Number of replicates per cell type
mu_A <- 5                  # True mean expression in cell type A
mu_B <- 7                  # True mean expression in cell type B
sigma <- 1.5               # Common standard deviation

# Generate expression data
cell_type_A <- rnorm(n_samples_per_group, mean = mu_A, sd = sigma)
cell_type_B <- rnorm(n_samples_per_group, mean = mu_B, sd = sigma)

# Combine data into a data frame
expression_data <- data.frame(
  expression = c(cell_type_A, cell_type_B),
  cell_type = rep(c("A", "B"), each = n_samples_per_group)
)

# Create index variable for cell types (1 = A, 2 = B)
expression_data$cell_type_idx <- ifelse(expression_data$cell_type == "A", 1, 2)

# Plot the raw data - fixed version
# Use the numeric index for plotting
plot(
  expression ~ cell_type_idx, 
  data = expression_data,
  col = ifelse(expression_data$cell_type == "A", "blue", "red"),
  xlab = "Cell Type", 
  ylab = "Gene Expression",
  xaxt = "n",  # Suppress default x-axis
  pch = 16
)
# Add custom x-axis labels
axis(1, at = c(0, 1), labels = c("A", "B"))
title("Gene Expression by Cell Type")

# Fit the model using the parameterization that works
m1 <- map(
  alist(
    expression ~ dnorm(mu, sigma),
    mu <- a + b * (cell_type_idx - 1),  # A = 0, B = 1
    a ~ dnorm(6, 5),                    # Mean for cell type A
    b ~ dnorm(0, 5),                    # Difference (B - A)
    sigma ~ dexp(0.5)                   # SD
  ),
  data = expression_data
)

# Examine the model
precis(m1)

# Extract posterior samples
post <- extract.samples(m1)

# Plot the posterior distribution of the difference (b parameter)
dens(post$b, col = "blue", lwd = 2,
     xlab = "μB - μA (Difference in Expression)",
     main = "Posterior Distribution of Expression Difference")
abline(v = 0, lty = 2)

# Add 89% HPDI (Highest Posterior Density Interval)
HPDI_89 <- HPDI(post$b, prob = 0.89)
shade(density(post$b), HPDI_89)

# Calculate probability that cell type B has higher expression
prob_B_greater <- mean(post$b > 0)
text(mean(post$b), 0.1, 
     labels = paste0("Pr(μB > μA) = ", round(prob_B_greater, 3)),
     pos = 3)

# Posterior predictive simulation
n_samples <- 1000
pred_A <- rnorm(n_samples, 
                mean = post$a[1:n_samples], 
                sd = post$sigma[1:n_samples])
pred_B <- rnorm(n_samples, 
                mean = post$a[1:n_samples] + post$b[1:n_samples], 
                sd = post$sigma[1:n_samples])
# Create a more comprehensive posterior predictive check plot
par(mfrow = c(1, 1))  # Reset plot layout

# Create base plot with posterior predictive densities
plot(density(pred_A), col = "blue", lwd = 2, xlim = c(0, 12),
     main = "Posterior Predictive Check", 
     xlab = "Gene Expression",
     ylim = c(0, 0.3))  # Adjust ylim to accommodate histograms
lines(density(pred_B), col = "red", lwd = 2)

# Add semi-transparent histograms of the observed data
hist(cell_type_A, breaks = 10, add = TRUE, freq = FALSE, 
     col = adjustcolor("blue", alpha.f = 0.3), border = "blue")
hist(cell_type_B, breaks = 10, add = TRUE, freq = FALSE, 
     col = adjustcolor("red", alpha.f = 0.3), border = "red")

# Add a legend
legend("topright", 
       legend = c("Cell Type A (predicted)", "Cell Type B (predicted)", 
                  "Cell Type A (observed)", "Cell Type B (observed)"),
       col = c("blue", "red", "blue", "red"),
       lty = c(1, 1, NA, NA),
       pch = c(NA, NA, 22, 22),
       lwd = c(2, 2, NA, NA),
       pt.bg = c(NA, NA, adjustcolor("blue", alpha.f = 0.3), 
                 adjustcolor("red", alpha.f = 0.3)),
       pt.cex = c(NA, NA, 2, 2))

