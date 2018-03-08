package APT::Method;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / Id Depends Sub / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Id($args{Id} || $UNIVERSAL::methodcounter++);
  $self->Depends($args{Depends} || []);
  $self->Sub($args{Sub});
}

1;
