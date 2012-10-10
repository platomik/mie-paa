#!/usr/bin/perl

@V = [6, 7, 8, 9];	#capacities
@T = [5, 6, 5, 5];		#target
@S = [5, 6, 7, 8];		#initial
#@cur=[0, 0, 0, 0];		#current

sub print_q {
  my(@queue) = @_;
  $len = $#queue+1;
  for ($c=0; $c<$len; $c++)
  {
#  	print "$c. ";
  	for ($cc=0; $cc<($#{$queue[0]}+1); $cc++) {
 	   print "$queue[$c][$cc]\t";
  	}
  	print "\n";
  }
}

$n = 4;
@cur=@S;

  for ($i=0; $i<$n; $i++){

	#fill bucket one by one
	$left=$cur[0][$i];
	$cur[0][$i]=$V[0][$i];
#	print_q(@cur);print "\n";
	unshift(@Q, @cur);	
	
	#empty bucket one by one
#	$cur[0][$i]=0;
#	print_q(@cur);	print "\n";
#	unshift(@Q, @cur);
	$cur[0][$i]=$left;
	
	#pour a water from left bucket to right bucket
#	for ($ii=0; $ii<$n-1; $ii++){
#		$left_id=$i;
#		$right_id=($i+$ii+1)%($n);
#		$left=$cur[$left_id];
#		$right=$cur[$right_id];
#		
#		if ($V[$right_id]-$left-$right>=0) {
#			$cur[$right_id]=$left+$right;
#			$cur[$left_id]=0;
#		}else{
#			$cur[$right_id]=$V[$right_id];
#			$cur[$left_id]=$left+$right-$V[$right_id];
#		}
#		print @cur;	print "\n";
#		unshift(@Q, @cur);
#		$cur[$left_id]=$left;
#		$cur[$right_id]=$right;
#	}

  }
#print @Q;
print $Q[3][0];
#print "\n\n";
