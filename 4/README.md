# MIE-PAA. Homework #4

## Knapsack algorithms: experimental evaluation

### Introduction

The idea is to find correlation between characteristic features of the generated input sequence (specified parameters at generation phase) and results of algorithms implementation.

We can imagine that an algorithm is a black box which is always for each input sequence gives output result.
But if we would be able to tune somehow input sequence we can expect the result in the different time (time complexity) and sometimes even different result (solution quality).

We are going to analize following algorithms:

- Brute Force
- Branch and Bound
- Dynamic programming
- Cost/weight heuristic

and explore dependency of 

- the computational complexity (# of algorithm steps, runtime) and 
- the relative error (in case of the heuristic) 

on:

- instance size (# of items)
- maximum cost
- maximum weight
- knapsack capacity to total weight ratio
- granularity


### Descriptions of the algorithms

**Brute force (BF)**
- evaluate all the possibilities & choose the best one 
- always yields an optimum solution 
- often extremely time-consuming 
- complexity O(2^n) 

**Branch and Bounds (BB)**
- enhancement of backtracking
- based on pruning the search space based on the cost function (knapsack cost)
- uses recursion
- optimal solution
- Best-first search with b&b pruning
- asymptotic complexity O(2^n) 

**Dynamic Programing (DP)**
- computes the solutions to the subsub-problems once and store the solutions in a table, so that they can be reused (repeatedly) later.
- based on decomposition
- trades space for time.
- complexity. it depends. O(n.M) (e.g.)

**Cost/weight heuristic (HC)**
- simple greedy heuristic. 
- cost/weight ratio is computed for each item and the items are then sorted by it.
- the knapsack is then greedily filled starting with items with the highest ratio, until the first item that cannot be inserted is reached (the knapsack would be overfilled).
- an alternative is to skip items that cannot be fitted, continue the search, and try to find a smaller item that yet fits.

### Experimental setup. Statistical parameters of the instances.

We are going to discover algorithm dependency on such parameters:

**instance size (# of items):** n = {4, 10, 20, 25, 32}

**maximum cost:** Cmax = {30, 60, 120, 240, 360}

**maximum weight:** Wmax = {40, 60, 80, 100, 120, 140, 160, 180, 200}

**knapsack capacity to total weight ratio:** m = {0.1, 0.2, 0.3, 0.5, 0.8, 1.0}

**granularity from small to big:** k = {-0.4, -0.2, -0.1, -0.05, 0, 0.05, 0.1, 0.2, 0.4} 

### Results of the measurements

###### Number of items (instance size)

First measurement is done in the previous labs when we implemented different algorithms for the knapsack problem.
And here we are summarizing all results in one plot.

![Instance](https://raw.github.com/platomik/mie-paa/master/4/instance.jpg)

We are forced to use logarithmic scale because Brute force algorithm has an exponential growing form.

Since Heuristic is not an exact algorithm we should estimate its solution quality:

![Instance2](https://raw.github.com/platomik/mie-paa/master/4/instance2.jpg)

###### Maximum cost
We can exclude `Brute force` algorithm from the resulting plot because of its insensitive to the Cmax parameter.

![Cmax](https://raw.github.com/platomik/mie-paa/master/4/costmax.jpg)

For the heuristic algorithm it would be interested to look at the solution quality plot:

![Cmax2](https://raw.github.com/platomik/mie-paa/master/4/costmax2.jpg)

Maximum weight (BB DP) (Heur) J Z
Ratio (BB DP) (Heur) JZ
Granul (BB DP) (Heur) JZ



