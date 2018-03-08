package Rules;

use Data::Dumper;

$UNIVERSAL::tests =
  {

   0 => sub {
     return 1;
   },

   1 => sub {
     return 1;
   },

  };

$UNIVERSAL::mhash =
  {

   0 => sub {
     # this test check removes OR
     my $i = shift;
     $it = $i->Key;
     $it =~ s/^\(.*?\)\s*//;
     $i->Key($it);
     return $i;
   },

   1 => sub {
     # this test check removes OR
     my $i = shift;
     $it = "";
     $i->Key($it);
     $i->Finished(1);
     return $i;
   },

  };

$UNIVERSAL::morder = {
		      1 => ["0"],
		     };

1;
