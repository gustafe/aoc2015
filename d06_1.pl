#!/usr/bin/perl
# Advent of Code 2015 Day 6 - part 1
# Problem link: http://adventofcode.com/2015/day/6
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d6
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

### get the input
my @states;
my $file = 'input.txt';
open F, "<$file" or die "couldn't open $file: $!\n";
while (<F>) {
    chomp;
    s/\r$//gm;
    my ( $state, $c1, $c2 );
    if ( $_ =~ m/(.*)\ (\d+\,\d+)\ through (\d+\,\d+)/ ) {
        my $word = $1;
        if    ( $word eq 'turn on' )  { $state = 'n' }
        elsif ( $word eq 'turn off' ) { $state = 'f' }
        elsif ( $word eq 'toggle' )   { $state = 't' }
        else                          { die "wtf is $word ?!" }
        $c1 = $2;
        $c2 = $3;
    }
    push @states, [ $state, $c1, $c2 ];
}
close F;

### store the lights in a big ole matrix
my $M;

sub act {
    my ( $state, $start, $end ) = @_;
    my @start = split( /\,/, $start );
    my @end   = split( /\,/, $end );

    # x-axis
    foreach my $x ( $start[0] .. $end[0] ) {
        foreach my $y ( $start[1] .. $end[1] ) {

            # lights can be undefined (starting state), off (0) or on (1)
            # might as well treat undefined as 0
            my $current = defined( $M->{$x}->{$y} ) ? $M->{$x}->{$y} : 0;
            if ( $current == 0 && $state eq 'n' ) {    # turn on
                $M->{$x}->{$y} = 1;
            } elsif ( $current == 1 && $state eq 'f' ) {    # turn off
                $M->{$x}->{$y} = 0;
            } elsif ( $current == 0 && $state eq 't' ) {    # toggle 0 to 1
                $M->{$x}->{$y} = 1;
            } elsif ( $current == 1 && $state eq 't' ) {    # toggle 1 to 0
                $M->{$x}->{$y} = 0;
            } else {
                $M->{$x}->{$y} = $current;
            }
        }
    }
}

### apply the states
my $idx = 0;
foreach my $s (@states) {
    act( @{$s} );
    $idx++;
}

### count the lights
my $count = 0;
foreach my $x ( keys %{$M} ) {
    foreach my $y ( keys %{ $M->{$x} } ) {
        $count++ if $M->{$x}->{$y} == 1;
    }
}
print "Lights: $count\n";
