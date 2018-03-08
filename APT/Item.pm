package APT::Item;

use APT::Record;

use Data::Dumper;

use Class::MethodMaker
  new_with_init => 'new',
  get_set       => [ qw / History TmpMethods Methods / ];

sub init {
  my ($self,%args) = (shift,@_);
  $self->Methods({});
  $self->History($args{History} ||
		 [APT::Record->new(Value => $args{Value},
				   Methods => ["c"])]);
  $self->Methods->{"c"} = 1;
}

sub Start {
  my ($self,%args) = (shift,@_);
  return $self->History->[0]->Value;
}

sub Modify {
  my ($self,%args) = (shift,@_);
  if ($args{Value} ne $self->Current) {
    push @{$self->History}, APT::Record->new(Value => $args{Value},
					     Methods => $args{Methods});
    foreach my $m (@{$args{Methods}}) {
      $self->Methods->{$m} = 1;
    }
  }
}

sub Current {
  my ($self,%args) = (shift,@_);
  if (defined $self->History) {
    return $self->History->[-1]->Value;
  } else {
    return "";
  }
}

sub Rejected {
  my ($self,%args) = (shift,@_);
  return $self->Current->Rejected;
}

sub Process {
  my ($self,$cnt) = (shift,shift);
  $self->TmpMethods([]);
  my $v = $self->Current;

  # determine which tests we can perform based on dependencies
  # perform those test/process pairs

  foreach my $key ($self->AvailableMethods) {
    $v = $self->UseMethod(Value => $v,
			  Key => $key);
  }
  $self->Modify(Value => $v,
		Methods => $self->TmpMethods);
}

sub AvailableMethods {
  my ($self,%args) = (shift,@_);
  my @avail;
  foreach my $k1 (keys %{$UNIVERSAL::tests}) {
    my $ok = 1;
    if (exists $UNIVERSAL::morder->{$k1}) {
      # check all dependencies have been met
      foreach my $k2 (@{$UNIVERSAL::morder->{$k1}}) {
	if (! exists $self->Methods->{$k2}) {
	  $ok = 0;
	}
      }
    }
    if ($ok) {
      push @avail, $k1;
    }
  }
  return @avail;
}

sub UseMethod {
  my ($self,%args) = (shift,@_);
  my $v = $args{Value};
  if (&{$UNIVERSAL::tests->{$args{Key}}}($v)) {
    $self->Methods->{$args{Key}} = 1;
    $v = &{$UNIVERSAL::mhash->{$args{Key}}}($v);
    if ($v ne $args{Value}) {
      push @{$self->TmpMethods}, $args{Key};
    }
  }
  return $v;
}

sub Print {
  my ($self,%args) = (shift,@_);
  my $a = "";
  if (defined $args{All}) {
    # $a .= "<item reference=\"$self\">\n";
    $a .= "<item>\n";
    foreach my $h (@{$self->History}) {
      $a .= "\t".$h->Print. "\n";
    }
    $a .= "</item>\n";
  } else {
    $a .= $self->Start."\n".$self->End."\n\n";
  }
}

1;
