#!/usr/bin/perl 
# Advent of Code 2015 Day 9 - complete solution
# Problem link: http://adventofcode.com/2015/day/9
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d9
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);
my $map;
my %destinations;
my $file = 'input.txt';
open F, "<$file" or die "can't open $file: $!\n";
while (<F>) {
    chomp;
    s/\r//gm;
    if ( $_ =~ m/^(.*) to (.*) \= (\d+)$/ ) {
        $destinations{$1}++;
        $destinations{$2}++;
        $map->{$1}->{$2} = $3;
        $map->{$2}->{$1} = $3;
    }
}
close F;
my @data = keys %destinations;
my $iter = permutations( \@data );
while ( my $p = $iter->next ) {
    my $dist = 0;
    for ( my $i = 0 ; $i < scalar @{$p} - 1 ; $i++ ) {
        my $j = $i + 1;
        $dist += $map->{ $p->[$i] }->{ $p->[$j] };
    }
    print $dist, ' ', join( ' ', @{$p} ), "\n";
}
