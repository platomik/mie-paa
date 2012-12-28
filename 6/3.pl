#!/usr/bin/perl
use lib ".";
use AI::Genetic;

$filename = $ARGV[0];
my $n;	#number of variables
my $m;	#number of clauses
my @f;	#Formula

############## READ DATA FROM FILE ###########################
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
		}elsif($_ =~ m/^\s*([-,0-9]+)\s+([-,0-9]+)\s+([-,0-9]+).*?/i){
			push (@f,[$1,$2,$3]);
		}        
}
close(INPUT_FILE);

##############################################################

    my $ga = new AI::Genetic(
        -fitness    => \&fitnessFunc,
        -type       => 'bitvector',
        -population => 100,
        -crossover  => 0.95,
        -mutation   => 0.25,
        -terminate  => \&terminateFunc,
       );

     $ga->init($n);
     $ga->evolve('rouletteTwoPoint',100);
     print "Best score = ", $ga->getFittest->score, ".\n";
     print "Best genes = ", $ga->getFittest->genes, ".\n";     

     sub fitnessFunc {
		  my $genes = shift;
		  my $r;
						
			foreach (@$genes){
				$r+=$_;
			}
			
		  my $fitness = $r;
		  print $fitness." "."@$genes"."\n";

		  return $fitness;
      }

      sub terminateFunc {
         my $ga = shift;

         # terminate if reached some threshold.
         return 1 if $ga->getFittest->score > $THRESHOLD;
         return 0;
      }