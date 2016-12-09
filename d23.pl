#!/usr/bin/perl
# Advent of Code 2015 Day 23 - complete solution
# Problem link: http://adventofcode.com/2015/day/23
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d23
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
use feature qw/say/;

my $debug   = 0;
my $testing = 0;
my $file    = $testing ? 'test.txt' : 'input.txt';

my @tape;

open F, "<$file" or die "can't open file: $!\n";
while (<F>) {
    chomp;
    s/\r//gm;
    my ( $cmd, $reg, $arg ) = ( undef, undef, undef );
    if ( $_ =~ m/^(...) (.)$/ ) {
        ( $cmd, $reg ) = ( $1, $2 );
        push @tape, [ $cmd, $reg, undef ];
    } elsif ( $_ =~ m/^(...) (.), ([-+]\d+)$/ ) {
        ( $cmd, $reg, $arg ) = ( $1, $2, $3 );
        push @tape, [ $cmd, $reg, $arg ];
    } elsif ( $_ =~ m/^(...) ([-+]\d+)$/ ) {
        ( $cmd, $arg ) = ( $1, $2 );
        push @tape, [ $cmd, undef, $arg ];
    } else {
        die "cannot parse: $_ \n";
    }
}
close F;

my $pos = 0;
my %reg = ( a => 0, b => 0 );

while ( $pos >= 0 and $pos <= $#tape ) {
    my @input = @{ $tape[$pos] };
    say "$pos: a=$reg{a} b=$reg{b} : ",
        join( ' ', map { $_ ? $_ : ' ' } @input )
        if $debug;
    my ( $cmd, $var, $offset ) = @input;
    if ( $cmd eq 'inc' ) {
        $reg{$var}++;
        $pos++;
    } elsif ( $cmd eq 'tpl' ) {
        $reg{$var} = $reg{$var} * 3;
        $pos++;
    } elsif ( $cmd eq 'hlf' ) {
        $reg{$var} = $reg{$var} / 2;
        $pos++;
    } elsif ( $cmd eq 'jmp' ) {
        $pos += $offset;
    } elsif ( $cmd eq 'jie' ) {
        if ( $reg{$var} % 2 == 0 ) {
            $pos += $offset;
        } else {
            $pos++;
        }
    } elsif ( $cmd eq 'jio' ) {
        if ( $reg{$var} == 1 ) {
            $pos += $offset;
        } else {
            $pos++;
        }
    } else {
        die "can't recognise cmd: $cmd\n";
    }
}

say "a=$reg{a}, b=$reg{b}";
