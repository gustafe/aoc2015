#!/usr/bin/perl
# Advent of Code 2015 Day 17 - complete solution
# Problem link: http://adventofcode.com/2015/day/17
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d17
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
use feature qw(say);
use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);

my $testing = 0;
my $file = $testing ? 'test.txt' : 'input.txt';
open F, "<$file" or die "can't open file: $!\n";

my $containers;

while (<F>) {
    chomp;
    s/\r//gm;
    push @{$containers}, $_;
}
close F;

my $target = $testing ? 25 : 150;
my $count = 0;
my %number_of_containers;

foreach my $k ( 1 .. $#{$containers} - 1 ) {
    my $iter = combinations( $containers, $k );
    while ( my $comb = $iter->next ) {
        if ( sum( @{$comb} ) == $target ) {
            $count++;
            $number_of_containers{ scalar @{$comb} }++;
        }
    }
}
say "Part 1: $count";
say "Part 2:";
say "#    count";
say "----------";

foreach my $n ( sort { $a <=> $b } keys %number_of_containers ) {
    printf( "%d % 8d\n", $n, $number_of_containers{$n} );
}
