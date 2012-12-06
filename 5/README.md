# MIE-PAA. Homework #5

## Solving the Knapsack problem by an advanced iterative method. Simulated Annealing.

### Descriptions of the algorithm

As we know from the lectures the Knapsack problem is NP-complete problem. It means in order to find the optimal solution of the problem we need exploring whole the state space. Number of nodes in the state space is growing exponentialy with linear growing size of instance.

To achive better time complexity in this task we are going to implement **simulated annealing**. It is stochastic heuristic search algorithm. The heuristic component is represented by an heuristic decision function and stochastic component adds to the algorithm randomness. Roughly speaking it is not exhaustive search approach (i.e. cost/weight heuristic from previous task) that based on heuristic function but it rather randomly search with heuristic function.

In the knapsack problem the heuristic function is `f(x)`. It prompts - "is the solution better/worse than current?".

![](https://raw.github.com/platomik/mie-paa/master/3/KP-main-formula.jpg)

Let's look at the figure - the 3D-plot is drawn there perfectly illustrates benefits of a stohastic algorithm using. If we follow the princple "look around you if it's better there" then we almost never reach the maximum. We can only get local maximum which is worse case. 

![](https://raw.github.com/platomik/mie-paa/master/5/pic1.jpg)

Simulated annealing method allows achive the maximum point. Because it has randomness component and from time to time worse scenarios can be choosen.

The name simulated annealing and inspiration come from annealing in metallurgy, a technique involving heating and controlled cooling of a material to increase the size of its crystals and reduce their defects, both are attributes of the material that depend on its thermodynamic free energy [Wikipedia]. What is of interest to us that is transition from one state to another. Statement for the conditional probability of mooving from one energy state `ei` to another `ej` under temperature is `T`:

![](https://raw.github.com/platomik/mie-paa/master/5/pic2.png)

where kB is the Boltzmann constant (http://en.wikipedia.org/wiki/Boltzmann_constant).

Let's go back from metallurgy to the simulated annealing algorithm. First of all we can neglect Boltzmann constant since it is applied for different ype of metals in our case it changes the result on some constant, so it is not interested for us so much.

Second, we should follow heuristic function - if it finds better solution then we should take it into account else we can use probabilistic method for choosing new state.

Third we can notice temperature parameter in the statement.
