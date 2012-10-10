#!/usr/bin/perl

@V = (6, 7, 8, 9);	#capacities
@T = (5, 6, 5, 5);		#target
@S = (5, 5, 5, 5);		#initial
@cur=(0, 0, 0, 0);		#current
$n = 4;

@cur=@S;

sub print_list {
  $max = $_[0];
  for ($i=0; $i<$max; $i++)
  {
    print "$i.  $Q[$i]\t $Q[$i]\n";
  }
}


print @cur; print "\n\n";
  for ($i=0; $i<$n; $i++){

	#fill bucket one by one
	$left=$cur[$i];
	$cur[$i]=$V[$i];
	print @cur;	print "\n";
	unshift(@Q, @cur);	
	
	#empty bucket one by one
	$cur[$i]=0;
	print @cur;	print "\n";
	unshift(@Q, @cur);
	$cur[$i]=$left;
	
	#pour a water from left bucket to right bucket
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
		print @cur;	print "\n";
		unshift(@Q, @cur);
		$cur[$left_id]=$left;
		$cur[$right_id]=$right;
	}

  }

print_list($#Q + 1);
print "\n\n";
