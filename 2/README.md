# MIE-PAA. Homework #2


## the "Buckets" Problem

### Description of the heuristic

*The basics*

### Lengths of the paths for the individual examples


### Number of visited state space nodes for the individual instances. It is a good measure of the quality of the heuristic. Both for your heuristic and BFS.

	
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


### Link to the sourcecode.

All programs for the homework #2 have been writen in Perl language and have been deployed on github repository.

[DFS algorithm](https://github.com/platomik/mie-paa/blob/master/2/dfs.pl "DFS algorithm") 

[BFS algorithm](https://github.com/platomik/mie-paa/blob/master/2/bfs.pl "BFS algorithm") 
