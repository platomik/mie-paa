# MIE-PAA. Homework #2


## the "Buckets" Problem

### Description of the heuristic

*The basics*

The **knapsack problem** or **rucksack problem** is a problem in combinatorial optimization: Given a set of items, each with a weight and a value, determine the number of each item to include in a collection so that the total weight is less than or equal to a given limit and the total value is as large as possible.

### Lengths of the paths for the individual examples


### Number of visited state space nodes for the individual instances. It is a good measure of the quality of the heuristic. Both for your heuristic and BFS.

	
### Voluntarily you can solve the problem using depth-first search (DFS)

<table>
    <tr>
        <td><strong>Size</strong></td>
        <td>4</td><td>10</td><td>15</td><td>20</td><td>22</td><td>25</td><td>27</td><td>30</td><td>32</td><td>35</td><td>37</td><td>40</td><tr>
    <tr>
        <td><strong>Time</strong></td>
        <td>0.15 sec</td><td>0.81 sec</td><td>37 sec</td><td>25 min</td><td>2 h</td><td>16 h</td><td></td><td></td><td></td><td></td><td></td><td></td>
    </tr>
</table>


![Brute force time](https://raw.github.com/platomik/mie-paa/master/1/bruteforcetime.jpg)

### Link to the sourcecode.

All programs for the homework #1 have been writen in Perl language and have been deployed on github repository.

[Brute force algorithm](https://github.com/platomik/mie-paa/blob/master/1/bruteforce.pl "Brute force algorithm") 

[Heuristic algorithm](https://github.com/platomik/mie-paa/blob/master/1/heuristic.pl "Heuristic algorithm") 

Error calculations have been done in console line by awk, sed, diff commands. The graph has been plotted in the R project for statistical computing.