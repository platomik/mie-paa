# MIE-PAA. Homework #1 


## Solving the knapsack problem by brute force and simple heuristic

### Problem Statement

*The basics*

The **knapsack problem** or **rucksack problem** is a problem in combinatorial optimization: Given a set of items, each with a weight and a value, determine the number of each item to include in a collection so that the total weight is less than or equal to a given limit and the total value is as large as possible.

*Out task*

To solve the knapsack problem by brute force and simple heuristic algorithms. All experiments should be performed on sets of 50 instances of one size. 

All instances are saved in the text files, the files are named knap_n.inst.dat, where n is the instance size. Each row describes one instance. Each instance is identified by (ID), the number of items (n) and the knapsack capacity (M) follow. Next there are listed weights and costs of individual items.

### Analysis of possible solutions

**Brute force algorithm**

Brute force approach is examining all possible cobinations (for n-size instances = 2^n combinations). And construct a set **X={x1, x2, … ,xn }**, where each xi is 0 or 1, so that:

	w1x1 + w2x2 + … + wnxn < = M 
	
	c1x1 + c2x2 + … + cnxn is maximal.

The first requirement garantees that the knapsack is not overloaded. The second one gives max value of the kanpsack.

where,

	integer n (# of items)
	integer M (the capacity of the knapsack)
	finite set W = {w1, w2, … ,wn } (weights of items)
	finite set C = {c1, c2, … ,cn } (costs of items)

**Heuristic technique**

The simple greedy heuristic technique uses the cost/weight ratio. That is computed for each item and the items and then sorted by it.

The knapsack is then greedily filled starting with items with the highest ratio, until the first item that cannot be inserted is reached (the knapsack would be overfilled).

An alternative is to skip items that cannot be fitted, continue the search, and try to find a smaller item that yet fits.

### Brief description of your solution, description of the algorithms used

**Brute force technique**

To generate a set *X* of ones and zeros for each item in the instance a very simple trick was used. We know that # of combinations is equal to 2^n, where n - is # of items.
So if go from 0 to 2^n and convert this decimal numbers to binary view, we will get exatly the set X that we need.

For example, for the instance of 3 items we have 2^3=8 combinations. It means we should go from 0 to 7:

	0 -> X={0,0,0}
	1 -> X={0,0,1}
	2 -> X={0,1,0}
	3 -> X={0,1,1}
	4 -> X={1,0,0}
	5 -> X={1,0,1}
	6 -> X={1,1,0}
	7 -> X={1,1,1}

In this exhaustive search all requirements mentioned above should fulfilled.

**Heuristic technique**

First of all array with cost/weight ratio must be constructed. Then this array must be sorted. And finally the knapsack must be filled by items step by step from expensive to cheaper. If the knapsack is overloaded when the new item is come in then this item must be left. Procedure is completed when the last item is checked.
	
### The experimental results. You are encouraged to use tables, graphs, etc.

**Brute force technique**

Observation the dependency of the computational time on the instance size:

<table>
    <tr>
        <td><strong>Size</strong></td>
        <td>4</td><td>10</td><td>15</td><td>20</td><td>22</td><td>25</td><td>27</td><td>30</td><td>32</td><td>35</td><td>37</td><td>40</td><tr>
    <tr>
        <td><strong>Time</strong></td>
        <td>0.15 sec</td><td>0.81 sec</td><td>37 sec</td><td>25 min</td><td>2 h</td><td>16 h</td><td></td><td></td><td></td><td></td><td></td><td></td>
    </tr>
</table>

Due to lack of computational power it was impossible to complete this table. But the trend has exponential form and it's quite obviously.

![Brute force time](https://github.com/platomik/mie-paa/blob/master/1/bruteforcetime.jpg)

**Heuristic technique**

Observation the dependency of the computational time on the instance size:

<table>
    <tr>
        <td><strong>Size</strong></td>
        <td>4</td><td>10</td><td>15</td><td>20</td><td>22</td><td>25</td><td>27</td><td>30</td><td>32</td><td>35</td><td>37</td><td>40</td><tr>
    <tr>
        <td><strong>Time</strong></td>
        <td>0.15 sec</td><td>0.81 sec</td><td>37 sec</td><td>25 min</td><td>2 h</td><td>16 h</td><td></td><td></td><td></td><td></td><td></td><td></td>
    </tr>
</table>

### Conclusions: Interpretation of the results and discussion on the results obtained

### Link to the sourcecode.
