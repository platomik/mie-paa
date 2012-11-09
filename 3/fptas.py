#!/usr/bin/python

import math

def dp_lightest(A,B,C):
    T={0:0} #Hash: the smallest weight {cost:min_weight}
    Solution={0:[]}
    
    for i in range(0,len(A)): # go through all items
        T_old=dict(T)  # copy $T_{k-1}$ in $T_{old}$
        for x in T_old:
            if (T_old[x]+A[i])<=B:
                if (not T.has_key(x+C[i])) or (T_old[x]+A[i]<T_old[x+C[i]]):
                    T[x+C[i]]=T_old[x]+A[i]
                    Solution[x+C[i]]=Solution[x]+[i]
 
    ResultCost = max(T.keys())
    Result = Solution[ResultCost]
    return Result
 
# PTAS generic scheme
def fptas_gen(A,B,C,epsilon,f_lower_bound):
#    print "A=",A
#    print "B=",B
#    print "C=",C
#    print "epsilon=",epsilon
 
    # Calculate cost function lower bound and parameter-"divider" $scale$
    F_lb=f_lower_bound(A,B,C)
#    print "F_lb=",F_lb
 
    scale=math.floor(epsilon*F_lb/len(C)/(1+epsilon))
#    print "scale=",scale
 
    # Rounding
    C_=[]
    for i in range(0,len(A)):
        C_.insert(i, int(math.floor(C[i] / scale)))
#    print "C_=",C_
 
    ApproxResult=dp_lightest(A,B,C_)
 
    ApproxCost=0
    for i in ApproxResult:
            ApproxCost=ApproxCost+C[i]
 
#    return (ApproxResult,ApproxCost)        
    print ApproxCost         
 
def lower_bound_trivial(A,B,C):
    #Trivial cost function lower bound
    return max(C) 
 
def lower_bound_greedy(A,B,C):
    #Cost function from greedy algorithm
    return greedy(A,B,C) 
 
# PTAS with complexity O(n^3/epsilon)
def fptas_trivial(A,B,C,epsilon):
    return fptas_gen(A,B,C,epsilon,lower_bound_trivial)
 
# PTAS with complexity O(n^2/epsilon)
def fptas_nontrivial(A,B,C,epsilon):
    return fptas_gen(A,B,C,epsilon,lower_bound_greedy)

def greedy(A,B,C):
	T={}
	for i in range(0,len(A)):
		T[float(A[i]/(C[i]+0.0000001))]=i
	
	#Sort keys by desc
	K=T.keys(); K.sort() 

	#Packing knapsack from most valuable
	C_greedy=0; W_greedy=0;
	for i in K:
		if W_greedy+A[T[i]]<=B:
			W_greedy=W_greedy+A[T[i]]
			C_greedy=C_greedy+C[T[i]]

	C_max=max(C)

	C_result=max(C_greedy,C_max) 
	return C_result 


f = open('knap_40.inst.dat')
epsilon= 0.95

for line in f:
		W=[]
		C=[]
		line=line.strip()
		w = line.split(" ")
		id = int(w[0])
		n = int(w[1])
		capacity = int(w[2])

		for num in range(3, len(w)):
			if num % 2 == 0:
				C.append(int(w[num]))
				continue
			W.append(int(w[num]))
		
#		fptas_nontrivial(W,capacity,C,epsilon)
		fptas_trivial(W,capacity,C,epsilon)		