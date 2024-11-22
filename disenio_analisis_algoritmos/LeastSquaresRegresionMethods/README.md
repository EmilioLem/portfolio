# Least Squares Regression Methods

## Overview
Least Squares methods are statistical techniques for finding the best-fitting curve or line for a set of data points by minimizing the sum of squared residuals.

## Key Methods Implemented

### 1. Linear Regression (lineal.m & mcuadrado_1.m)
- **Equation**: y = mx + b
- **Use Cases**: 
  - Simple linear relationships
  - Trend analysis
  - Predictive modeling
- **Advantages**: 
  - Simple interpretation
  - Computationally efficient
- **Limitations**: 
  - Assumes linear relationship
  - Sensitive to outliers

### 2. Quadratic Regression (cuadratico.m & mcuadrado_2.m)
- **Equation**: y = ax² + bx + c
- **Use Cases**:
  - Curved relationships
  - Parabolic data
  - More complex trend modeling
- **Advantages**:
  - Captures non-linear trends
  - Better fit for curved data
- **Limitations**:
  - Can overfit with limited data
  - More complex interpretation

### 3. Cubic Regression (cubico.m & mcuadrado_3.m)
- **Equation**: y = ax³ + bx² + cx + d
- **Use Cases**:
  - Complex, non-linear data
  - Advanced trend analysis
  - Modeling complex systems
- **Advantages**:
  - Highest flexibility
  - Can model complex relationships
- **Limitations**:
  - High risk of overfitting
  - Computationally intensive

## Recommended Usage
- Linear: Simple, straightforward relationships
- Quadratic: Moderately curved data
- Cubic: Complex, highly variable data
