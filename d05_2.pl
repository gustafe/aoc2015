#!/usr/bin/perl
# Advent of Code 2015 Day 5 - part 2
# Problem link: http://adventofcode.com/2015/day/5
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d5
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

# will print out all passwords that match, use wc or similar to count them
use strict;
use warnings;

my $file = 'input.txt';
open F, "<$file" or die "can't open $file: $!\n";
while (<F>) {
    chomp;
    s/\r//gm;

# regex solution from https://www.reddit.com/r/adventofcode/comments/3viazx/day_5_solutions/cxo0y93
    if   ( $_ =~ m/^(?=.*(.).\1.*)(?=.*(..).*\2).*/gm ) { print "$_\n" }
    else                                                { next }

}
close F

__DATA__
qjhvhtzxzqqjkmpb
xxyxx
uurcxstgmygtbstg
ieodomkazucvgmuy
