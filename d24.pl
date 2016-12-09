#!/usr/bin/perl
# Advent of Code 2015 Day 24 - part 1 / part 2 / complete solution
# Problem link: http://adventofcode.com/2015/day/24
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d24
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
use feature qw/say/;
use Algorithm::Combinatorics qw/combinations/;
use List::Util qw/sum/;

my $part    = 2;
my $testing = 0;
my $debug   = 0;
my $file    = $testing ? 'test.txt' : 'input.txt';

sub product {    # my version of List::Util doesn't include a 'product'
    my @list = @_;
    return undef if scalar @list == 0;
    my $product = 1;
    foreach my $el (@list) {
        $product *= $el;
    }
    return $product;
}

my $sum = 0;
my @pkgs;
open F, "<$file" or die "can't open file: $!\n";
while (<F>) {
    chomp;
    s/\r//gm;
    push @pkgs, $_;
    $sum += $_;
}
close F;

my $target;
if ( $part == 2 ) {
    $target = $sum / 4;
} else {
    $target = $sum / 3;
}

@pkgs = sort { $b <=> $a } @pkgs;

# iterate over combinations until we get the desired sum
my $ans = 'Inf';
foreach my $n ( 1 .. 6 ) {    # hardcoded limit
    my $iter = combinations( \@pkgs, $n );
    while ( my $c = $iter->next ) {
        next unless $target == sum @{$c};

        # As a first approximation, assume we don't have to check the
        # rest of the packages -- just go with the first one we find.
        my $prod = product @{$c};
        say $prod, ' ', join( ' ', @{$c} ) if $debug;
        $ans = $prod if $prod < $ans;
    }
}
say $ans if ( $ans ne 'Inf' );
