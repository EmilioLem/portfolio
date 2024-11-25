# The Knapsack Problem: Greedy vs Genetic Approaches

## Problem Definition
The Knapsack Problem asks: Given a set of items, each with a weight and value, determine which items to include in a collection so that the total weight is less than a given limit and the total value is as large as possible.

## Greedy Algorithm Approach

### How It Works
1. Calculate value/weight ratio for all items
2. Sort items by ratio (highest to lowest)
3. Add items to knapsack in order until full

### Example
Consider these items:
```
Item   Weight   Value   Ratio (Value/Weight)
A      4        $40     10
B      7        $42     6
C      5        $25     5
D      3        $12     4
Capacity: 10 kg
```

Greedy solution steps:
1. Pick A (4kg, $40)
2. Try B (too heavy)
3. Try C (too heavy)
4. Pick D (3kg, $12)
Final result: A + D = 7kg, $52 total value

### Advantages
- Very fast (O(n log n) for sorting)
- Simple to implement
- Works well with fractional knapsack

### Disadvantages
- Often produces sub-optimal solutions
- Cannot improve solution over time
- Gets stuck in local optima

## Genetic Algorithm Approach

### How It Works
1. **Population**: Create multiple random solutions
   ```
   Solution 1: [1,0,1,0] (Take items A,C)
   Solution 2: [0,1,0,1] (Take items B,D)
   Solution 3: [1,0,0,1] (Take items A,D)
   etc.
   ```

2. **Fitness Function**: Evaluate each solution
   - If weight ≤ capacity: fitness = total value
   - If weight > capacity: fitness = 0 or penalty

3. **Selection**: Choose best solutions for breeding
   ```
   Parent 1: [1,0,0,1]  // A,D
   Parent 2: [1,0,1,0]  // A,C
   ```

4. **Crossover**: Create new solutions
   ```
   Parent 1:  [1,0,0,1]
   Parent 2:  [1,0,1,0]
   Child:     [1,0,1,1]
   ```

5. **Mutation**: Random changes
   ```
   Before: [1,0,1,1]
   After:  [1,0,0,1]  // Random bit flip
   ```

### Advantages
- Can find optimal or near-optimal solutions
- Works well with complex constraints
- Can escape local optima
- Improves solution quality over time

### Disadvantages
- Slower than greedy approach
- Requires parameter tuning
- No guarantee of finding optimal solution
- More complex implementation

## Performance Comparison

### When to Use Greedy
- Need quick solutions
- Dealing with fractional knapsack
- Real-time applications
- When approximate solutions are acceptable

### When to Use Genetic
- Have computation time available
- Need high-quality solutions
- Complex constraints exist
- Problem space is large and complex

## Real-World Applications

### Greedy Applications
- Real-time resource allocation
- Simple scheduling problems
- Quick decision making
- Network routing

### Genetic Applications
- Complex resource allocation
- Investment portfolio optimization
- Factory floor layouts
- Delivery route optimization

## Comparison With Same Example
Using our previous example:

Greedy Solution:
- Selected: A, D
- Total Value: $52
- Total Weight: 7kg

Typical Genetic Solution (after multiple generations):
- Selected: A, B
- Total Value: $82
- Total Weight: 10kg
- Shows how genetic algorithm found better solution by trying multiple combinations
