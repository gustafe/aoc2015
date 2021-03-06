#!/usr/bin/perl
# Advent of Code 2015 Day 3 - part 1
# Problem link: http://adventofcode.com/2015/day/3
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d03
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

my %M; # matrix, first element x, second y, value: nr of visits;
my @start = (1,1);
$M{join(',',@start)}++;
my $file = 'input.txt';
open F, "<$file" or die "can't open $file: $!\n";
my @dirs;
while (<F>) {
    chomp;
    s/\r//gm;
    @dirs = split('',$_);
}
close F;
my @next=(0,0);
foreach my $dir (@dirs) {

    if ( $dir eq '^') {  # north
	$next[1] = $start[1]+1 
    } elsif ( $dir eq '>') { # east
	$next[0] = $start[0]+1
    } elsif ( $dir eq 'v' ) { # south
	$next[1] = $start[1]-1
    } elsif ( $dir eq '<') { #west
	$next[0] = $start[0]-1
    } else {
	die "can't recognise dir: $dir\n"
    }
    # leave a present
    $M{join(',',@next)}++;
    @start = @next;
}
# count the houses
my $houses = scalar keys %M;

print "1. houses with at least one present: $houses\n";
