#! /usr/bin/perl

use strict;
use warnings;

# items:
# Object descriptions read from input files.
# Elements are quadruples specifiying
#  * relative value, ie. value per unit weight,
#  * name,
#  * weight, and
#  * value.
my @items;

# report:
# Prettyprint solution to stdout:
# Solutions are quadruples storing
#  * previous solution, ie. solution this solution is based on,
#  * item distinguishing this solutionn from the previous solution,
#  * total weight,
#  * total value.
sub report ($) {

   # Print items in solution:
   my $s = $_[0];
   while (defined $s->[1]) {
      my $item = $s->[1];
#      print $item->[1],"(", $item->[2],",", $item->[3],") ";
       print $item->[1]," ";     
      $s = $s->[0];
   }

   # Print totals:
   print " Total: (", $_[0]->[2],";", $_[0]->[3],")\n";
}

# row:
# Build array of solutions potentially involving item i
# from array of solutions involving items i ... i-1 only.
# Return pointer to best know solution.
# Parameters:
#   cap     knapsack capacity
#   oldrow  list of known solutions
#   item    item we may or may not add to known solutions
#   relval  value/weight quotient of item i+1, ie.
#           maximum value per unit weight of any item not yet dealt with;
#           zero if there is no item i+1.
#   best    best solution currently known.
# Notable locals:
#   newrow  array new solutions will go into
sub row ($$$$$) {
   my ($cap, $oldrow, $item, $relval, $best) = @_;
   my $newrow = [];

   # For every old solution:
   for my $oldsol (@$oldrow) {

      # Can we add item i to this solution?
      if ($oldsol->[2] + $item->[2] <= $cap) {

         # Maximum value new solution could theoretically reach?
         my $max = $oldsol->[3] + $item->[3]
           + ($cap - $oldsol->[2] - $item->[2]) * $relval;

         # Exceeds value of best solution currently known?
         if ($max > $best->[3]) {

            # Create new solution:
            my $newsol = [ $oldsol,
                           $item,
                           $oldsol->[2] + $item->[2],
                           $oldsol->[3] + $item->[3] ];
            push @$newrow, $newsol;

            # New best solution?
            $best = $newsol if $newsol->[3] > $best->[3];
         }
      }

      # Add existing solution to new row if still viable:
      my $max = $oldsol->[3] + ($cap - $oldsol->[2]) * $relval;
      push @$newrow, $oldsol if $max > $best->[3];
   }

   return ($newrow, $best);
}

# dynamic:
# Solve binary knapsack problem using dynamic programming.
sub dynamic ($) {
   my $cap = $_[0];
   my $best = [ undef, undef, 0, 0 ];

   # Set up array with slots for $cap + 1 solutions:
   my @r;
   $#r = $cap;
   $r[0] = $best;

   # For every item...
   for my $item (@items) {

      # For every existing solution, large weights to small:
      for (my $w = $cap; $w-- > 0;) {
         next unless defined $r[$w];

         # Can we add item i to this solution?
         my $weight = $w + $item->[2];
         next if $weight > $cap;

         # Without overwriting an existing better solution?
         my $value = $r[$w]->[3] + $item->[3];
         next if defined $r[$weight] && $r[$weight]->[3] > $value;

         # Store new solution:
         $r[$weight] = [ $r[$w], $item, $weight, $value ];

         # New best solution?
         $best = $r[$weight] if $value > $best->[3];
      }
   }

   # Find least heavy solution with optimum value:
   for my $r (@r) {
      return $r if defined $r && $r->[3] == $best->[3];
   }
}


# readstream:
# Parse item descriptions out of one specific input stream.
# Append them to the items array.
sub readstream ($$) {

   my ($path, $fh) = @_;
   while (<$fh>) {
	  @items = ();
	  
      # Split line into words; this tacitly drops trailing whitespace.
      # Skip line if empty:
      my @words = split;
            	  
	  my $id = shift @words;
	  my $n = shift @words;
	  my $capacity = shift @words; 

		for (my $c = 1; $c <= $n; $c++) { # calculate values
			my $value = pop @words;
			my $weight = pop @words;
		    push @items, [ $value / $weight, $n-$c+1, $weight, $value ];
		}

	  # Solve and report:
	  report dynamic($capacity);
   }
}

# main:
sub main() {

   # capacity:
   my $f="knap_27.inst.dat";
   my $fh;
   
   open $fh, $f;
   	readstream $f, $fh;
   close $fh;
}

main;
