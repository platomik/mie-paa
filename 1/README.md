# MIE-PAA. Homework #1 


## Solving the knapsack problem by brute force and simple heuristic

### Problem Statement

*The basics*

The **knapsack problem** or **rucksack problem** is a problem in combinatorial optimization: Given a set of items, each with a weight and a value, determine the number of each item to include in a collection so that the total weight is less than or equal to a given limit and the total value is as large as possible.

*Out task*

To solve the knapsack problem by brute force and simple heuristic algorithms. All experiments should be performed on sets of 50 instances of one size. 

All instances are saved in the text files, the files are named knap_n.inst.dat, where n is the instance size. Each row describes one instance. Each instance is identified by (ID), the number of items (n) and the knapsack capacity (M) follow. Next there are listed weights and costs of individual items.

### Analysis of possible solutions

*Brute force algorithm*

Brute force approach is examining all possible cobinations (for n-size instances = 2^n combinations). And construct a set **X={x1, x2, … ,xn }**, where each xi is 0 or 1, so that:

	w1x1 + w2x2 + … + wnxn < = M 
	
	c1x1 + c2x2 + … + cnxn is maximal.

The first requirement garantees that the knapsack is not overloaded. The second one gives max value of the kanpsack.

where,

	integer n (# of items)
	integer M (the capacity of the knapsack)
	finite set W = {w1, w2, … ,wn } (weights of items)
	finite set C = {c1, c2, … ,cn } (costs of items)

*Heuristic technique*


### Brief description of your solution, description of the algorithms used

### The experimental results. You are encouraged to use tables, graphs, etc.

### Conclusions: Interpretation of the results and discussion on the results obtained

### Link to the sourcecode.
