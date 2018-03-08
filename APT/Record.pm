package APT::Record;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / Value Methods / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Value($args{Value} || "");
  $self->Methods($args{Methods} || []);
}

sub Print {
  my ($self,%args) = (shift,@_);
  return "<record value=\"".$self->Value->Print . "\" methods=\"" . join (",",@{$self->Methods})."\">";
}

1;
