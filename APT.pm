package APT;

# AutoMap Preprocessing Tool

use APT::Item;
use Ingredient;
use Rules;

use Data::Dumper;
use List::Util 'shuffle';

sub Process {
  my $cnt = 0;
  foreach my $m (@methods) {
    $UNIVERSAL::mhash->{$cnt++} = $m;
  }

  my %dict;

  foreach my $w (split /\n/,`cat /usr/share/dict/words`) {
    $dict{lc($w)} = 1;
  }

  my (@unfinished, @finished, @rejected);
  my $lastsize = 0;
  my @items = shuffle(@{eval `cat ingred`});
  @items = splice(@items,0,1000);
  my @q = map APT::Item->new(Value => Ingredient->new(Key => $_)), @items;
  foreach my $it (@q) {
    $items{$it} = $it;
  }
  my $count = 0;
  my $mods = 0;
  while (@q) {
    print "Run <$count> Size <".scalar @q."> LastSize <$lastsize> Mods <$mods>\n";
    $mods = 0;
    ++$count;
    my $ppl;
    my $t = {};
    foreach my $item (@q) {
      $item->Process;
      if ($item->Rejected) {
	push @rejected, $item;
      } elsif (! $item->Current->Finished) {
	print "-";
	push @unfinished, $item;
      } else {
	print "+";
	my $pass = 1;
	if ($pass) {
	  push @finished, $item;
	}
      }
    }
    $lastsize = scalar @q;
    @q = @unfinished;
    @unfinished = ();
  }

  # print Dumper($t);
  # print Dumper([@q]);

  my $OUT;
  open (OUT,">output-data/finished.pld") or die "can't open tmp.csv\n";
  print OUT Dumper([@finished]);
  close (OUT);
  open (OUT,">output-data/rejected.pld") or die "can't open tmp.csv\n";
  print OUT Dumper([@rejected]);
  close (OUT);
  open (OUT,">output-data/output.log") or die "can't open tmp.csv\n";
  foreach my $item (values %items) {
    print OUT $item->Print(All => 1);
  }
  close (OUT);
}

1;
