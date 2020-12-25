#! /usr/bin/env perl
# Advent of Code 2015 Day 9 - alternative complete solution
# Problem link: http://adventofcode.com/2015/day/9
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d09
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use 5.016;
use warnings;
use autodie;

# useful modules
use List::Util qw/max min/;
use Algorithm::Combinatorics qw(permutations);
#### INIT - load input data from file into array
my $testing = 0;
my @input;
my $file = $testing ? 'test.txt' : 'input.txt';
open( my $fh, '<', "$file" );
while (<$fh>) { chomp; s/\r//gm; push @input, $_; }

### CODE
my %locations;
my $map;
while (@input) {
    my $line = shift @input;
    if ( $line =~ m/^(\S+) to (\S+) \= (\d+)$/ ) {

        #	$locations{$1}++;
        #	$locations{$2}++;
        $map->{$1}->{$2} = $3;
        $map->{$2}->{$1} = $3;
    }
    else {
        die "cannot parse: $line";
    }
}
my ( $max, $min ) = ( 0, 1e6 );
my $iter = permutations( [ keys %$map ] );
while ( my $p = $iter->next ) {
    my $dist = 0;
    for ( my $i = 0 ; $i < scalar @$p - 1 ; $i++ ) {
        my $j = $i + 1;
        $dist += $map->{ $p->[$i] }->{ $p->[$j] };
    }
    $max = max( $max, $dist );
    $min = min( $min, $dist );
}

say "1. shortest route: $min";
say "2. longest route : $max";

