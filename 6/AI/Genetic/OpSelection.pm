
package AI::Genetic::OpSelection;

use strict;

my @wheel;
my $wheelPop;

# sub init():
# initializes the roulette wheel array.
# must be called whenever the population changes.
# only useful for roulette().

sub initWheel {
  my $pop = shift;

  my $tot = 0;
  $tot += $_->score for @$pop;

  # if all population has zero score, then none
  # deserves to be selected.
  $tot = 1 unless $tot;    # to avoid div by zero

  # normalize
  my @norms = map {$_->score / $tot} @$pop;

  @wheel = ();

  my $cur = 0;
  for my $i (@norms) {
    push @wheel => [$cur, $cur + $i];
    $cur += $i;
  }

  $wheelPop = $pop;
}

# sub roulette():
# Roulette Wheel selection.
# argument is number of individuals to select (def = 2).
# returns selected individuals.

sub roulette {
  my $num = shift || 2;

  my @selected;

  for my $j (1 .. $num) {
    my $rand = rand;
    for my $i (0 .. $#wheel) {
      if ($wheel[$i][0] <= $rand && $rand < $wheel[$i][1]) {
	push @selected => $wheelPop->[$i];
	last;
      }
    }
  }

  return @selected;
}

# same as roulette(), but returns unique individuals.
sub rouletteUnique {
  my $num = shift || 2;

  # make sure we select unique individuals.
  my %selected;

  while ($num > keys %selected) {
    my $rand = rand;

    for my $i (0 .. $#wheel) {
      if ($wheel[$i][0] <= $rand && $rand < $wheel[$i][1]) {
	$selected{$i} = 1;
	last;
      }
    }
  }

  return map $wheelPop->[$_], keys %selected;
}

# sub tournament():
# arguments are anon list of population, and number
# of individuals in tournament (def = 2).
# return 1 individual.

sub tournament {
  my ($pop, $num) = @_;

  $num ||= 2;

  my %s;
  while ($num > keys %s) {
    my $i = int rand @$pop;
    $s{$i} = 1;
  }

  return (sort {$b->score <=> $a->score}
	  map {$_->score; $_}  # This avoids a bug in Perl. See Genetic.pm.
	  map $pop->[$_], keys %s)[0];
}

# sub random():
# pure random choice of individuals.
# arguments are anon list of population, and number
# of individuals to select (def = 1).
# returns selected individual(s).

sub random {
  my ($pop, $num) = @_;

  $num ||= 1;

  my %s;
  while ($num > keys %s) {
    my $i = int rand @$pop;
    $s{$i} = 1;
  }

  return map $pop->[$_], keys %s;
}

# sub topN():
# fittest N individuals.
# arguments are anon list of pop, and N (def = 1).
# return anon list of top N individuals.

sub topN {
  my ($pop, $N) = @_;

  $N ||= 1;

  # hmm .. are inputs already sorted?
  return [(sort {$b->score <=> $a->score}
	   map {$_->score; $_}  # This avoids a bug in Perl. See Genetic.pm.
	   @$pop)[0 .. $N-1]];
}

1;