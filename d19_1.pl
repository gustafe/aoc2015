#!/usr/bin/perl
# Advent of Code 2015 Day 19 - part 1
# Problem link: http://adventofcode.com/2015/day/19
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d19
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

# pipe output through 'sort | uniq | wc -l '
use strict;
use warnings;
use feature qw/say/;

my $testing = 0;
my $file = $testing ? 'test.txt' : 'input.txt';
open F, "<$file" or die "can't open file: $!\n";
my %replacements;
my $source;

while (<F>) {
    chomp;
    s/\r//gm;
    next unless $_ =~ m/^\S+/;
    if ( $_ =~ m/^(\S+) => (\S+)$/ ) {
        push @{ $replacements{$1}->{vals} }, $2;
    }
    $source = $_;    # will be last
}
close F;

# split the source
foreach my $repl ( keys %replacements ) {
    while ( $source =~ m/$repl/g ) {
        push @{ $replacements{$repl}->{pos} }, [ $-[0], $+[0] ];
    }
}

foreach my $key ( sort keys %replacements ) {
    foreach my $rep ( @{ $replacements{$key}->{vals} } ) {
        foreach my $pos ( @{ $replacements{$key}->{pos} } ) {
            my $head = substr( $source, 0, $pos->[0] );
            my $tail = substr( $source, $pos->[1] );
            say $head. $rep . $tail;
        }
    }
}
