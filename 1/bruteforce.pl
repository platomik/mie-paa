#!/usr/bin/perl

use strict;

opendir(DIR, '.') or die "Couldn't open directory, $!";
foreach (sort grep(/^*knap_4.inst.dat$/,readdir(DIR)))
{
#    print "$_\n";		# print filename
    open FH,"<$_";
    read_file(*FH);
}
closedir DIR;

sub read_file
{
 while( <FH> ) {
    next if /^(\s)*$/;      # remove blank lines
    chomp;                  # remove newline characters

	my @item = split(' ', $_); # disassemble line to array
	 my $id = $item[0];
	 my $n = $item[1];
	 my $M = $item[2];
	 my $max = 0;
	 my $x = 0;
		
#	print "\n====\n".$_."\n==\n";		
	
	for (my $i = 0; $i < 2**$n; $i++) {	# loop for all possible combinations 
		my $comb=sprintf "%0".$n."b",$i;
		my @combbits = split('', $comb);
		my $C=0;
		my $W=0;
			for (my $c = 1; $c <= $n; $c++) { #loop for all values in the item
				$W+=$combbits[$c-1]*$item[1+$c*2];	#the knapsack weight
		 		$C+=$combbits[$c-1]*$item[2+$c*2];	#the knapsack cost
			}
		if (($W <= $M) and ($C>$max)) {	#the knapsack must not be overloaded and cost maximum
			$max=$C;
			$x = join(" ", @combbits);
#			print $i." ".$W." ".$C."\n";
		}	
	}
	print $id." ".$n." ".$max." ".$x."\n";
 }
 close FH;
}
