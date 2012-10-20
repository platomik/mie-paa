#!/usr/bin/perl

@V = (14,10,6,2,8);	 	#capacities
@T = (12,6,4,1,8);		#target
@S = (0,0,1,0,0);		#initial

$n = $#S+1;

#here is just array printing
sub print_arr{
	my(@AoA) = @_;
	for (my $i = 0; $i <= $#AoA; $i++) {
#		print $i+1, ". ";
	   for (my $j = 0; $j <= $#{$AoA[$i]}; $j++) {
    	  print $AoA[$i][$j], " "; 
    	}
    	print "\n";
    }
}

#prioritize array
sub prior_arr{
	my(@AoA) = @_;
	for (my $i = 0; $i <= $#AoA; $i++) {
		$diff=0;
	   for (my $j = 0; $j <= $#{$AoA[$i]}; $j++) {
    	  $diff+=abs($T[$j]-$AoA[$i][$j]); 
    	}
    	$Gen[$i][$n+1]=$diff;
    }
    
	#sorting
    for (my $j = 0; $i < $#Gen; $i++) {
     for (my $i = 0; $i < $#Gen; $i++) {
		$left=$Gen[$i][$n+1];
		$right=$Gen[$i+1][$n+1];
	
		if ($left < $right) {;
			$tmp=$Gen[$i];
			$Gen[$i]=$Gen[$i+1];
			$Gen[$i+1]=$tmp;
		}
     }
    }

	#remove priority
    for (my $i = 0; $i <= $#Gen; $i++) {
    	push(@R, [$id+$i,$id]);
		delete $Gen[$i][$n+1];
    }
}


sub is_solution {
	my(@AoA) = @_;
    my $ok = 2;    
	for (my $i = 0; $i <= $#T; $i++) {
    	  if ( $T[$i] == $AoA[$i]) { $ok=1; } else { $ok=2; last; }; 
	}
	if ($ok==1) {
		push(@Q, [@AoA]);
	   	push(@R, [$#Q,$id]);		
		print "We have found a solution after visiting ",$id+1," nodes!\n"; 
#		print "Solution tree looks like: \n";
#		print_arr(@R);
#		$child=$#Q;
#		while ($father ne "Null") {
#			$cc++;
#			print_arr($Q[$#Q-$child])." ";
#			$father=$R[$child][1];
#			$child=$father;
#		}
#		print "Depth of the solution tree is: $cc \n";
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
	   	push(@Gen, [@y]);
#	   	print "father: ".$id,"; child: ", $#Q,"\n";
#	   	push(@R, [$#Q,$id]);
   }    

}

# n^2+n branches from a bud
sub go_down {
 my(@cur) = @_;	
 @father=@cur;
 @Gen=();
# print @cur; print "\n\n";
  for ($i=0; $i<$n; $i++){

	#fill bucket one by one
	$left=$cur[$i];
	$cur[$i]=$V[$i];
#	print @cur,"\n";
	is_solution(@cur);
	is_duplicate(@cur);	
	
	#empty bucket one by one
	$cur[$i]=0;
#	print @cur,"\n";
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
#		print @cur,"\n";		
		is_solution(@cur);
		is_duplicate(@cur);
		$cur[$left_id]=$left;
		$cur[$right_id]=$right;
	}
  }
  #sort array in prioritize mode
  prior_arr(@Gen);
}

@Q=[@S];	#set root element from the initial array

push(@R, [0,"Null"]); # format (father;child)

for ($id = 0; $id <= $#Q; $id++) {
	print " ",$id+1,"\n";
	go_down(@{$Q[$id]});
	splice(@Q,$id+1,0,@Gen);
}
print "\n";
