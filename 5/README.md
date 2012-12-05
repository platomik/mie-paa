# MIE-PAA. Homework #5

## Solving the Knapsack problem by an advanced iterative method. Simulated Annealing.

### Descriptions of the algorithm

As we know from the lectures the Knapsack problem is NP-complete problem. It means in order to find the optimal solution of the problem we need exploring whole the state space. Number of nodes in the state space is growing exponentialy with linear growing size of instance.
To achive better time complexity in this task we are going to implement **simulated annealing**. It is stochastic heuristic search algorithm. The heuristic component is represented by an heuristic decision function and stochastic component adds to the algorithm randomness. Roughly speaking it is not exhaustive search approach (i.e. cost/weight heuristic from previous task) that based on heuristic function but it rather randomly search with heuristic function.

In the knapsack problem the heuristic function is f(x). It prompts - "is the solution better/worse than current?".

![](https://raw.github.com/platomik/mie-paa/master/3/KP-main-formula.jpg)

Let's look at the figure - the 3D-plot is drawn there perfectly illustrates benefits of a stohastic algorithm using. If we follow the princple "look around you if it's better there" then we almost never reach the maximum. We can only get local maximum which is worse. 

![](https://raw.github.com/platomik/mie-paa/master/5/pic1.jpg)
