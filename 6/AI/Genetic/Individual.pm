
package AI::Genetic::Individual;

use strict;
use vars qw/$VERSION/;
$VERSION = 0.02;

# this package is to serve as a base package to
# all other individuals. It doesn't do anything
# interesting.

1;

sub new {  # hmm .. do I need this?
  my ($class, $genes) = @_;

  my $self;
  if (ref $class) { # clone mode
    $self = bless {} => ref $class;
    $self->{$_} = $class->{$_} for keys %$class;
    $self->{GENES}  = $genes;
    $self->{CALCED} = 0;

  } else {          # new mode. Genome is given
    goto &newSpecific;
  }

  return $self;
}

sub new_old {  # hmm .. do I need this?
  my ($class, $genes) = @_;

  my $self;
  if (ref $class) { # clone mode
    $self = bless {} => ref $class;
    $self->{$_} = $class->{$_} for keys %$class;
    $self->{GENES}  = $genes;
    $self->{CALCED} = 0;

  } else {          # new mode. Just call newRandom.
    goto &newRandom;
  }

  return $self;
}

# should create default methods.
# those are the only three needed.
sub newRandom   {}
sub newSpecific {}
sub genes       {}

# the following methods shouldn't be overridden.
sub fitness {
  my ($self, $sub) = @_;

  $self->{FITFUNC} = $sub if $sub;
  return $self->{FITFUNC};
}

sub score {
  my $self = shift;

  return $self->{SCORE} if $self->{CALCED};

  $self->{SCORE}  = $self->{FITFUNC}->(scalar $self->genes);
  $self->{CALCED} = 1;

  return $self->{SCORE};
}

sub resetScore { $_[0]{CALCED} = 0 }

# hmmm .. how do I reset {CALCED} in case of mutation?
