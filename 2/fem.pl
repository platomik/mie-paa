#!/usr/bin/perl

@V = (2, 3);	 	#capacities
@T = (1, 1);		#target
@S = (2, 0);		#initial
#@cur=(0, 0, 0, 0);		#current
$n = $#S+1;

#here is just array printing
sub print_arr{
	my(@AoA) = @_;
	for (my $i = 0; $i <= $#AoA; $i++) {
		print $i+1, ". ";
	   for (my $j = 0; $j <= $#{$AoA[$i]}; $j++) {
    	  print $AoA[$i][$j], " "; 
    	}
    	print "\n";
    }
}

sub is_solution {
	my(@AoA) = @_;
    my $ok = 2;    
#    print @AoA,"\n";
	for (my $i = 0; $i <= $#T; $i++) {
    	  if ( $T[$i] == $AoA[$i]) { $ok=1; } else { $ok=2; last; }; 
	}
	if ($ok==1) {
		unshift(@Q, [@AoA]);
		print "we found a solution\n"; 
		print_arr(@Q);
		exit;
	}
}

#check uniqueness of element in the tree.
sub is_duplicate{
   my(@y) = @_;
   my $ok = 2;
	for (my $i = 0; $i <= $#Q; $i++) {
	   	for (my $j = 0; $j <= $#{$Q[$i]}; $j++) {
    	  if ( $Q[$i][$j] == @y[$j]) { $ok=1; } else { $ok=2; last; }; 
    	}
    }
   if ($ok!=1) { unshift(@Q, [@y]);
   }    

}

# n^2+n branches from a bud
sub go_down {
 my(@cur) = @_;	
# print @cur; print "\n\n";
  for ($i=0; $i<$n; $i++){

	#fill bucket one by one
	$left=$cur[$i];
	$cur[$i]=$V[$i];
	is_solution(@cur);
	is_duplicate(@cur);	
	
	#empty bucket one by one
	$cur[$i]=0;
	is_solution(@cur);
	is_duplicate(@cur);
	$cur[$i]=$left;


	#pour a water from the left bucket to the right bucket
	for ($ii=0; $ii<$n-1; $ii++){
		$left_id=$i;
		$right_id=($i+$ii+1)%($n);
		$left=$cur[$left_id];
		$right=$cur[$right_id];
		
		if ($V[$right_id]-$left-$right>=0) {
			$cur[$right_id]=$left+$right;
			$cur[$left_id]=0;
		}else{
			$cur[$right_id]=$V[$right_id];
			$cur[$left_id]=$left+$right-$V[$right_id];
		}
		is_solution(@cur);
		is_duplicate(@cur);
		$cur[$left_id]=$left;
		$cur[$right_id]=$right;
	}
  }
}

@Q=[@S];	#set root element from the initial array
#go_down(@S);
#print_arr(@Q);
#@next = pop @Q;
#print_arr(@next);

#	for (my $i = 0; $i <= $#Q; $i++) {
#$i=0;
#		print @{$Q[$#Q-$i]},"\n";
#		go_down(@{$Q[$#Q-$i]});
#		print_arr(@Q);

@Q=([2,0],[0,0],[0,0],[2,0]);

$i=1;
		print @{$Q[$#Q-$i]},"\n";
		go_down(@{$Q[$#Q-$i]});
		print_arr(@Q);
		
#		if ($i==1) {unshift(@Q, [1,2,3,4]);}
#	}

print "\n";