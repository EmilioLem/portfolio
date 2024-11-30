# Polynomial Approximation and Optimization Scripts

## Mathematical Background

These scripts use mathematical regression to approximate polynomial equations by minimizing the error between predicted values $y_{\text{pred}}$ and real values $y_{real}$ . The equations vary in degree: linear $((y = ax + b))$, quadratic $((y = ax^2 + bx + c))$, and cubic $((y = ax^3 + bx^2 + cx + d))$.

## The Genetic Algorithm (GA)

The **genetic algorithm** is a heuristic optimization technique inspired by natural selection. It is designed to search for solutions in complex spaces by mimicking evolutionary processes. Key steps include:

1. **Population Initialization**: Generate a set of random solutions (individuals).
2. **Fitness Evaluation**: Compute the error (mean squared error here) for each individual.
3. **Selection**: Retain the fittest individuals for reproduction.
4. **Crossover**: Combine pairs of selected individuals to create new offspring.
5. **Mutation**: Apply small random changes to offspring for diversity.
6. **Iteration**: Repeat until a stopping criterion is met (e.g., acceptable fitness or iteration limit).

## Algorithmic Comparison Across Files

| Aspect                 | `Lineal_VG.m`            | `Cuadratica_VG.m`                   | `Cubica_VG.m`                       |
| ---------------------- | ------------------------ | ----------------------------------- | ----------------------------------- |
| **Equation Degree**    | Linear: \(y = ax + b\)   | Quadratic: \(y = ax^2 + bx + c\)    | Cubic: \(y = ax^3 + bx^2 + cx + d\) |
| **Optimization Type**  | Genetic Algorithm        | Las Vegas Algorithm (Random Search) | Genetic Algorithm                   |
| **Computational Cost** | $O(n \cdot g)$           | $O(n \cdot m)$                      | $O(n \cdot m)$                      |
| **Fitness Function**   | Mean Squared Error (MSE) | Mean Squared Error (MSE)            | Mean Squared Error (MSE)            |
| **Convergence Speed**  | Moderate                 | Slow (high randomness)              | Moderate to slow                    |
| **Robustness**         | High                     | Low                                 | High                                |

- \(n\): Population size
- \(g\): Number of generations
- \(m\): Maximum random iterations for Las Vegas algorithm

## Key Observations

1. **Lineal_VG.m** and **Cubica_VG.m** both use genetic algorithms, making them robust and adaptable to high-dimensional spaces.
2. **Cuadratica_VG.m** uses a simpler random search, which is computationally cheaper but less efficient and less likely to converge for complex problems.
3. The computational complexity of genetic algorithms (\(O(n \cdot g)\)) depends on the population size and the number of generations, which scale linearly.

## Practical Considerations

- Use **`Lineal_VG.m`** for simpler problems with low computational overhead.
- **`Cubica_VG.m`** excels in more complex spaces where adaptive search is necessary.
- **`Cuadratica_VG.m`** works for quick approximations but may not perform well for higher-precision tasks or larger equations.
