# MIE-PAA. Homework #3

## Solving the knapsack problem by DP, B&B, and by APX algorithm

We come back to the classical 0-1 knapsack problem where a subset of **N** items is given and has to be packed in a knapsack of capacity **M**. Each item has two characteristics: weight **W** and cost **C**. The problem is to pack knapsack in such way to reach the most maximum profit.

The system of equations is hold:

![KP](https://raw.github.com/platomik/mie-paa/master/3/KP-main-formula.jpg)

Let's remind the basic conclusion for the knapsack problem solving from the 1st homework - We should not expect efficient solution of the problem due to the NP-hardness. Time complexity is growing exponentaly for a linear growing number of items. 

### Branch and bound (B&B) method

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