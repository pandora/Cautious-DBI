use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../";

use Test::More 'no_plan';
use CautiousDBI::Test qw/ $dbh $dataset /;

use_ok( 'CautiousDBI' );

use_ok( 'DBI' );
use_ok( 'DBD::SQLite' );

# - fetchrow_array
{
    no warnings qw/redefine once/;
    local *DBI::st::fetchrow_array = sub { return (undef, undef) };
    my $sth = $dbh->prepare('select * from test');
    $sth->execute;
    my $counter = 0;
    while(my @row = $sth->fetchrow_array) {
        $counter++;
    }
    is($counter, 0, 'fetchrow_array: return empty if list is poulated with undef');
}

my $sth = $dbh->prepare('select * from test');
$sth->execute;
my @results;
while(my @row = $sth->fetchrow_array) {
    push @results, \@row;
}
is(scalar @results, 5, 'fetchrow_array: Return normally');
is_deeply(\@results, $dataset, 'fetchrow_array: check data');

# - fetchrow_arrayref
{
    no warnings qw/redefine once/;
    local *DBI::st::fetchrow_arrayref = sub { return [undef, undef] };
    my $sth = $dbh->prepare('select * from test');
    $sth->execute;
    my $counter = 0;
    while(my $row = $sth->fetchrow_arrayref) {
        $counter++;
    }
    is($counter, 0, 'fetchrow_arrayref: return empty if list is poulated with undef');
}

$sth = $dbh->prepare('select * from test');
$sth->execute;
my $counter = 0;
@results = ();
while(my $row = $sth->fetchrow_arrayref) {
   push @results, [ @$row ];
}
is(scalar @results, 5, 'fetchrow_arrayref: Return normally');
is_deeply(\@results, $dataset, 'fetchrow_arrayref: check data');

CautiousDBI::Test::tear();
