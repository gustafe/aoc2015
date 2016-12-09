#!/usr/bin/perl
# Advent of Code 2015 Day 4 - complete solution
# Problem link: http://adventofcode.com/2015/day/4
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d1_to_4
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

my $key = 'bgvyzdsv';
my $n   = 0;
my $md5;

while (1) {
    $md5 = md5_hex( $key, $n );

    # for part 1, decrease the number of zeroes below by 1
    if ( $md5 =~ m/^000000/ ) {
        print $n, "\n";
        exit 0;
    }
    $n++;
}
