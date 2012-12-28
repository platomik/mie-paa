
package AI::Genetic::OpMutation;

use strict;

1;

# This package implements various mutation
# algorithms. To be used as static functions.

# sub bitVector():
# each gene is a bit: 0 or 1. arguments are mutation
# prob. and anon list of genes.
# returns anon list of mutated genes.

sub bitVector {
  my ($prob, $genes) = @_;

  for my $g (@$genes) {
    next if rand > $prob;

    $g = $g ? 0 : 1;
  }

  return $genes;
}

# sub rangeVector():
# each gene is a floating number, and can be anything
# within a range of two numbers.
# arguments are mutation prob., anon list of genes,
# and anon list of ranges. Each element in $ranges is
# an anon list of two numbers, min and max value of
# the corresponding gene.

sub rangeVector {
  my ($prob, $ranges, $genes) = @_;

  my $i = -1;
  for my $g (@$genes) {
    $i++;
    next if rand > $prob;

    # now randomly choose another value from the range.
    my $abs = $ranges->[$i][1] - $ranges->[$i][0] + 1;
    $g = $ranges->[$i][0] + int rand($abs);
  }

  return $genes;
}

# sub listVector():
# each gene is a string, and can be anything
# from a list of possible values supplied by user.
# arguments are mutation prob., anon list of genes,
# and anon list of value lists. Each element in $lists
# is an anon list of the possible values of
# the corresponding gene.

sub listVector {
  my ($prob, $lists, $genes) = @_;

  my $i = -1;
  for my $g (@$genes) {
    $i++;
    next if rand > $prob;

    # now randomly choose another value from the lists.
    my $new;

    if (@{$lists->[$i]} == 1) {
      $new = $lists->[$i][0];
    } else {
      do {
	$new = $lists->[$i][rand @{$lists->[$i]}];
      } while $new eq $g;
    }

    $g = $new;
  }

  return $genes;
}