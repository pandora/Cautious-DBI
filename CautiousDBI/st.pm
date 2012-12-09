package CautiousDBI::st;

use base 'DBI::st';

sub fetchrow_arrayref {
    my $sth = shift;

    my $row = $sth->SUPER::fetchrow_arrayref(@_);

    return unless defined $row && ref($row) eq 'ARRAY';
    return unless grep {defined $_} @$row;
    return $row;
}

sub fetchrow_array {
    my $sth = shift;

    my @row = $sth->SUPER::fetchrow_array(@_);

    return unless scalar @row;
    return unless grep {defined $_} @row;
    return @row;
}

1;
