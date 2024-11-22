# Monte Carlo Simulation Script

## Introduction

This script demonstrates two applications of the Monte Carlo method:

1. **Estimating π (Pi):**
   - Randomly generate points in a 2D space within the range `[-1, 1]`.
   - Check if the points fall inside a unit circle.
   - Estimate π using the proportion of points inside the circle.

2. **Numerical Integration:**
   - Approximate the integral of a function over a defined interval `[a, b]` by evaluating it at random points in the interval.

---

## How It Works

### Estimating π

- **Mathematical Concept**:
  The area of a unit circle is `πr²` with `r = 1`, so the area is `π`. By sampling points within a square of side 2 (area = 4), the ratio of points inside the circle to total points approximates `π/4`.

- **Algorithm**:
  1. Generate `num_puntos` random points `(x, y)` in `[-1, 1]`.
  2. Check if the points satisfy `x² + y² <= 1`.
  3. Compute π using the formula:
     \[
     \pi \approx 4 \times \frac{\text{points inside the circle}}{\text{total points}}
     \]

---

### Numerical Integration

- **Mathematical Concept**:
  The integral of a function $\( f(x) \)$ over $\([a, b]\)$ can be approximated by:
  $\[
  \int_a^b f(x) dx \approx \frac{1}{N} \sum_{i=1}^{N} f(x_i) \times (b - a)
  \]$
  where $\( x_i \)$ are randomly sampled points in $\([a, b]\)$.

- **Algorithm**:
  1. Define a function $\( f(x) \)$.
  2. Generate `num_puntos` random values in the range `[0, 1]` (or a specific interval `[a, b]`).
  3. Compute the mean of $\( f(x) \)$ at the sampled points.
  4. Multiply by the interval size to get the approximate integral.

---

## How to Use the Script

1. Set the number of points for the simulation (`num_puntos`).
2. Call the `estimar_pi` function to estimate π.
3. Define your function \( f(x) \) and use the Monte Carlo method for numerical integration.

### Script Results

- The script will output:
  - The Monte Carlo approximation of π.
  - The Monte Carlo approximation of a definite integral.
  - A comparison with the exact integral value (if known).
