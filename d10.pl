#!/usr/bin/perl
# Advent of Code 2015 Day 10 - complete solution
# Problem link: http://adventofcode.com/2015/day/10
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d10
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

sub lookandsay {
    my ($in) = @_;
    my @seq = split( //, $in );
    my $c1 = shift @seq;
    my @res;
    push @res, [ $c1, 1 ];
    while (@seq) {
        my $c2 = shift @seq;
        if ( $c1 eq $c2 ) {    # add a count to the character in the result
            $res[ scalar @res - 1 ]->[1]++;
        } else {
            push @res, [ $c2, 1 ];
            $c1 = $c2;
        }
    }
    my $res;
    foreach my $r (@res) {
        $res .= $r->[1] . $r->[0];
    }
    return $res;
}

my $in    = 1113122113;
my $count = 0;

# part 1: change limit to 40
while ( $count < 50 ) {
    my $res = lookandsay($in);
    $in = $res;
    $count++;
}
print length($in), "\n";
