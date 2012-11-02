#! /usr/bin/perl
# Solve binary knapsack problem using branch and bound.

use strict;
use warnings;

# items:
# Elements {relative value, id, weight, value}.
my @items;
# Knapsack capacity
my $capacity;

# report:
# Print solution to stdout:
sub report ($) {
   my $s = $_[0];
   while (defined $s->[1]) {
      my $item = $s->[1];
#      print $item->[1]," ", $item->[2]," ",$item->[3], "; ";
		print $item->[1]," "; #print id of each taken element
      $s = $s->[0];
   }
   #Total cost and weight of the knapsack
   print "| Total: ", $_[0]->[2]," of ",$capacity," with cost ", $_[0]->[3],"\n";
}

# row:
# Build array of solutions potentially involving item i from array of solutions.
# Return pointer to best know solution.
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

# branch:
# Solve binary knapsack problem using branch and bound.
#   r       array of known solutions
#   best    best solution currently known.
sub branch ($) {
   my $cap = $_[0];
   my $best = [ undef, undef, 0, 0 ];
   my $r = [ $best ];

   # Sort items by relative value:
   @items = sort {$b->[0] <=> $a->[0] } @items;

   # For every item...
   for (my $i = 0; $i < @items; $i++) {

      # Value per unit weight of *next* item, if there is one?
      my $relval = $i < $#items ? $items[$i + 1]->[0] : 0.0;

      # Build next row of solutions;
      ($r, $best) = row $cap, $r, $items[$i], $relval, $best;
   }

   return $best;
}

# readstream:
# Parse item descriptions out of one specific input stream.
# Append them to the items array.
sub readstream ($$) {
   my ($path, $fh) = @_;
   my $lineno = 0;
   while (<$fh>) {
      $lineno++;

      # Split line into words; this tacitly drops trailing whitespace.
      my @words = split;

      # Extract value:
      my $value = pop @words;

      # Extract weight:
      my $weight = pop @words;

      # Add items to list of items:
      push @items, [ $value / $weight, join(' ', @words), $weight, $value ];
   }
   print @items; exit;
}

# main:
my $f = "knap_4.inst.dat";
# readfile:
   open my $fh, $f or print "$f: $!";
   while (<$fh>) {
	    next if /^(\s)*$/;      # remove blank lines
	    chomp;                  # remove newline characters
	   	my @line = split(' ', $_); # disassemble line to array
	 	my $id = $line[0];
		my $n = $line[1];
		my $W = 0;	#weight
		my $C = 0;	#cost
		my $V = 0;  #value
		@items=();
	 	$capacity = $line[2];

		for (my $c = 1; $c <= $n; $c++) { # calculate values
			$W = $line[1+$c*2];
			$C = $line[2+$c*2];
			$V = $C/$W;	# calculate values
			push(@items, [$V,$c,$W,$C]);
		}
	# Solve and report:
	report branch($capacity);
   }   
   close $fh;