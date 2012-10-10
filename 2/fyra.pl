#!/usr/bin/perl

@V = ([6, 7, 8, 9]);	#capacities
@T = ([5, 6, 5, 5]);		#target

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


$n=4;

unshift(@V, print join(", ", @T));
print_q(@V);
$T[0][0]=0;
unshift(@V, $T[0]);
print "\n";print_q(@V);

#  for ($i=0; $i<2; $i++){
	#fill bucket one by one
#	$left=$V[0][$i];
#	$T[0][$i]=0;
#	print $T[0][3];
#	print $V[0][3];
#	unshift(@V, @T);
#	print_q(@V) ;	
#	$V[0][$i]=$left;
#  }

#print_q(@V);