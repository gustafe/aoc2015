#!/usr/bin/perl
# Advent of Code 2015 Day 2 - complete solution
# Problem link: http://adventofcode.com/2015/day/2
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d1_to_4
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
use List::Util qw(sum);
my $file = 'input.txt';
open F, "<$file" or die "couldn't open $file: $!\n";

my $paper  = 0;
my $ribbon = 0;

while (<F>) {
    chomp;
    s/\r//gm;
    my $dim = $_;
    my ( $l, $w, $h );
    my @areas;
    my @perims;
    if ( $dim =~ m/(\d+)x(\d+)x(\d+)/ ) {
        ( $l, $w, $h ) = ( $1, $2, $3 );

        @areas = ( $l * $w, $w * $h, $h * $l );
        @perims = map { 2 * $_ } ( $l + $w, $w + $h, $h + $l );

        @areas  = sort { $a <=> $b } @areas;
        @perims = sort { $a <=> $b } @perims;

        my $slack = $areas[0];     # smallest side for slack
        my $round = $perims[0];    # smallest perimeter
        my $area = ( 2 * $areas[0] + 2 * $areas[1] + 2 * $areas[2] );
        my $bow  = $h * $l * $w;

        $paper  += $slack + $area;
        $ribbon += $round + $bow;
    } else {
        warn "can't parse $dim\n";
        next;
    }
}
close F;

print "Paper: $paper\n";
print "Ribbon: $ribbon\n";

