#!/usr/bin/perl
# Advent of Code 2015 Day 1 - complete solution
# Problem link: http://adventofcode.com/2015/day/1
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html##d1_to_4
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
my $file = 'input.txt';
open F, "<$file" or die "couldn't open $file: $!\n";
my @array;
while (<F>) {
    chomp;
    s/\r//gm;
    my $line = $_;
    @array = split( '', $line );
}
close F;
my $floor     = 0;
my $count     = 1;
my $first_neg = 0;
my $ans2      = 0;
foreach my $c (@array) {
    if   ( $c =~ /\(/ ) { $floor++ }
    else                { $floor-- }
    if ( $floor == -1 and !$first_neg ) {
        $first_neg = 1;
        $ans2      = $count;
    }
    $count++;
}
print "Final floor: $floor\n";
print "First negative floor: $ans2\n";

