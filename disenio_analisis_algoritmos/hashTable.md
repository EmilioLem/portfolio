# Hash Tables: A Conceptual Overview

## What is a Hash Table?
A hash table is a data structure that maps keys to values using a special function called a hash function. Think of it like a very efficient dictionary where you can instantly look up any word.

## Real-World Applications
- Dictionary implementations in programming languages (Python's dict, JavaScript's objects)
- Database indexing
- Caching systems
- Symbol tables in compilers
- Blockchain (hash functions are crucial)
- Cryptography (though with more sophisticated hash functions)

## Hash Functions
A hash function takes a key and converts it into an array index. Good hash functions:
- Always produce the same output for the same input
- Distribute values evenly across the available space
- Are quick to compute

### Example Hash Function
For storing strings, a simple (though not production-ready) hash function might:
1. Take each character's ASCII value
2. Multiply by a prime number
3. Sum all values
4. Take modulo of array size

For example, with array size 10:
```
hash("cat") = (('c' * 31 + 'a' * 31 + 't' * 31) % 10)
```

## Why O(1) Time Complexity?
Hash tables achieve O(1) average time complexity because:
1. The hash function directly computes the storage location
2. No matter how big the hash table gets, it takes the same number of steps:
   - Calculate hash (constant time)
   - Access array position (constant time)

Think of it like knowing exactly which page a word is on in a dictionary without having to search through it.

## Example: Storing Names in a Hash Table

Let's say we have a hash table of size 5 and we're storing names:

Initial empty table:
```
[0] → empty
[1] → empty
[2] → empty
[3] → empty
[4] → empty
```

After adding "Alice" (hash = 3):
```
[0] → empty
[1] → empty
[2] → empty
[3] → Alice
[4] → empty
```

After adding "Bob" (hash = 3 too - collision!):
```
[0] → empty
[1] → empty
[2] → empty
[3] → Alice → Bob  (chaining)
[4] → empty
```

## Collision Handling
When two keys hash to the same location, we need a strategy to handle it. Common approaches:

1. **Chaining** (shown above):
   - Store multiple items in the same slot using a linked list
   - Simple but can use extra memory

2. **Open Addressing**:
   - If slot is taken, try next slot
   - Keep trying until finding an empty slot
   - Example methods:
     - Linear Probing: Try next slot, then next, then next...
     - Quadratic Probing: Try slot + 1², then slot + 2², then slot + 3²...

## Performance Considerations
- Load Factor = Items stored / Table size
- Should typically keep load factor below 0.7
- When load factor gets too high:
  - More collisions occur
  - Performance degrades
  - Table should be resized and items rehashed
