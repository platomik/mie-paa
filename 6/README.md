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
- generations

Program has a modular structure. Some parameters were implemented in separate modules for better scalability. Brief description of them:

 **ga.pl** - main file. procedure of parsing files. parameters of genetic algorithm. fitness function. results printing.
 **AI/Genetic.pm** - central module of GA. specifies main functions and subroutines. includes submodules.
 **AI/Genetic/Defaults.pm** - module of GA strategies and operations. 
 **AI/Genetic/IndBitVector.pm** - base class for Genes
 **AI/Genetic/Individual.pm** - base class for Individuals
 **AI/Genetic/OpCrossover.pm**  - implements various crossover operators. single point crossover, double point crossover, uniform crossover
 **AI/Genetic/OpMutation.pm** - implements the mutation mechanism.
 **AI/Genetic/OpSelection.pm** - implements various selection operators. Roulette Wheel, Tournament, Random.

### Input data

**Working instances**. From the [https://edux.fit.cvut.cz/courses/MI-PAA/_media/homeworks/06/ai-phys1.pdf] we know the hardest 3SAT problems has ratio 4.3 (ratio of the number of clauses to the number of variables). We will focus on the instances with this rate generated in DIMACS format. But there are measurements with different ratio as well. The instances are retrived from [http://www.cs.ubc.ca/~hoos/SATLIB/benchm.html]. Weights are generated randomly.

## Working with the heuristics
Parameters:
- ratio
- gens
- fitness func
- population
- crossover ratio
- mutation ratio
- strategy
- generations
- weight
- rel err/unsat ratio


## Conclusions
Does the algorithm return satisfactory solutions?
Does the algorithm return satisfactory solutions for instances of any size? How does the error grow with the instance size?
Does the algorithm have a sufficient iterative power? Does it converge correctly?
Is the algorithm adequatly fast?
Isn't there a useless time overhead? Cannot the algorithm be stopped earlier?


	The fitness function should expect only one argument, an anonymous list of genes, corresponding to the individual being analyzed. It is expected to return a number which defines the fitness score of the said individual. The higher the score, the more fit the individual, the more the chance it has to be chosen for crossover.


Ob

At low ratios: 
−few clauses (constraints)− 
many assignments− 
easily found 
•At high ratios: 
−many clauses− 
inconsistencies easily detected
