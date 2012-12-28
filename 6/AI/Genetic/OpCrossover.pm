
package AI::Genetic::OpCrossover;

use strict;

1;

# sub vectorSinglePoint():
# Single point crossover.
# arguments are crossover prob, two
# anon lists of genes (parents).
# If crossover occurs, returns two anon lists
# of children genes. If no crossover, returns 0.
# both parents have to be of same length.

sub vectorSinglePoint {
  my ($prob, $mom, $dad) = @_;

  return 0 if rand > $prob;

  # get single index from 1 to $#{$dad}
  my $ind = 1 + int rand $#{$dad};

  my @c1 = (@$mom[0 .. $ind - 1],
	    @$dad[$ind .. $#{$dad}]);
  my @c2 = (@$dad[0 .. $ind - 1],
	    @$mom[$ind .. $#{$dad}]);

  return (\@c1, \@c2);
}

# sub vectorTwoPoint():
# Two point crossover.
# arguments are crossover prob, two
# anon lists of genes (parents).
# If crossover occurs, returns two anon lists
# of children genes. If no crossover, returns 0.
# both parents have to be of same length.

sub vectorTwoPoint {
  my ($prob, $mom, $dad) = @_;

  return 0 if rand > $prob;

  # get first index from 1 to $#{$dad}-1
  my $ind1 = 1 + int rand($#{$dad} - 1);

  # get second index from $ind1 to $#{$dad}
  my $ind2 = $ind1 + 1 + int rand($#{$dad} - $ind1);
  my @c1 = (@$mom[0 .. $ind1 - 1],
	    @$dad[$ind1 .. $ind2 - 1],
	    @$mom[$ind2 .. $#{$dad}]);

  my @c2 = (@$dad[0 .. $ind1 - 1],
	    @$mom[$ind1 .. $ind2 - 1],
	    @$dad[$ind2 .. $#{$dad}]);

  return (\@c1, \@c2);
}

# sub vectorUniform():
# Uniform crossover.
# arguments are crossover prob, two
# anon lists of genes (parents).
# If crossover occurs, returns two anon lists
# of children genes. If no crossover, returns 0.
# both parents have to be of same length.

sub vectorUniform {
  my ($prob, $mom, $dad) = @_;

  return 0 if rand > $prob;

  my (@c1, @c2);
  for my $i (0 .. $#{$dad}) {
    if (rand > 0.5) {
      push @c1 => $mom->[$i];
      push @c2 => $dad->[$i];
    } else {
      push @c2 => $mom->[$i];
      push @c1 => $dad->[$i];
    }
  }

  return (\@c1, \@c2);
}
