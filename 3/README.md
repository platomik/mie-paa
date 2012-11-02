# MIE-PAA. Homework #3

## Solving the knapsack problem by DP, B&B, and by APX algorithm

We come back to the classical 0-1 knapsack problem where a subset of **N** items is given and has to be packed in a knapsack of capacity **M**. Each item has two characteristics: weight **W** and cost **C**. The problem is to pack knapsack in such way to reach the most maximum profit.

The system of equations is hold:

![KP](https://raw.github.com/platomik/mie-paa/master/3/KP-main-formula.jpg)

Let's remind the basic conclusion for the knapsack problem solving from the 1st homework - We should not expect efficient solution of the problem due to the NP-hardness. Time complexity is growing exponentaly for a linear growing number of items. 

### Branch and bound (B&B) method

Generally, the **Branch & Bounds method** consists of several phases:

######Branching:######
Break up the feasible region into successively smaller subsets. 

![Branching phase](https://raw.github.com/platomik/mie-paa/master/3/branching.jpg)

######Bounding:######
Calculate bounds on the ob jective values over each corresponding submodel.

######Relaxation:###### 
Bounds are obtained by replacing the current submodel by an easier model such that the solution of the latter yields a bound for the former. 

######Fathoming: ######
Use the ob jective values of the submodels to discard certain submodels from further consideration. 

######End: ######
End is reached either when each submodel has produced an infeasible solution or has been shown to contain no better solution than the one already at hand. The best solution found is the optimal solution. 


is always based on pruning the search space based on the cost function. In case of the The Knapsack Problem it is the knapsack cost. So we will use the optimality criterion (the cost) as the bounding factor.
In case of solving the knapsack problem using recursion, it is possible to store the best solution ever found during the search. Then, we can check in each recursion call, if the potential solution obtained from this recursion branch can have a better cost than the currently best one (i.e. potentially produce a better solution). If not, it is useless to enter this branch. 

######Basic principles######
- In each step of recursion we know which items have been tried for addition to the knapsack and which ones have not been tried yet.
- The upper bound of the knapsack cost is obtained as a sum of costs of items present in the knapsack and a sum of costs of the undecided items.
- If this upper bound is less than the cost of the currently best solution, the recursion branch needs not be called, since it cannot produce a better solution.

4	< 1sec
10	< 1 sec
15	< 1 sec
20	3 sec
22	9 sec
25	12 sec
27	25 sec
30	1m40sec
32  2m40sec
35	12m30sec
37	> 1h
40


*Heuristic basics*