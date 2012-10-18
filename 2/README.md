# MIE-PAA. Homework #2


## the "Buckets" Problem

### Description of the heuristic

*The basics*


### Lengths of the paths and number of visited state space nodes for the individual instances. It is a good measure of the quality of the heuristic. Both for your heuristic and BFS.

<table>
	<tr>
		<td></td><td>Depth of the path. BFS algorithm.</td><td>Number of visted nodes. BFS algorithm.</td>
		<td>Depth of the path. Heuristic algorithm.</td><td>Number of visted nodes. Heuristic algorithm.</td>		
	</tr>
    <tr>
        <td><strong>11</strong></td>
        <td>11</td><td>8992</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>12</strong></td>
        <td>9</td><td>8055</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>13</strong></td>
        <td>9</td><td>8106</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>14</strong></td>
        <td>4</td><td>170</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>21</strong></td>
        <td>17</td><td>49350</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>22</strong></td>
        <td>13</td><td>40064</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>23</strong></td>
        <td>12</td><td>31388</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>24</strong></td>
        <td>6</td><td>215</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>25</strong></td>
        <td>8</td><td>1917</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>31</strong></td>
        <td>15</td><td>59707</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>32</strong></td>
        <td>13</td><td>54939</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>33</strong></td>
        <td>11</td><td>43489</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>34</strong></td>
        <td>6</td><td>1013</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>35</strong></td>
        <td>8</td><td>7464</td><td></td><td></td>
    <tr>
    <tr>
        <td><strong>36</strong></td>
        <td>10</td><td>27532</td><td></td><td></td>
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

### Link to the sourcecode.

All programs for the homework #2 have been writen in Perl language and have been deployed on github repository.

[DFS algorithm](https://github.com/platomik/mie-paa/blob/master/2/dfs.pl "DFS algorithm") 

[BFS algorithm](https://github.com/platomik/mie-paa/blob/master/2/bfs.pl "BFS algorithm") 
