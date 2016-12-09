#!/usr/bin/perl
# Advent of Code 2015 Day 16 - complete solution
# Problem link: http://adventofcode.com/2015/day/16
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d16
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
my $testing = 0;
my $file = $testing ? 'test.txt' : 'input.txt';
open F, "<$file" or die "can't open file: $!\n";
my %aunts;
while (<F>) {
    chomp;
    s/\r//gm;
    my ( $aunt, $props ) = ( $_ =~ m/^(Sue \d+): (.*)$/ );
    my @properties = split( /,/, $props );
    while (@properties) {
        my $property = shift @properties;
        my ( $key, $val ) = ( $property =~ m/(\S+)\: (\d+)/ );
        $aunts{$aunt}->{$key} = $val;
    }
}
close F;

my %clues;
while (<DATA>) {
    chomp;
    my ( $key, $val ) = ( $_ =~ /^(\S+)\: (\d+)$/ );
    $clues{$key} = $val;
}

foreach my $aunt ( keys %aunts ) {
    my $score      = 0;
    my %properties = %{ $aunts{$aunt} };
    foreach my $clue ( keys %clues ) {
        if ( exists $properties{$clue} ) {
            if ( $clue eq 'cats' or $clue eq 'trees' ) {
                $score++ if $properties{$clue} > $clues{$clue};
            } elsif ( $clue eq 'goldfish' or $clue eq 'pomeranians' ) {
                $score++ if $properties{$clue} < $clues{$clue};
            } else {
                $score++ if $properties{$clue} == $clues{$clue};
            }
        }
    }
    print "$score $aunt\n";
}

__DATA__
children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1
