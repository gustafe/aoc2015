#!/usr/bin/perl
# Advent of Code 2015 Day 5 - part 1
# Problem link: http://adventofcode.com/2015/day/5
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d05
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

my $file = 'input.txt';
open F, "<$file" or die "can't open $file: $!\n";
my @valids;
while (<F>) {
    chomp;
    s/\r//gm;
    next if $_ =~ m/ab|cd|pq|xy/; # forbidden combos 
    next unless $_ =~ m/[aeiou].*[aeiou].*[aeiou]/; # contains three vowels
    next unless $_ =~ m/(.)\1/; # at least one repeated letter
    push @valids, $_;
}
close F;

print "1. number of valid passwords: ", scalar @valids, "\n";
