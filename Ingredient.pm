package Ingredient;

use Manager::Dialog qw ( Choose );
use MyFRDCSA;
use Data::Dumper;

$VERSION = '1.00';
use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / Key Object Attributes Rejected Finished / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Key($args{Key});
}

sub Print {
  my ($self,%args) = (shift,@_);
  return $self->Key;
}

1;
