package CautiousDBI::Test;

use strict;
use warnings;

use CautiousDBI;
use base 'Exporter';

our @EXPORT_OK = qw/ $dbh $dataset/;

our $dbh = CautiousDBI->connect("dbi:SQLite:dbname=$FindBin::Bin/../db/testdb.db","","", ) or die 'Unable to connect to db.';
our $dataset = [ [1, 5], [2, 5], [3, 5], [4, 5], [5, 5] ];

sub tear {
    undef $dbh; 
    undef $dataset;
}

1;
