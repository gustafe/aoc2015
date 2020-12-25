#!/usr/bin/perl
# Advent of Code 2015 Day 6 - part 2
# Problem link: http://adventofcode.com/2015/day/6
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d6
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

### get the input
my @states;
my $file = 'input.txt';
open F, "<$file" or die "couldn't open $file: $!";
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

            # lights can be undefined (starting state), off (0) or > 0
            # might as well treat undefined as 0
            my $current = defined( $M->{$x}->{$y} ) ? $M->{$x}->{$y} : 0;
            if ( $state eq 'n' ) {    # increase by 1
                $M->{$x}->{$y} += 1;
            } elsif ( $state eq 't' ) {    # increase by 2
                $M->{$x}->{$y} += 2;
            } elsif ( $state eq 'f' ) {  # decrease by 1, to a minimum of zero
                if ( $current <= 1 ) {
                    $M->{$x}->{$y} = 0;
                } else {
                    $M->{$x}->{$y} -= 1;
                }
            } else {
                $M->{$x}->{$y} = $current;
            }    # fallthrough, shouldn't happen
        }
    }
}

### apply the states
my $idx = 0;
foreach my $s (@states) {
    act( @{$s} );
    $idx++;
}

### count the brightness
my $count = 0;
foreach my $x ( keys %{$M} ) {
    foreach my $y ( keys %{ $M->{$x} } ) {
        $count += $M->{$x}->{$y};
    }
}
print "Brightness: $count\n";

