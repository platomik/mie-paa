#!/usr/bin/env python
import sys
import math
import operator
import random
 
STEPS = 10
ALPHA = 0.8
TEMP_0 = 40.0 
M = 600
 
def main(args):
	# open file and read it line by line for items array generating
    f = open('knap_40.inst.dat')
    for line in f:
    	line=line.strip()
    	w = line.split(" ")
    	id = int(w[0])
    	n = int(w[1])
    	capacity = int(w[2])
    	items = []

		#array items(cost,weight)    	
    	for num in range(0, n):
    		items.append((int(w[2*num+3+1]),int(w[2*num+3])))

    	#generate initial point. randomly pick up items from instance until knapsack becomes overweight
    	start_sol = init_sol(items, max_weight=M)
    	#print "Initial solution: %s" % start_sol
    	#print "Initial knapsack has cost: %d, and weight: %d)" % cur_knap(start_sol, items)
    	
    	solution = sa(start_sol, items, max_weight=M)
    	#print "Final knapsack has items: %s" % solution
    	#print "Final knapsack has: (cost: %d, weight: %d)" % cur_knap(solution, items)
    	print cur_knap(solution, items)
    return False

# Used for initial solution generation. By adding a random item while weight is less M 
def init_sol(items, max_weight):
    solution = []
    while cur_knap(solution, items)[1] <= max_weight:
        idx = random.randint(0, len(items) - 1)
        if idx not in solution:
            solution.append(idx)
    solution = solution[:-1]
    return solution

# Compute and print knapsack parameters - weight and cost 
def cur_knap(solution, items):
    cost, weight = 0, 0
    for item in solution:
        cost += items[item][0]
        weight += items[item][1]
    return (cost, weight)

# All possible moves are generated 
def moveto(solution, items, max_weight):
    moves = []
    for idx, item in enumerate(items):
        if idx not in solution:
            move = solution[::]
            move.append(idx)
            if cur_knap(move, items)[1] <= max_weight:
                moves.append(move)
    for idx, item in enumerate(solution):
        move = solution[::]
        del move[idx]
        if move not in moves:
            moves.append(move)
    return moves

# Simulated annealing approach for Knapsack problem
def sa(solution, items, max_weight):
    best = solution
    best_value = cur_knap(solution, items)[0]
    current_sol = solution
    temperature = TEMP_0
 
    while True:
        current_value = cur_knap(best, items)[0] 
        for i in range(0, STEPS):
            moves = moveto(current_sol, items, max_weight)
            idx = random.randint(0, len(moves) - 1)
            random_move = moves[idx]
            delta = cur_knap(random_move, items)[0] - cur_knap(best, items)[0]
            if delta > 0:
                best = random_move
                best_value = cur_knap(best, items)[0]
                current_sol = random_move
            else:
                if math.exp(delta / float(temperature)) > random.random():
                    current_sol = random_move
 
        temperature = ALPHA * temperature
        if current_value >= best_value or temperature <= 0:
            break
    return best
  
if __name__ == '__main__':
    sys.exit(main(sys.argv))
