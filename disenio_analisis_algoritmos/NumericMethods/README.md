# MATLAB Numerical Methods Collection

## Overview
This repository contains five MATLAB scripts implementing different numerical methods for solving mathematical problems:

### 1. Trapecio.m (Trapezoidal Rule Integration)
**Purpose**: Numerical integration method for approximating definite integrals.
- Approximates the area under a curve by dividing it into trapezoids
- Good for: Simple, relatively smooth functions
- Accuracy: Moderate precision
- Computational Complexity: O(n), where n is the number of intervals

### 2. Simpson.m (Simpson's 3/8 Rule Integration)
**Purpose**: Advanced numerical integration technique
- More accurate than trapezoidal method
- Uses weighted averaging of function values
- Good for: Functions with more curvature
- Accuracy: Higher precision compared to trapezoidal rule
- Computational Complexity: O(n), requires intervals to be a multiple of 3
- Best used when smoother approximation is needed

### 3. Secante.m (Secant Method)
**Purpose**: Root-finding algorithm for solving equations
- Iterative method for finding roots of a continuous function
- More efficient than bisection method
- Requires two initial guesses
- Computational Complexity: Quadratic convergence
- Ideal for: Non-linear equation solving when derivative is difficult to compute

### 4. Runge_Kutta.m (4th Order Runge-Kutta Method)
**Purpose**: Solving Ordinary Differential Equations (ODEs)
- Highly accurate numerical solution for initial value problems
- Four-stage method with weighted average of increments
- Provides better approximation than simpler methods like Euler
- Computational Complexity: O(n), where n is number of steps
- Best for: Complex, non-linear differential equations

### 5. Newton.m (Newton-Raphson Method)
**Purpose**: Root-finding and optimization algorithm
- Iterative technique for finding roots of differentiable functions
- Uses function's derivative for faster convergence
- Computational Complexity: Quadratic convergence
- Requires continuous and differentiable function
- Most efficient for well-behaved functions near the root

## Comparative Analysis

| Method | Best Used For | Accuracy | Computational Complexity | Limitations |
|--------|--------------|----------|--------------------------|-------------|
| Trapezoidal | Simple integrals | Moderate | O(n) | Less accurate for complex curves |
| Simpson's 3/8 | More curved functions | High | O(n) | Requires multiple of 3 intervals |
| Secant | Root finding | Good | Quadratic | Needs good initial guesses |
| Runge-Kutta | Solving ODEs | Very High | O(n) | Computationally intensive |
| Newton-Raphson | Root finding & optimization | Excellent | Quadratic | Requires derivative, can diverge |

## Mathematical Background
These methods are fundamental in numerical analysis, providing computational solutions to problems that lack or are difficult to solve analytically. They leverage iterative approximation techniques to solve complex mathematical problems efficiently.

## Potential Applications
- Engineering: Structural analysis, signal processing
- Physics: Modeling dynamic systems
- Finance: Option pricing, risk assessment
- Biology: Population dynamics modeling
- Computer Graphics: Curve approximation

---

**Trapecio.m (Integración por regla del trapecio)**

x^2 (integrar x cuadrado)

sin(x) (integrar seno de x)

exp(x) (integrar función exponencial)

1/(1+x^2) (integrar función racional)


**Simpson.m (Integración por regla de Simpson 3/8)**

x^3 (integrar x al cubo)

cos(x) (integrar coseno de x)

log(x) (integrar logaritmo natural)

sqrt(x) (integrar raíz cuadrada)


**Secante.m (Método de la secante para encontrar raíces)**

x^2 - 4 (encuentra raíz de x² - 4 = 0)

cos(x) - x (encuentra punto de intersección)

exp(x) - 3 (encuentra valor donde e^x = 3)

x^3 - x - 2 (encuentra raíz de polinomio)


**Runge_Kutta.m (Método de Runge-Kutta para ecuaciones diferenciales)**

x + y (ejemplo simple de EDO)

y (otra EDO sencilla)

-2*x*y (EDO no lineal)

x*y (otra variante de EDO)


**Newton.m (Método de Newton para encontrar raíces)**

x^2 - 4 (encuentra raíces)

cos(x) - x (punto de intersección)

exp(x) - 3 (encuentra valor específico)

x^3 - 2*x - 5 (raíz de polinomio)
