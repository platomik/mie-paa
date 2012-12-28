#!/usr/bin/perl

$filename = $ARGV[0];
my $n;	#number of variables
my $m;	#number of clauses
my @f;	#Formula

open(INPUT_FILE, $filename)
		or die "Couldn't open $filename for reading!";
while (<INPUT_FILE>) {
	# sanitizing data
		s/^c.*//;            	# whitening comments
		s/%.*//;            	# whitening comments
		s/^0$//;	        	# whitening comments
        next if /^(\s)*$/;  	# remove blank lines
		chomp;              	# remove newline characters
		if ($_ =~ m/^p\s+cnf\s+(\d+)\s+(\d+)\s*?$/i) { 
			$n = $1;
			$m = $2;
		}elsif($_ =~ m/^\s*([-,0-9]+)\s+([-,0-9]+)\s+([-,0-9]+)\s+0$/i){
			push (@f,[$1,$2,$3]);
		}        
}
close(INPUT_FILE);

#print $f[5][2],"\n";
#print $n,"cc",$m,"\n";
print @$f,"\n";