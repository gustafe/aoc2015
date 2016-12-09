#!/usr/bin/perl
# Advent of Code 2015 Day 13 - complete solution
# Problem link: http://adventofcode.com/2015/day/13
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d13
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

use Algorithm::Combinatorics qw(permutations);

my $file = 'input2.txt';
open F, "<$file" or die "can't open $file: $!\n";
my $feels;
my $people;
while (<F>) {
    chomp;
    s/\r//gm;
    my ( $p1, $op, $val, $p2 )
        = ( $_ =~ m/^(\S+) would (\S+) (\d+) .* (\S+)\.$/ );
    if ( $op eq 'lose' ) { $val = -$val }
    $feels->{$p1}->{$p2} = $val;
    $people->{$p1}++;
    $people->{$p2}++;
}
close F;

# For part 1, uncomment this, run and append the output to the input file
# foreach my $p ( sort keys %{$people} ) {
#     print "Gustaf would gain 0 happiness units by sitting next to $p.\n";
#     print "$p would gain 0 happiness units by sitting next to Gustaf.\n";
# }
# exit 0;

# Generate all permutations
my @list = keys %{$people};

my $arrangement = permutations( \@list );

while ( my $arr = $arrangement->next ) {
    my $happiness = 0;
    my @arr       = @{$arr};    # makes following code a bit easier to write
    for ( my $idx = 0 ; $idx <= $#arr ; $idx++ ) {
        if ( $idx == 0 ) {      # start of the list
            $happiness += (   $feels->{ $arr[$idx] }->{ $arr[ $idx + 1 ] }
                            + $feels->{ $arr[$idx] }->{ $arr[$#arr] } );
        } elsif ( $idx == $#arr ) {    # end of the list
            $happiness += (   $feels->{ $arr[$idx] }->{ $arr[0] }
                            + $feels->{ $arr[$idx] }->{ $arr[ $idx - 1 ] } );
        } else {
            $happiness += (   $feels->{ $arr[$idx] }->{ $arr[ $idx + 1 ] }
                            + $feels->{ $arr[$idx] }->{ $arr[ $idx - 1 ] } );
        }
    }
    print $happiness, ' ', join( ' ', @arr ), "\n";
}
