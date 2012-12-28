# MIE-PAA. Homework #6

## MAX-SAT Solution Using Advanced Iterative Method. Genetic Algorithm implementation.

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
Generation - current genome .

**Main Operations.**
Selection. Here the performance of all the individuals is evaluated based on the fitness function, and each is given a specific fitness value. The higher the value, the bigger the chance of an individual passing its genes on in future generations through mating (crossover).

Crossover. Here, individuals selected are randomly paired up for crossover (aka sexual reproduction). This is further controlled by the crossover rate specified and may result in a new offspring individual that contains genes common to both parents. New individuals are injected into the current population.

Mutation. In this step, each individual is given the chance to mutate based on the mutation probability specified. If an individual is to mutate, each of its genes is given the chance to randomly switch its value to some other state.

Strategies:
	
Fitness
The fitness function should expect only one argument, an anonymous list of genes, corresponding to the individual being analyzed. It is expected to return a number which defines the fitness score of the said individual. The higher the score, the more fit the individual, the more the chance it has to be chosen for crossover.

### Algorithm implementation description 

Key: Use fixed-clause-lengthmodel. 
(Mitchell, Selman, and Levesque 1992) 
•Critical parameter: ratio of the number of clauses 
to the number of variables. 
•Hardest 3SAT problems at ratio = 4.3

At low ratios: 
−few clauses (constraints)− 
many assignments− 
easily found 
•At high ratios: 
−many clauses− 
inconsistencies easily detected


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

### Input data

## Conclusions
Does the algorithm return satisfactory solutions?
Does the algorithm return satisfactory solutions for instances of any size? How does the error grow with the instance size?
Does the algorithm have a sufficient iterative power? Does it converge correctly?
Is the algorithm adequatly fast?
Isn't there a useless time overhead? Cannot the algorithm be stopped earlier?


