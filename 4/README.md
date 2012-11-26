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

**maximum weight:** Wmax = {30, 60, 90, 120, 240, 360}

**knapsack capacity to total weight ratio:** m = {0.1, 0.2, 0.4, 0.6, 0.9}

**granularity from small to big:** k = {0.1, 0.2, 0.4, 0.8, 1.6} 

** small or big items are prefered: ** d= {-1; 1}

### Results of the measurements

###### Number of items (instance size)

First measurement is done in the previous labs when we implemented different algorithms for the knapsack problem. And here we are summarizing all results in one plot.

![Instance](https://raw.github.com/platomik/mie-paa/master/4/instance.jpg)

We are forced to use logarithmic scale because Brute force algorithm has an exponential growing form.

Since Heuristic is not an exact algorithm we should estimate its solution quality:

![Instance2](https://raw.github.com/platomik/mie-paa/master/4/instance2.jpg)

*Notes:* It looks not bad idea to use Brute force algorithm on small instance sizes. It won the race for `Branch and bound` and `Dynamic programing` algorithm. `Heuristic` algorithm achive the best results but in the small instances it has huge relative error.

###### Maximum cost, Cmax
We can exclude `Brute force` algorithm from the resulting plot because of its insensitive to the Cmax parameter.

![Cmax](https://raw.github.com/platomik/mie-paa/master/4/costmax.jpg)

For the heuristic algorithm it would be interested to look at the solution quality plot:

![Cmax2](https://raw.github.com/platomik/mie-paa/master/4/costmax2.jpg)

*Notes:* BB (red curve) is very sensitive to the Cmax parameter whereas DP (blue curve) is more stable. Runtime and errors of Heuristic algorithm doesn't depened so much on this parameter.

###### Maximum weight, Wmax
Since our DP algorithm depends on weight parameter it could be good idea switch to runtime steps scale from runtime scale in this measurements.

![Wmax](https://raw.github.com/platomik/mie-paa/master/4/weightmax.jpg)

Relative error plot looks like:

![Wmax2](https://raw.github.com/platomik/mie-paa/master/4/weightmax2.jpg)

*Notes:* Linear function for DP algorithm whereas BB is quite stable. Heuristic algorithm is resistive for this parameter.

###### Knapsack capacity to total weight ratio.
BB, DP, HC dependence on the ratio parameter:
![Ratio](https://raw.github.com/platomik/mie-paa/master/4/ratio.jpg)

Errors of HC algorithm:
![Ratio2](https://raw.github.com/platomik/mie-paa/master/4/ratio2.jpg)

*Notes:* BB algorithm achives much better results for bigger ratio values whereas DP "doesn't care". Heuristic algorithm has acceptable relative error, but bad maximal values for small ratio.

###### Granularity from small to big
At the begining we represent results for small items which are specified by parameter `d` in the generator.
Here is `d=-1`.

![Granul](https://raw.github.com/platomik/mie-paa/master/4/granul.jpg)

![Granul2](https://raw.github.com/platomik/mie-paa/master/4/granul2.jpg)

For the big items specified by parameter `d=1`:

![Granul3](https://raw.github.com/platomik/mie-paa/master/4/granul3.jpg)

![Granul4](https://raw.github.com/platomik/mie-paa/master/4/granul4.jpg)

*Notes:* BB and DP have almost the same results for the small items. For the big items the difference becomes bigger and we can notice that BB is more sensitive to the granularity parameter. Relative error for the Heuristic algorithm is acceptable.


