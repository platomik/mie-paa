
package AI::Genetic;

use strict;
use Carp;

use vars qw/$VERSION/;

$VERSION = 0.05;

use AI::Genetic::Defaults;

# new AI::Genetic. More modular.
# Not too many checks are done still.

##### Shared private vars
# this hash predefines some strategies

my %_strategy = (
		 rouletteSinglePoint => \&AI::Genetic::Defaults::rouletteSinglePoint,
		 rouletteTwoPoint    => \&AI::Genetic::Defaults::rouletteTwoPoint,
		 rouletteUniform     => \&AI::Genetic::Defaults::rouletteUniform,

		 tournamentSinglePoint => \&AI::Genetic::Defaults::tournamentSinglePoint,
		 tournamentTwoPoint    => \&AI::Genetic::Defaults::tournamentTwoPoint,
		 tournamentUniform     => \&AI::Genetic::Defaults::tournamentUniform,

		 randomSinglePoint => \&AI::Genetic::Defaults::randomSinglePoint,
		 randomTwoPoint    => \&AI::Genetic::Defaults::randomTwoPoint,
		 randomUniform     => \&AI::Genetic::Defaults::randomUniform,
		);

# this hash maps the genome types to the
# classes they're defined in.

my %_genome2class = (
		     bitvector   => 'AI::Genetic::IndBitVector',
		     rangevector => 'AI::Genetic::IndRangeVector',
		     listvector  => 'AI::Genetic::IndListVector',
		    );

##################

# sub new():
# This is the constructor. It creates a new AI::Genetic
# object. Options are:
# -population: set the population size
# -crossover:  set the crossover probability
# -mutation:   set the mutation probability
# -fitness:    set the fitness function
# -type:       set the genome type. See docs.
# -terminate:  set termination sub.

sub new {
  my ($class, %args) = @_;

  my $self = bless {
		    ADDSEL => {},   # user-defined selections
		    ADDCRS => {},   # user-defined crossovers
		    ADDMUT => {},   # user-defined mutations
		    ADDSTR => {},   # user-defined strategies
		   } => $class;

  $self->{FITFUNC}    = $args{-fitness}    || sub { 1 };
  $self->{CROSSRATE}  = $args{-crossover}  || 0.95;
  $self->{MUTPROB}    = $args{-mutation}   || 0.05;
  $self->{POPSIZE}    = $args{-population} || 100;
  $self->{TYPE}       = $args{-type}       || 'bitvector';
  $self->{TERM}       = $args{-terminate}  || sub { 0 };

  $self->{PEOPLE}     = [];   # list of individuals
  $self->{GENERATION} = 0;    # current gen.

  $self->{INIT}       = 0;    # whether pop is initialized or not.
  $self->{SORTED}     = 0;    # whether the population is sorted by score or not.
  $self->{INDIVIDUAL} = '';   # name of individual class to use().

  return $self;
}

# sub createStrategy():
# This method creates a new strategy.
# It takes two arguments: name of strategy, and
# anon sub that implements it.

sub createStrategy {
  my ($self, $name, $sub) = @_;

  if (ref($sub) eq 'CODE') {
    $self->{ADDSTR}{$name} = $sub;
  } else {
    # we don't know what this operation is.
    carp <<EOC;
ERROR: Must specify anonymous subroutine for strategy.
       Strategy '$name' will be deleted.
EOC
    ;
    delete $self->{ADDSTR}{$name};
    return undef;
  }

  return $name;
}

# sub evolve():
# This method evolves the population using a specific strategy
# for a specific number of generations.

sub evolve {
  my ($self, $strategy, $gens) = @_;

  unless ($self->{INIT}) {
    carp "can't evolve() before init()";
    return undef;
  }

  my $strSub;
  if      (exists $self->{ADDSTR}{$strategy}) {
    $strSub = $self->{ADDSTR}{$strategy};
  } elsif (exists $_strategy{$strategy}) {
    $strSub = $_strategy{$strategy};
  } else {
    carp "ERROR: Do not know what strategy '$strategy' is,";
    return undef;
  }

  $gens ||= 1;

  for my $i (1 .. $gens) {
    $self->sortPopulation;
    $strSub->($self);

    $self->{GENERATION}++;
    $self->{SORTED} = 0;

    last if $self->{TERM}->($self);

#    my @f = $self->getFittest(10);
#    for my $f (@f) {
#      print STDERR "    Fitness = ", $f->score, "..\n";
#      print STDERR "    Genes are: @{$f->genes}.\n";
#    }
  }
}

# sub sortIndividuals():
# This method takes as input an anon list of individuals, and returns
# another anon list of the same individuals but sorted in decreasing
# score.

sub sortIndividuals {
  my ($self, $list) = @_;

  # make sure all score's are calculated.
  # This is to avoid a bug in Perl where a sort is called from whithin another
  # sort, and they are in different packages, then you get a use of uninit value
  # warning. See http://rt.perl.org/rt3/Ticket/Display.html?id=7063
  $_->score for @$list;

  return [sort {$b->score <=> $a->score} @$list];
}

# sub sortPopulation():
# This method sorts the population of individuals.

sub sortPopulation {
  my $self = shift;

  return if $self->{SORTED};

  $self->{PEOPLE} = $self->sortIndividuals($self->{PEOPLE});
  $self->{SORTED} = 1;
}

# sub getFittest():
# This method returns the fittest individuals.

sub getFittest {
  my ($self, $N) = @_;

  $N ||= 1;
  $N = 1 if $N < 1;

  $N = @{$self->{PEOPLE}} if $N > @{$self->{PEOPLE}};

  $self->sortPopulation;

  my @r = @{$self->{PEOPLE}}[0 .. $N-1];

  return $r[0] if $N == 1 && not wantarray;

  return @r;
}

# sub init():
# This method initializes the population to completely
# random individuals. It deletes all current individuals!!!
# It also examines the type of individuals we want, and
# require()s the proper class. Throws an error if it can't.
# Must pass to it an anon list that will be passed to the
# newRandom method of the individual.

# In case of bitvector, $newArgs is length of bitvector.
# In case of rangevector, $newArgs is anon list of anon lists.
# each sub-anon list has two elements, min number and max number.
# In case of listvector, $newArgs is anon list of anon lists.
# Each sub-anon list contains possible values of gene.

sub init {
  my ($self, $newArgs) = @_;

  $self->{INIT} = 0;

  my $ind;
  if (exists $_genome2class{$self->{TYPE}}) {
    $ind = $_genome2class{$self->{TYPE}};
  } else {
    $ind = $self->{TYPE};
  }

  eval "use $ind";  # does this work if package is in same file?
  if ($@) {
    carp "ERROR: Init failed. Can't require '$ind': $@,";
    return undef;
  }

  $self->{INDIVIDUAL} = $ind;
  $self->{PEOPLE}     = [];
  $self->{SORTED}     = 0;
  $self->{GENERATION} = 0;
  $self->{INITARGS}   = $newArgs;

  push @{$self->{PEOPLE}} =>
    $ind->newRandom($newArgs) for 1 .. $self->{POPSIZE};

  $_->fitness($self->{FITFUNC}) for @{$self->{PEOPLE}};

  $self->{INIT} = 1;
}

# sub people():
# returns the current list of individuals in the population.
# note: this returns the actual array ref, so any changes
# made to it (ex, shift/pop/etc) will be reflected in the
# population.

sub people {
  my $self = shift;

  if (@_) {
    $self->{PEOPLE} = shift;
    $self->{SORTED} = 0;
  }

  $self->{PEOPLE};
}

# useful little methods to set/query parameters.
sub size       { $_[0]{POPSIZE}    = $_[1] if defined $_[1]; $_[0]{POPSIZE}   }
sub crossProb  { $_[0]{CROSSRATE}  = $_[1] if defined $_[1]; $_[0]{CROSSRATE} }
sub mutProb    { $_[0]{MUTPROB}    = $_[1] if defined $_[1]; $_[0]{MUTPROB}   }
sub indType    { $_[0]{INDIVIDUAL} }
sub generation { $_[0]{GENERATION} }

# sub inject():
# This method is used to add individuals to the current population.
# The point of it is that sometimes the population gets stagnant,
# so it could be useful add "fresh blood".
# Takes a variable number of arguments. The first argument is the
# total number, N, of new individuals to add. The remaining arguments
# are genomes to inject. There must be at most N genomes to inject.
# If the number, n, of genomes to inject is less than N, N - n random
# genomes are added. Perhaps an example will help?
# returns 1 on success and undef on error.

sub inject {
  my ($self, $count, @genomes) = @_;

  unless ($self->{INIT}) {
    carp "can't inject() before init()";
    return undef;
  }

  my $ind = $self->{INDIVIDUAL};

  my @newInds;
  for my $i (1 .. $count) {
    my $genes = shift @genomes;

    if ($genes) {
      push @newInds => $ind->newSpecific($genes, $self->{INITARGS});
    } else {
      push @newInds => $ind->newRandom  ($self->{INITARGS});      
    }
  }

  $_->fitness($self->{FITFUNC}) for @newInds;

  push @{$self->{PEOPLE}} => @newInds;

  return 1;
}