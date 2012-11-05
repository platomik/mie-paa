#!/usr/bin/perl

use strict;
use POSIX;

my @curW; 
my @curC;

opendir(DIR, '.') or die "Couldn't open directory, $!";
foreach (sort grep(/^*knap_40.inst.dat$/,readdir(DIR)))
{
#    print "$_\n";		# print filename
    open FH,"<$_";
    read_file(*FH);
}
closedir DIR;

sub print_arr{
        my(@AoA) = @_;
        for (my $i = 0; $i <= $#AoA; $i++) {
          print $AoA[$i], " "; 
    	}
    	        print "\n";
}

sub addme{
        my($w,$c) = @_;
        my $nodup=0;

		for (my $i = 0; $i < $#curW+1; $i++) { 			
			if ($curW[$i]==$w and $curC[$i]<$c){ #same weight but cheaper
				$nodup=0;			
				$curC[$i]=0;
				$curW[$i]=0;
				last;
			} elsif ($curW[$i]==$w and $curC[$i]>=$c){ #same weight but expensive
				$nodup=1;
				last;			
			}
        }
        if ($nodup==0) {
   			push(@curW, $w);
			push(@curC, $c);
        }
        
#        print "\n";
}

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
	
	@curW=();
	@curC=();

	my $epsilon = 1;
	my $Flb = 400;
	my $scale=$epsilon*$Flb/$n*(1+$epsilon);
	
	for (my $c = 1; $c <= $n; $c++) { # calculate values
		$W = $item[1+$c*2];
		$C = floor($item[2+$c*2]/$scale);
		$V = sprintf("%.1f", $C/$W);	# calculate values
		push(@arrV, $V);				# fill array with values
		push(@arrI, $c);				# fill array with ids
		push(@arrW, $W);				# fill array with weights
		push(@arrC, $C);				# fill array with costs
	}

	#sort all arrays by lighter element
	my @sortedIndx = sort{ $arrW[ $a ] <=> $arrW[ $b ] } 0 .. $#arrW;
	@arrV = @arrV[ @sortedIndx ];;
	@arrI = @arrI[ @sortedIndx ];;
	@arrW = @arrW[ @sortedIndx ];;
	@arrC = @arrC[ @sortedIndx ];;

	push(@curW, 0);
	push(@curC, 0);

	#dynprog
	for (my $c = 0; $c < $n; $c++) { 
		my $len = scalar @curW;
		for (my $j = 0; $j < $len; $j++) { 
#				print "???curW/curC: ",$curW[$j],"/",$curC[$j]," arrW/arrC:",$arrW[$c],"/",$arrC[$c]," sum:",$curW[$j]+$arrW[$c]," M=",$M,"\n";
			
			if (($curW[$j]+$arrW[$c]<=$M) && !(($curW[$j]==$arrW[$c]) && ($curC[$j]==$arrC[$c]))){
#				print "!!!curW/curC: ",$curW[$j],"/",$curC[$j]," arrW/arrC:",$arrW[$c],"/",$arrC[$c]," sum:",$curW[$j]+$arrW[$c],"/",$curC[$j]+$arrC[$c]," M=",$M,"\n";
				addme($curW[$j]+$arrW[$c],$curC[$j]+$arrC[$c]);
			}
		}

#	print_arr(@curW);	
#	print_arr(@curC);	
	}


	#print result
	my $Wmax;
	my $Cmax;
	for (my $c = 1; $c <= $#curW; $c++) { 
		if ($Cmax<$curC[$c]){
			$Cmax=$curC[$c];
			$Wmax=$curW[$c];
		}
	}
	print "cost ",$Cmax,"; weight:", $Wmax,"\n";
exit;
 }
 close FH;
}
