#!/usr/bin/perl
# Advent of Code 2015 Day 4 - part 2
# Problem link: http://adventofcode.com/2015/day/4
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d04
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

my $key = 'bgvyzdsv';
my $n=0;
my $md5;
my $part2 = shift || 0;

my $target = $part2 ? '000000' : '00000';
while (1) {
    $md5 = md5_hex($key,$n);
    # for part 1, decrease the number of zeroes below by 1
    if ($md5 =~ m/^$target/ ) {
	print $part2? '2. ':'1. ', "lowest number: $n\n";
	last;
    }
    $n++;
}
