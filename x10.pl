#! /usr/bin/env perl
# Advent of Code 2015 Day 10 - alternative complete solution
# Problem link: http://adventofcode.com/2015/day/10
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d10
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use 5.016;
use warnings;
use autodie;

#### INIT - load input data from file into array
my $testing = 0;
my $part2 = shift || 0;
my @input;
my $file = $testing ? 'test.txt' : 'input.txt';
open( my $fh, '<', "$file" );
while (<$fh>) { chomp; s/\r//gm; push @input, $_; }

### CODE
my $in = shift @input;

my $count = 0;
my $limit = $testing ? 5 : ( $part2 ? 50 : 40 );

# https://rosettacode.org/wiki/Look-and-say_sequence#Perl
while ( $count < $limit ) {
    $in =~ s/((.)\2*)/length($1) . $2/ge;
    $count++;
}

say $part2 ? '2' : '1', ". length of sequence after $limit iterations: ",
  length($in);

