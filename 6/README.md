# MIE-PAA. Homework #6

# MAX-SAT Solution Using Advanced Iterative Method. Genetic Algorithm implementation.

### SAT problem inroduction

SAT is satisfiability problem. We have Boolean expression written using only AND, OR, NOT, variables, and brackets. **The SAT problem is:** given the expression, is there some assignment of TRUE and FALSE values to the variables that will make the entire expression true?
	
	x1∧x2∨x3

**SAT3 problem** is a special case of SAT problem, where Boolean expression should have very strict form. It should be divided to clauses,such that every clause contains of three literals.

	(x1∨x2∨x3)∧(x5∨x6∨x7)

**MAX-SAT problem** is an generalization of SAT problem. The problem of determining the maximum number of clauses, of a given Boolean formula, that can be satisfied by some assignment.

**Weighted MAX-SAT** asks for the maximum weight which can be satisfied by any assignment, given a set of weighted clauses.

*Here is weighted 3-SAT problem going to be investigated.*

### Algorithm introduction

We will focus in the work on Genetic Algorithm implementation. It would be good mention some important terms that are going to be used during the research.

	Individual (phenotype) - configuration (solution).
	Chromosome - representation of a configuration. Consists of genes.	
	Gene - configuration (output) variable.	
	Locus - position of a given variable in a chromosome.	
	Genome (population) - how many individuals to simultaneously exist at each generation.	
	Generation - current genome.
	Strategies define some parameters for the basic operation of the genetic algorithm (selection, crossover, mutation).
	Fitness - cost function for each individual.
	
### Algorithm implementation description 

The algorithm is programmed in Perl language. Doing all semestral homeworks I was trying to estimate performance of the algorithms in different programming languages Perl/Python/C. Pure perl implementations had the worst memory consumption, but very nice cpu usage. 

Program has the following parameters for tunning genetic algorithm:

- population,
- crossover rate,
- mutation rate,	
- selection strategy,
- crossover strategy,
- generations,
- termination creteria

Program has a modular structure. Some parameters were implemented in separate modules for better scalability. Brief description of them:

 **ga.pl** - main file. procedure of parsing files. parameters of genetic algorithm. fitness function. results printing.

 **AI/Genetic.pm** - central module of GA. specifies main functions and subroutines. includes submodules.

 **AI/Genetic/Defaults.pm** - module of GA strategies and operations. 

 **AI/Genetic/IndBitVector.pm** - base class for Genes

 **AI/Genetic/Individual.pm** - base class for Individuals

 **AI/Genetic/OpCrossover.pm**  - implements various crossover operators. single point crossover, double point 
crossover, uniform crossover

 **AI/Genetic/OpMutation.pm** - implements the mutation mechanism.

 **AI/Genetic/OpSelection.pm** - implements various selection operators. Roulette Wheel, Tournament, Random.

### Input data

**Working instances**. From the [https://edux.fit.cvut.cz/courses/MI-PAA/_media/homeworks/06/ai-phys1.pdf] we know the hardest 3SAT problems has ratio 4.3 (ratio of the number of clauses to the number of variables). We will focus on the instances with this rate generated in DIMACS format. But there are measurements with different ratio as well. The instances are retrived from [http://www.cs.ubc.ca/~hoos/SATLIB/benchm.html]. Weights are generated randomly.

### Experiments and Results 

**Experiments with fitness function.**

The fitness function expects an list of genes, corresponding to the individual. It returns a number which defines the cost of the individual. The higher the score, the more fit the individual, the more the chance it has to be chosen for crossover.

Question: does it matter which fitness function to choose?
Let's denote **FC** - fitness function is the number of satisfied clauses. **FV** - for fitness function with number of input variables assigned to 1. **FWV** - fitness function is weights of input variables assigned to 1. **FC** -fitness function calculated by formula FB = (# of input variables assigned to 1) – 1000*(# of unsatisfied clauses). 

Experiment 1. Observe FC(blue)/FV(red)/FWV(yellow) relations for population=400, crossover ratio=0.95, mutation ratio=0.01 in the first generation. Choosen fitness function FC(blue).

![](https://raw.github.com/platomik/mie-paa/master/6/p1.jpg)

Experiment 2. Observe FV(red)/FWV(yellow) relations for population=400, crossover ratio=0.95, mutation ratio=0.01 in the first generation. Choosen fitness function FV(red).

![](https://raw.github.com/platomik/mie-paa/master/6/p2.jpg)

Experiment 3. Observe FB(blue)/FV(red)/FWV(yellow) relations for population=400, crossover ratio=0.95, mutation ratio=0.01 in the first generation. Choosen fitness function FB(blue).

![](https://raw.github.com/platomik/mie-paa/master/6/p3.jpg)

Experiment 4. The same as experiment 1 but for 100 generations. We need to estimate how the number of generations affects on the relation.

![](https://raw.github.com/platomik/mie-paa/master/6/p4.jpg)

Conclusion: We may notice relation between FW and FWV fitness functions only. They have the same shape but FWV has intrinsic randomness (because of random assigned weights). And FWV has more smoothed curve compared to FV (because of wider range of values). And there is no correlation between FC, FB, and FW fitness functions. But wich one to choose for the future experiments or work with all of them? Last experiment tell us draw attention on the number of generations in the Genetic Algorithm.

**Experiments with number of generations.**

A GA implementation runs for a discrete number of time steps called generations. From theoretical poing of view after a few generations, the population should converge on a "good-enough" solution.

Question: Estimate quality of population depending on a number of generations.

Experiment 5. Observe population for the fittness function based on the number of satisfied clauses. Subject to population=400, crossover ratio=0.95, mutation ratio=0.01.

![](https://raw.github.com/platomik/mie-paa/master/6/p5.jpg)

Experiment 6. Observe population for the fittness function based on the weighted input variables assigned to 1. Conditions are the same. Population=400, crossover ratio=0.95, mutation ratio=0.01.

![](https://raw.github.com/platomik/mie-paa/master/6/p6.jpg)

Conclusion: Individuals are distributed more widely in population for fittness function based on the weights. It allows avoid local minima of the function. Below we will use this fittness function it shows more interesting results. 20 number of generations looks reasonable value. But we will check it later.

**Experiments with number of generations and size of population.**

Question: What is the numbers for generations and population should we use. Or selection the maximum as possible values will lead to the best result. Algorithm is fast enough but a bit memory consumption. Experiments show storing and processing population of 10000 items long take 100MB memory. So we can not depend upon big population and generations. Let's choose reasonable numbers.

Experiment 7. Measurements for different population size and number of generations on the set of 20 values and 91 clauses.

Table shows the best/avg result achived for generations in rows and population in columns:

^generations\population ^20 ^100 ^500 ^2000 ^10000 |
^1 | 0.86/0.71 | 0.98/0.8 | 1.15/0.95 | 1.11/0.95 | 1.10/0.96 |
^10 | 0.89/0.76 | 0.98/0.79 | 1.06/0.87 | 1.12/0.94 | 1.28/0.98 |
^50 | 1.15/0.82 | 0.91/0.79 | 1.12/0.95 | 1.15/0.96 | 1.16/0.91 |
^200 | 0.95/0.79 | 1.02/0.82 | 1.02/0.88 | 1.06/0.88 | 1.18/0.93 |
^500 | 0.94/0.75 | 0.91/0.8 | 0.96/0.86| 1.14/0.96 | 1.17/0.98 |
^1000 | 0.79/0.73 | 0.99/0.81 | 0.97/0.88 | 1.05/0.91 | 1.2/0.95 |

Experiment 8. Measurements for different population size and number of generations on the set of 200 values and 860 clauses.

^generations\population ^20 ^100 ^500 ^2000 ^10000 |
^1 | 0.16/0.14 | 0.16/0.14 | 0.15/0.14 |  |  |
^10 |  |  | / |  |  |
^50 |  |  | / |  |  |
^200 |  |  | / |  |  |
^500 |  |  | / |  |  |
^1000 |  |  | / |  |  |


Conclusion: We may notice very good results on small populations and small numbers of generations. But it is accidentaly usually. Stably good results can be achived only on big populations. Number of generations doesn't affect so much on the result as the size of population. Just a few generations would be enough. Let's fix **# generations = 10, population size = 1000 **for the future measurements.

The size of formula (amount of clauses and variables) 

Parameters:
- ratio
- gens
- population
- crossover ratio
- mutation ratio
- strategy
- generations
- weight
- rel err/unsat ratio


### Conclusions
Does the algorithm return satisfactory solutions?
Does the algorithm return satisfactory solutions for instances of any size? How does the error grow with the instance size?
Does the algorithm have a sufficient iterative power? Does it converge correctly?
Is the algorithm adequatly fast?
Isn't there a useless time overhead? Cannot the algorithm be stopped earlier?




Ob

At low ratios: 
−few clauses (constraints)− 
many assignments− 
easily found 
•At high ratios: 
−many clauses− 
inconsistencies easily detected
