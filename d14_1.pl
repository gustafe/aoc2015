#!/usr/bin/perl
# Advent of Code 2015 Day 14 - part 1
# Problem link: http://adventofcode.com/2015/day/14
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d14
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

my $file = 'input.txt';
open F, "<$file" or die "can't open file: $!\n";

my %data;
while (<F>) {
    chomp;
    s/\r//gm;
    my ( $reindeer, $speed, $fly, $rest )
        = (
          $_ =~ m/^(\S+) can fly (\d+) km\/s for (\d+) .* (\d+) seconds\.$/ );
    $data{$reindeer} = { speed => $speed, fly => $fly, rest => $rest };
}

my $limit = ( $file eq 'test.txt' ) ? 1_000 : 2_503;

foreach my $deer ( keys %data ) {
    my ( $fly, $rest, $speed )
        = map { $data{$deer}->{$_} } qw/fly rest speed/;
    my $seq = $fly + $rest;

    my $whole = int( $limit / $seq );
    my $dist += $whole * $speed * $fly;
    my $diff = $limit - $whole * $seq;

    if ( $diff <= $fly ) {
        $dist += $diff * $speed;
    } else {
        $dist += $fly * $speed;
    }
    print join( ' ', $dist, $deer ), "\n";
}
