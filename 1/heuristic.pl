#!/usr/bin/perl

use strict;

opendir(DIR, '.') or die "Couldn't open directory, $!";
foreach (sort grep(/^*knap_40.inst.dat$/,readdir(DIR)))
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
	
	my $W = 0;	#weight
	my $C = 0;	#cost
	my $V = 0;  #value
	my @arrV; 
	my @arrI; 
	my @arrW; 
	my @arrC;
	my $curW = 0; #current weight of knapsack
	my $curC = 0; #current cost of knapsack
	my @in;
	
	for (my $c = 1; $c <= $n; $c++) { # calculate values
		$W = $item[1+$c*2];
		$C = $item[2+$c*2];
		$V = sprintf("%.1f", $C/$W);	# calculate values
		push(@arrV, $V);				# fill array with values
		push(@arrI, $c);				# fill array with ids
		push(@arrW, $W);				# fill array with weights
		push(@arrC, $C);				# fill array with costs
	}


	#sort all arrays
	my @sortedIndx = sort{ $arrV[ $b ] <=> $arrV[ $a ] } 0 .. $#arrV;
	@arrV = @arrV[ @sortedIndx ];;
	@arrI = @arrI[ @sortedIndx ];;
	@arrW = @arrW[ @sortedIndx ];;
	@arrC = @arrC[ @sortedIndx ];;

	#packing knapsack
	for (my $c = 1; $c <= $n; $c++) { 
		if ($curW+$arrW[$c-1]<=$M){
			$curW+=$arrW[$c-1];	  #current weight
			$curC+=$arrC[$c-1];	  #current weight	
			$in[$arrI[$c-1]] = 1; #which stuff should we take
		}else{
			$in[$arrI[$c-1]] = 0; #which stuff should not we take
		}
	}
	print $id." ".$n." ".$curC.""."@in";
	print "\n";
 }
 close FH;
}
