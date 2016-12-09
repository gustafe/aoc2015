#!/usr/bin/perl
# Advent of Code 2015 Day 3 - part 2
# Problem link: http://adventofcode.com/2015/day/3
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d1_to_4
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

sub move {
    my ( $x, $y, $d ) = @_;

    if ( $d =~ m/\^/ ) {    # north
        $y++;
    } elsif ( $d =~ m/\>/ ) {    # east
        $x++;
    } elsif ( $d =~ m/v/ ) {     # south
        $y--;
    } elsif ( $d =~ m/\</ ) {    #west
        $x--;
    } else {
        die "can't recognise dir: $d\n";
    }
    return [ $x, $y ];
}

my %M;                           # keep track of houses
my @santa = ( 1, 1 );
my @robot = ( 1, 1 );
$M{ join( ',', @santa ) } = 2;
my $file = 'input.txt';
open F, "<$file" or die "can't open $file: $!\n";
my @dirs;
while (<F>) {
    chomp;
    s/\r//gm;
    @dirs = split( '', $_ );
}
close F;
while (@dirs) {
    my $sdir = shift @dirs;
    my $rdir = shift @dirs;

    my @snext = @{ move( @santa, $sdir ) };
    my @rnext = @{ move( @robot, $rdir ) };

    $M{ join( ',', @snext ) }++;
    $M{ join( ',', @rnext ) }++;

    @santa = @snext;
    @robot = @rnext;
}

# count the houses
my $houses = scalar keys %M;

print "Houses: $houses\n";
