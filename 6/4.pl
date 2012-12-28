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
        -population => 1,
        -crossover  => 0.95,
        -mutation   => 0.05,
        -terminate  => \&terminateFunc,
       );

     $ga->init($n);
     $ga->evolve('rouletteTwoPoint',100);
     print "Best score = ", $ga->getFittest->score, ".\n";
     print "Best genes = ", $ga->getFittest->genes, ".\n";     

     sub fitnessFunc {
		  #my $genes = shift;
		  my @genes = (1,1,1,1,0,1,1,1,1,1,1,0,1,0,0,1,1,1,0,1);
		  my $r;
			print @genes,"\n\n";
			## analizing formula from top to bottom
			my $formula_is_satisfied = 1;
			for (my $cl = 0; $cl < $m; $cl++){

				## analizing formula from left to right
				my $clause_is_satisfied = 0;
				for (my $var = 0; $var < 3; $var++) {

					if ($f[$cl][$var]<0) {
							$gen = ($genes[abs($f[$cl][$var])-1]+1) % 2;
					}else{
							$gen = $genes[abs($f[$cl][$var])-1];
					}
					if ($gen > 0) {$clause_is_satisfied = 1; last;}
				}
				
				if ($clause_is_satisfied < 1) {$formula_is_satisfied = 0; last;}
			}
			print $formula_is_satisfied,"\n";
						
			foreach (@genes){
				$r+=$_;
			}
			
		  my $fitness = $r*$formula_is_satisfied;
		  print $fitness." ~ "."@genes"."\n";

		  return $fitness;
      }

      sub terminateFunc {
         my $ga = shift;

         # terminate if reached some threshold.
         return 1 if $ga->getFittest->score > $THRESHOLD;
         return 0;
      }