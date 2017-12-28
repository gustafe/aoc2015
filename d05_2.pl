#!/usr/bin/perl
# Advent of Code 2015 Day 5 - part 2
# Problem link: http://adventofcode.com/2015/day/5
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d05
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

my $file = 'input.txt';
open F, "<$file" or die "can't open $file: $!\n";
my $count =0;
while (<F>) {
    chomp;
    s/\r//gm;
    # regex solution from https://www.reddit.com/r/adventofcode/comments/3viazx/day_5_solutions/cxo0y93
    if ( $_ =~ m/^(?=.*(.).\1.*)(?=.*(..).*\2).*/gm  ) { $count++ }
    else { next }
    
}
close F;
print "2. number of valid passwords: $count\n";
__DATA__
qjhvhtzxzqqjkmpb
xxyxx
uurcxstgmygtbstg
ieodomkazucvgmuy
