# MIE-PAA. Homework #2


## the "Buckets" Problem

### Description of the heuristic

*Heuristic basics*

We can base heuristic algorithm on a priority queue. Just a small modification for the general BFS algorithm will give us more smarter and faster algorithm. 

*How to calculate metrics for each outcome sequence.*

One of the ways could be the difference (in absolute value) between the elements of genereated and target sequences.

P=SUM(abs(Ci-Ti)); Ci - i-th element in a generated sequence; Ti - i-th element in the target sequence;

As the result we get priority for each generated sequence.

*Technique*

At every step an element with the highest priority is choosen.

*Notes*

Obviously the BFS algorithm gives the smallest depth in the solution tree. Because at every step the BFS algorithm generates all possible sequences. But it takes huge time (sometemes) and such heuristic algorithm based on prioritzation will give time improvement at the expense of perfect solution. It makes sense when we need  faster solution.

### Description of the heuristic 2 ("Divide et impera")

We can try one more algorithm to compare it with heuristic priority algorithm and the BFS algorithm.
This algorithm could be derived from the BFS algorithm. We can simply fill one bucket from the rest. Than we put this bucket aside and never use it later.
So our task adds up to finding solution for the *n-1* buckets, because *1* bucket is ready.

Let's compute time complexity for both algorithm the BFS and "Divide et impera".
The BFS at each step produces *n^2+n* children. But "Divide at impera" *n^2-n*. It means 2n less at every step. 
For our experiments with 5 buckets we can compute the difference 

	1st step BFS: 30 outcomes; DaI: 20 outcomes;
	2nd step BFS: 900 outcomes; DaI: 400 outcomes;
	3rd step BFS: 2700 outcomes; DaI: 8000 outcomes;

For sure that is rough numbers and many factors are not included (i.e. duplication). But it shows dynamic and this algorithm has right to existence.

Interesting question - which bucket to choose as the first one? Suggestion to choose bucket with the max capacity makes sense. Because the bucket with the max capacity is fill harder. But here another game with priorities is appeared. 

### Lengths of the paths and number of visited state space nodes for the individual instances.

<table>
	<tr>
		<td></td><td>Depth of the path. BFS algorithm.</td><td>Number of visted nodes. BFS algorithm.</td>
		<td>Depth of the path. Heuristic algorithm.</td><td>Number of visted nodes. Heuristic algorithm.</td>			<td>Depth of the path. "Divide at impera" algorithm.</td><td>Number of visted nodes. "Divide at impera" algorithm.</td>	
	</tr>
    <tr>
        <td><strong>11</strong></td>
        <td>11</td><td>8992</td><td>3184</td><td>25</td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>12</strong></td>
        <td>9</td><td>8055</td><td>2869</td><td>22</td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>13</strong></td>
        <td>9</td><td>8106</td><td>278</td><td>10</td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>14</strong></td>
        <td>4</td><td>170</td><td>2177</td><td>8</td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>21</strong></td>
        <td>17</td><td>49350</td><td></td><td></td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>22</strong></td>
        <td>13</td><td>40064</td><td></td><td></td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>23</strong></td>
        <td>12</td><td>31388</td><td></td><td></td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>24</strong></td>
        <td>6</td><td>215</td><td>588</td><td>10</td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>25</strong></td>
        <td>8</td><td>1917</td><td>1152</td><td>18</td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>31</strong></td>
        <td>15</td><td>59707</td><td></td><td></td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>32</strong></td>
        <td>13</td><td>54939</td><td></td><td></td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>33</strong></td>
        <td>11</td><td>43489</td><td></td><td></td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>34</strong></td>
        <td>6</td><td>1013</td><td></td><td></td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>35</strong></td>
        <td>8</td><td>7464</td><td></td><td></td>
        <td></td><td></td>
    <tr>
    <tr>
        <td><strong>36</strong></td>
        <td>10</td><td>27532</td><td></td><td></td>
        <td></td><td></td>
    <tr>

</table>

	
### Voluntarily you can solve the problem using depth-first search (DFS)

The DFS solution search algorithm is based on the luck mostly. Because it will be vital decision which branch has been choosen. That is operations order in the sequence is important and starting element as well. As opposed to the BFS where we can get the same depth for any operations order, in the DFS the depth will be different and dispersion is very big.

The DFS can be easly transformed from BFS by changing FIFO queue to LIFO queues for roundabout way through the nodes.

So let's look at the table with results of DFS algorithm implementing.

<table>
	<tr>
		<td></td><td>Depth of the path</td><td>Number of visted nodes</td>
	</tr>
    <tr>
        <td><strong>Operation of filling bucket BEFORE operation of emptying </strong></td>
        <td>746</td><td>4125</td>
    <tr>
    <tr>
        <td><strong>Operation of filling bucket AFTER operation of emptying </strong></td>
        <td>2138</td><td>8188</td>
    </tr>
</table>

As we can see just swapping two operation leads to big changes in the output results.

### Conclusions

The BFS algorithm finds optimal solution (with the shortest solultion tree). But the algorithm is very time consumption.
The DFS algorithm is based on luck mostly. Solution colud be found very fast or in long time. Solution is not optimal.
The heuristic algorithms make big improvements in the working time but solution is not optimal. 

### Link to the sourcecode.

All programs for the homework #2 have been writen in Perl language and have been deployed on github repository.

[DFS algorithm](https://github.com/platomik/mie-paa/blob/master/2/dfs.pl "DFS algorithm") 

[BFS algorithm](https://github.com/platomik/mie-paa/blob/master/2/bfs.pl "BFS algorithm") 

[Heuristic algorithm](https://github.com/platomik/mie-paa/blob/master/2/heuristic.pl "Heuristic algorithm") 
