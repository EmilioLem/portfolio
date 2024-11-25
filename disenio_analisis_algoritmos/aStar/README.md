# A* Pathfinding Algorithm

## Overview
A* (pronounced "A-star") is an informed search algorithm that finds the shortest path between two points. It's widely used in video games, robotics, and navigation systems due to its efficiency and accuracy.

## Core Concept
A* combines two key elements:
- **g(n)**: Cost from start to current node
- **h(n)**: Estimated cost from current node to goal (heuristic)
- **f(n) = g(n) + h(n)**: Total estimated path cost

## How It Works

### 1. Basic Components
- **Open List**: Nodes to be evaluated
- **Closed List**: Already evaluated nodes
- **Parent References**: Each node remembers which node led to it

### 2. Main Algorithm Steps
1. Add start node to open list
2. Repeat until goal is reached:
   - Choose node with lowest f(n) from open list
   - Move it to closed list
   - Check all adjacent nodes:
     - If impassable or in closed list, ignore
     - If not in open list, add it
     - If already in open list, check if new path is better

### 3. Heuristic Function (h)
Common heuristics for grid-based maps:
- **Manhattan Distance**: |x1-x2| + |y1-y2|
  - Best for 4-directional movement
- **Euclidean Distance**: √((x1-x2)² + (y1-y2)²)
  - Best for any-angle movement
- **Diagonal Distance**: max(|x1-x2|, |y1-y2|)
  - Best for 8-directional movement

## Example Scenario

Consider this grid (S=Start, E=End, #=Wall):
```
S . . . #
. # . . .
. # . # .
. . . . E
```

A* progression:
1. Start at S with f(n) = g(0) + h(distance to E)
2. Explore neighbors, adding to open list
3. Choose lowest f(n) node
4. Continue until reaching E
5. Follow parent references back to get path

## Properties

### Advantages
- Guaranteed to find shortest path
- More efficient than Dijkstra's algorithm
- Flexible with different heuristics
- Works with various grid types

### Limitations
- Memory intensive (stores all nodes)
- Heuristic calculation can be complex
- May be overkill for simple pathfinding

## Common Optimizations

1. **Binary Heap**
   - Use for open list
   - Faster node selection

2. **Tie Breaking**
   ```
   f(n) = g(n) + h(n) * (1.0 + p)
   // where p is a small number (e.g., 0.001)
   ```
   - Helps choose better paths when f(n) is equal

3. **Path Smoothing**
   - Post-process path to remove unnecessary steps
   - Creates more natural movement

## Implementation Tips

1. **Movement Costs**
   - Straight moves: 1.0
   - Diagonal moves: √2 (≈1.414)
   - Different terrain: Variable costs

2. **Node Structure**
   ```
   struct Node {
       position
       g_cost
       h_cost
       f_cost
       parent
   }
   ```

3. **Completion Check**
   - Check if current node is goal
   - Or if open list is empty (no path)

## Common Applications

1. **Video Games**
   - NPC movement
   - Real-time strategy games
   - Auto-navigation systems

2. **Robotics**
   - Autonomous navigation
   - Path planning
   - Obstacle avoidance

3. **GPS Systems**
   - Route planning
   - Traffic avoidance
   - Alternative path finding
