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

Third we may notice temperature parameter in the statement. The higher temperature the worse solutions are acceptable more often. The lower temperature the the probability to choose worse solution is lower. If it converges to zero then algorithm becomes just heuristic without probabilistic component.

And finale, the cool function. We can start with temperature T0 and then after each step the temperature is decreased by exponential decay (http://en.wikipedia.org/wiki/Exponential_decay) Τ=α·Τ (usually a=0.8 .. 0.95). It makes sense to add in cool function number of steps without any improvements of heuristic function. Obviously this two parameters will define error in the solution of the algorithm and runtime.

### Experimental results.

First measurements is done for **the number of steps** in the cooling schedule. This number shows how many steps solution did not improved.

Parameters for the measurement:

	temperature decreasing coefficient alfa = 0.8
	initial temperature = 40

Results:

^Steps | 10 | 25 | 50 | 100 | 200 | 400 | 800 | 1600 |
^Runtime (sec) | 3 | 8 | 16 | 41 | 70 | 150 | 270 | 540 |
^Relative error(%) | 20.6 | 14 | 10.1 | 6.5 | 4.8 | 3.1 | 2.2 | 1.8 |

Please don't be surprised in the results of runtime. Processor was working in the slowdown mode to better estimate algorithm behaivour for different type of values.

We may notice linear correlation between runtime and number of steps.

If we try to represent both values on the same plot it should look like (better to use logarithmic scale for Y axis): 

![](https://raw.github.com/platomik/mie-paa/master/5/pic3.jpg)

We can make decision that k=100 number of steps can be optimal.

Second measurements is done for the parameter Alfa. It shows how fast/slow temperature is going down.

Parameters for the measurement:
	
	Number of steps k = 100
	initial temperature = 40
	
Results: 

^Alfa | 0.8 | 0.83 | 0.86 | 0.89 | 0.92 | 0.95 |
^Runtime (sec) | 40 | 44 | 48 | 49 | 50 | 48 |
^Relative error(%) | 7.2 | 6.4 | 6.3 | 5.8 | 6.3 | 5.9 |

![](https://raw.github.com/platomik/mie-paa/master/5/pic4.jpg)

The results are quite stable and we can observe very weak dependence on `Alfa` coefficient. Let's say Alfa = 0.85 is the optimal for the algorithm, but actually all alfas from the range 0.8..0.95 gives the same result.

The third measurements. Initial temperature. 

Parameters for the measurement:

	Number of steps k = 100
	Alfa = 0.85
	
Results:

^Initial temperature | 0.5 | 1 | 2 | 4 | 8 | 15 | 30 | 60 | 100 |
^Runtime (sec) | 23 | 24 | 26 | 27 | 31 | 33 | 48 | 43 | 52 |
^Relative error(%) | 25.9 | 21.1 | 20.8 | 18.1 | 15.9 | 12.4 | 7.9 | 5.4 | 8 |

![](https://raw.github.com/platomik/mie-paa/master/5/pic5.jpg)
