# MIE-PAA. Homework #3

## Solving the knapsack problem by DP, B&B, and by APX algorithm

We come back to the classical 0-1 knapsack problem where a subset of **N** items is given and has to be packed in a knapsack of capacity **M**. Each item has two characteristics: weight **W** and cost **C**. The problem is to pack knapsack in such way to reach the most maximum profit.

The system of equations is hold:

![KP](https://raw.github.com/platomik/mie-paa/master/3/KP-main-formula.jpg)

Let's remind the basic conclusion for the knapsack problem solving from the 1st homework - We should not expect efficient solution of the problem due to the NP-hardness. Time complexity is growing exponentaly for a linear growing number of items. 

### Branch and bound (B&B) method

Generally, the **Branch & Bounds method** consists of several phases:

######Branching:
Break up the feasible region into successively smaller subsets. 

![Branching phase](https://raw.github.com/platomik/mie-paa/master/3/branching.jpg)

######Bounding:
Calculate bounds on the objective values over each corresponding submodel.

###### Relaxation: 
Bounds are obtained by replacing the current submodel by an easier model such that the solution of the latter yields a bound for the former. 

######Fathoming:
Use the objective values of the submodels to discard certain submodels from further consideration. 

######End: 
End is reached either when each submodel has produced an infeasible solution or has been shown to contain no better solution than the one already at hand. The best solution found is the optimal solution. 

The **B&B method** is always based on pruning the search space based on the cost function. In case of the The Knapsack Problem it is the knapsack cost. So we will use the optimality criterion (the cost) as the bounding factor.
In case of solving the knapsack problem using recursion, it is possible to store the best solution ever found during the search. Then, we can check in each recursion call, if the potential solution obtained from this recursion branch can have a better cost than the currently best one (i.e. potentially produce a better solution). If not, it is useless to enter this branch. 

######Basic principles
- In each step of recursion we know which items have been tried for addition to the knapsack and which ones have not been tried yet.
- The upper bound of the knapsack cost is obtained as a sum of costs of items present in the knapsack and a sum of costs of the undecided items.
- If this upper bound is less than the cost of the currently best solution, the recursion branch needs not be called, since it cannot produce a better solution.

**Branch and bound** constructs a binary tree where each node is a solution. Every level corresponds to one item. Building the entire tree would take exponential time. The algorithm calculates an upper bound for the maximum value a solution in a given subtree could theoretically have; it doesn't build the subtree if the upper bound is not greater than the value of the best practical solution currently known. 

######Results of the B&B method implementation for the Knapsack problem and compare it with the Brute Force approach

<table>
    <tr>
        <td><strong>Size</strong></td>
        <td>4</td><td>10</td><td>15</td><td>20</td><td>22</td><td>25</td><td>27</td><td>30</td><td>32</td><td>35</td><td>37</td><td>40</td><tr>
    <tr>
        <td><strong>Time BF</strong></td>
        <td>0.15 sec</td><td>0.81 sec</td><td>37 sec</td><td>25 min</td><td>2 h</td><td>16 h</td><td></td><td></td><td></td><td></td><td></td><td></td>
    </tr>
    <tr>
        <td><strong>Time BB</strong></td>
        <td> 1 sec</td><td> 1 sec</td><td> 1 sec</td><td>3 sec</td><td>9 sec</td><td>12 sec</td><td>25 sec</td><td>1m 40 sec</td><td>2m 40 sec</td><td>12m 30 sec</td><td>> 1h</td><td></td>
    </tr>
</table>


### Dynamic programming

**Dynamic programming method**  is based on breaking complex problems down into simpler subproblems ( **decomposition** ). There are two possible decompositions for the knapsack problem:

- by the total cost
- by the knapsack capacity

We will use the second one.

###### Decomposition by the knapsack capacity ######

Algorithm allocates an array with as many elements as the knapsack can hold unit weights. Then it loops over this array once for every item. We can assume that the time the algorithm has to spend on each element in each iteration is a constant. It means that dynamic programming takes time in **Θ(Mn)**, where *M* is the capacity in unit weights of the knapsack and *n* is the number of items it has to consider.

######Results of the dynamic programming approach implementation for the Knapsack problem

<table>
    <tr>
        <td><strong>Size</strong></td>
        <td>4</td><td>10</td><td>15</td><td>20</td><td>22</td><td>25</td><td>27</td><td>30</td><td>32</td><td>35</td><td>37</td><td>40</td><tr>
    <tr>
        <td><strong>Time DP</strong></td>
        <td>0.2 sec</td><td>0.2 sec</td><td>0.4 sec</td><td>0.8 sec</td><td>0.8 sec</td><td>0.9 sec</td><td>1.1 sec</td><td>1.1 sec</td><td>1.4 sec</td><td>1.5 sec</td><td>1.7 sec</td><td>1.7 sec</td>
    </tr>
</table>    

### FPTAS approximation algorithm

**FPTAS (Fully Polynomial Time Approxima tion Scheme)** is a popular approach for finding solution in greeding solvable tasks. FPTAS can find solution with a selected precision.
So we can say that **FPTAS** is approximation algorithm where the level of precision E acts as the new parameter and algorithm finds E-optimal solution in the time limited by polynomial of # items and value of 1/E.

*Question:* what will happen if we round costs of items c1,c2,c3 ... cn, take integer division down of these values by a parameter `scale` and then multiply it by `scale`?

![Scale](https://raw.github.com/platomik/mie-paa/master/3/scale.jpg)

######Algorithm for selection lightest items.

![FPTAS1](https://raw.github.com/platomik/mie-paa/master/3/fptas1.jpg)

- *ci* could be divided by `scale` => it will not change optimal set
- time complexity ![FPTAS2](https://raw.github.com/platomik/mie-paa/master/3/fptas2.jpg)
- valuables of items are still the same => any solution for the approximation task is solution for the original task
- "loss of rounding" => solution of the approximation task is less than the original task solution

######Is the game worth the candle? We need to estimate the relation between speedup of the algorithm and sacrifice of accuracy of its solution.

![FPTAS3](https://raw.github.com/platomik/mie-paa/master/3/fptas3.jpg)

Let's look how much worse the optimal solution of the approximation task ![fbar](https://raw.github.com/platomik/mie-paa/master/3/fbar.jpg) than the optimal solution of the original task ![fstar](https://raw.github.com/platomik/mie-paa/master/3/fstar.jpg).

![FPTAS4](https://raw.github.com/platomik/mie-paa/master/3/fptas4.jpg)

So for the absolute error we have:

![FPTAS5](https://raw.github.com/platomik/mie-paa/master/3/fptas5.jpg)

If we claim that the absolute error can not be bigger than ![FPTAS6](https://raw.github.com/platomik/mie-paa/master/3/fptas6.jpg) , then approximation will be *e*-optimal solution.

![FPTAS7](https://raw.github.com/platomik/mie-paa/master/3/fptas7.jpg)

Obviously to achieve better runtime of the approximation algorithm ![FPTAS8](https://raw.github.com/platomik/mie-paa/master/3/fptas8.jpg) we should maximize parameter `scale`. But we also should follow limitation for `scale` : ![FPTAS9](https://raw.github.com/platomik/mie-paa/master/3/fptas9.jpg). Problem is we don't know value of the optimal solution ![Fstar](https://raw.github.com/platomik/mie-paa/master/3/fstar.jpg), but we can bound it:

![FPTAS10](https://raw.github.com/platomik/mie-paa/master/3/fptas10.jpg)

From now task comes to choosing lower bound ![FLB](https://raw.github.com/platomik/mie-paa/master/3/flb.jpg), which could be found very fast and must be close to ![Fstar](https://raw.github.com/platomik/mie-paa/master/3/fstar.jpg) as much as possible.

e.g., we can use trivial approximation "Max-Item-Cost":

![FPTAS11](https://raw.github.com/platomik/mie-paa/master/3/fptas11.jpg)

for this approximation we can deduce complexity of the algorithm:

![FPTAS12](https://raw.github.com/platomik/mie-paa/master/3/fptas12.jpg)

######Can we do it better?

Perhaps, Yes! If we have a look back to the heuristic algorithm from the 1st homework we should notice, that
for ![FG](https://raw.github.com/platomik/mie-paa/master/3/fg.jpg) - solution of the heuristic algorithm and ![FStar3](https://raw.github.com/platomik/mie-paa/master/3/fstar.jpg) - optimal solution is true:

![FPTAS13](https://raw.github.com/platomik/mie-paa/master/3/fptas13.jpg)

Now let's apply this assumption for current approximation algorithm:

![FPTAS14](https://raw.github.com/platomik/mie-paa/master/3/fptas14.jpg)

![FPTAS15](https://raw.github.com/platomik/mie-paa/master/3/fptas15.jpg)

And finally complexity of the algorithm looks like:

![FPTAS16](https://raw.github.com/platomik/mie-paa/master/3/fptas16.jpg)

So we have improved previous approximation algorithm and reach better complexity of solution.

######Results of the FPTAS algorithm implementation for the a selected set of 40 items:

<table>
    <tr>
    	<td><strong>Algorithm</strong></td>
    	<td><strong>Epsilon</strong></td>
        <td><strong>Runtime</strong></td>
        <td><strong>Avg Error</strong></td>
        <td><strong>Max Error</strong></td>
    </tr>
    <tr>
    	<td>Trivial approximation O(n^3/ε)</td>
    	<td>0.25</td>
    	<td>37,8 sec</td>
    	<td>0%</td>
    	<td>0%</td>
    </tr>
    <tr>
    	<td>Trivial  approximation O(n^3/ε)</td>
    	<td>0.5</td>
    	<td>16,8 sec</td>
    	<td>0.11%</td>
    	<td>0.29%</td>
    </tr>
    <tr>	
    	<td>Trivial approximation O(n^3/ε)</td>
    	<td>0.75</td>
    	<td>13,2 sec</td>
    	<td>0.12%</td>
    	<td>0.33%</td>
    </tr>    
    <tr>
    	<td>Trivial approximation O(n^3/ε)</td>
    	<td>0.95</td>
    	<td>11,0 sec</td>
    	<td>0.18%</td>
    	<td>0.54%</td>
    </tr>
    <tr>
    	<td>Non-trivial approximation O(n^2/ε)</td>
    	<td>0.25</td>
    	<td>2.6 sec</td>
    	<td>1.8%</td>
    	<td>5.8%</td>
    </tr>
    <tr>
    	<td>Non-trivial approximation O(n^2/ε)</td>
    	<td>0.5</td>
    	<td>2,1 sec</td>
    	<td>3.8%</td>
    	<td>9.3%</td>
    </tr>
    <tr>	
    	<td>Non-trivial approximation O(n^2/ε)</td>
    	<td>0.75</td>
    	<td>1.5 sec</td>
    	<td>4.7%</td>
    	<td>14.2%</td>
    </tr>    
    <tr>
    	<td>Non-trivial approximation O(n^2/ε)</td>
    	<td>0.95</td>
    	<td>1.4 sec</td>
    	<td>4.9%</td>
    	<td>11.3%</td>
    </tr>
</table>    


### Conclusions

**B&B method** tends to be slower than dynamic programming. The algorithm is intrinsically more complex.

**DP** is usually faster, sometimes very much. One reason is that dynamic programming constructs and stores fewer solutions. Another reason - it does less work for every solution it builds. For larger problems there is a third reason - memory consumption. 

**DP** limits the number of solutions it actively considers at any one point to M, the capacity of the knapsack in unit weights. B&B does not.  But DP tends to lose for B&B on problems with large capacities of knapsack.

**FPTAS** algorithm was implemented with two different cost lower bound functions. That leads to different complexety of the algorithm.

### Links to the sourcecodes.

[Branch and bound algorithm](https://github.com/platomik/mie-paa/blob/master/3/branch.pl "Branch and bound algorithm") 

[Dynamic programming](https://github.com/platomik/mie-paa/blob/master/1/heuristic.pl "Dynamic programming") 

[FPTAS](https://github.com/platomik/mie-paa/blob/master/1/fptas.pl "FPTAS") 