#!/usr/bin/perl

@V = (3,2,3);	 	#capacities
@T = (2,2,2);		#target
@S = (0,0,0);		#initial
$n = $#S+1;
my $counter;		#element counter

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
	for (my $i = 0; $i <= $#T; $i++) {
    	  if ( $T[$i] == $AoA[$i]) { $ok=1; } else { $ok=2; last; }; 
	}
	if ($ok==1) {
		unshift(@Q, [@AoA]);
		print "we found a solution\n"; 
		print_arr(@Q);
		print "elements: ",$counter,"; depth: ",int(log($counter*29/30+1)/log(30)+0.5)+1,"\n";
		exit;
	}
}

#check uniqueness of element in the tree.
sub is_duplicate{
   my(@y) = @_;
   my $dup = 0;
	for (my $i = 0; $i <= $#Q; $i++) {
		if ("@y" eq "@{$Q[$i]}") { $dup=$i+1;}
    }
   if ($dup==0) { 
	   	unshift(@Q, [@y]);
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
	$counter++;
	is_solution(@cur);
	is_duplicate(@cur);	
	
	#empty bucket one by one
	$cur[$i]=0;
	$counter++;
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
		$counter++;		
		is_solution(@cur);
		is_duplicate(@cur);
		$cur[$left_id]=$left;
		$cur[$right_id]=$right;
	}
  }
}

@Q=[@S];	#set root element from the initial array

for (my $i = 0; $i <= $#Q; $i++) {
#	print "element ",@{$Q[$#Q-$i]},"\n";
	print $i+1,", ";
	go_down(@{$Q[$#Q-$i]});
}
print "number of generated elements $counter\n";
print "\n";