#!/usr/bin/perl -s 
use strict;
use warnings;

use DBI;

my @example_data = ( { first_name => 'Rose',
                     last_name  => 'Tyler',
                     home       => 'Earth' },
                   { first_name => 'Zoe',
                     last_name  => 'Heriot',
                     home       => 'Space Station W3'},
                   { first_name => 'Jo',
                     last_name  => 'Grant',
                     home       => 'Earth'},
                   { first_name => 'Leela',
                     last_name  => '',
                     home       => 'Unspecified'},
                   { first_name => 'Romana',
                     last_name  => '',
                     home       => 'Gallifrey'},
                   { first_name => 'Clara',
                     last_name  => 'Oswald',
                     home       => 'Earth'},
                   { first_name => 'Adric',
                     last_name  => '',
                     home       => 'Alzarius'},
                   { first_name => 'Susan',
                     last_name  => 'Foreman',
                     home       => 'Gallifrey'} );

# Connect to DB
my $dbname = defined $ARGV[0] ? $ARGV[0] : 'OP_PerlDemo';
my $dsn = "dbi:SQLite:dbname:$dbname";
my $user = "";
my $pass = "";

my $dbh = DBI->connect($dsn, $user, $pass, {
  PrintError => 0,
  RaiseError => 1,
  AutoCommit => 1,
  FetchHashKeyName => 'NAME_lc'
});

# Create new table with sample data if no dbname argument provided
unless (defined $ARGV[0]) {
  # Create table `people`
  my $sql = '
  CREATE TABLE IF NOT EXISTS people (
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    home VARCHAR(100)
  ) ';

  $dbh->do($sql);

  # Insert rows from `example_data`
  for my $person_hash (@example_data) {
    my @columns = keys %$person_hash;
    my @values = values %$person_hash;

    local $" = "', '";
    $sql = "INSERT INTO people ('@columns') VALUES ('@values')";

    $dbh->do($sql);
  }
}

# Read all table data
my $sth = $dbh->prepare("SELECT * FROM people");
$sth->execute();

# Output table data
print "All items in table `people`:\n\n";
my $count = 0;
while (my $row = $sth->fetchrow_hashref) {
  $count++;
  print "Person $count:\n";
  print "Name: $row->{first_name} $row->{last_name}\n";
  print "Home: $row->{home} \n\n";
}


