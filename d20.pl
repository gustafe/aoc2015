#!/usr/bin/perl
# Advent of Code 2015 Day 20 - complete solution
# Problem link: http://adventofcode.com/2015/day/20
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d20
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################


use strict;
use warnings;
use feature qw/say/;
use List::Util qw/sum/;

my $part    = 2;
my $testing = 0;
my $target  = $testing ? 1_000 : 36_000_000;

sub divisors {

    # algo from http://www.perlmonks.org/?node_id=371578
    my ($n) = @_;
    my @divisors = grep { $n % $_ == 0 } ( 1 .. sqrt($n) );
    push @divisors, map { $n == $_ * $_ ? () : $n / $_ } reverse @divisors;

    return \@divisors;
}

sub divisors2 {

# method from https://www.reddit.com/r/adventofcode/comments/3xjpp2/day_20_solutions/cy5dias
    my ($n) = @_;
    my $x = 1;
    my @divisors;
    while ( $x**2 <= $n and $x <= 50 ) {
        if ( $n % $x == 0 ) {
            push @divisors, $n / $x;
        }
        $x++;
    }
    return \@divisors;
}

my $elf = 1;
if ( $part != 2 ) {
    while ( 10 * sum( @{ divisors($elf) } ) < $target ) {
        warn "==> $elf\n" if $elf % 1_000 == 0;
        $elf++;
    }
} else {
    while ( 11 * sum( @{ divisors2($elf) } ) < $target ) {
        warn "==> $elf\n" if $elf % 1_000 == 0;
        $elf++;
    }
}
say $elf;
