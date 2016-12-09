#!/usr/bin/perl
# Advent of Code 2015 Day 18 - complete solution
# Problem link: http://adventofcode.com/2015/day/18
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d18
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################


use strict;
use warnings;
use feature qw/say/;
use Storable qw/dclone/;

my $testing = 0;
my $part    = 2;
my $file
    = $testing
    ? ( $part == 2 ? 'test2.txt' : 'test.txt' )
    : ( $part == 2 ? 'input2.txt' : 'input.txt' );

open F, "<$file" or die "can't open file: $!\n";
my $curr;
my $next;
my $row = 0;
while (<F>) {
    chomp;
    s/\r//gm;
    my @line = split( //, $_ );
    my $col = 0;
    foreach my $l (@line) {
        if ( $l =~ m/\#/ ) {
            $curr->{$row}->{$col} = 1;
        } else {
            $curr->{$row}->{$col} = 0;
        }
        $col++;
    }

    $row++;
}
close F;

sub dump_grid {    # used for debugging
    my ($matrix) = @_;
    foreach my $r ( sort { $a <=> $b } keys %{$matrix} ) {
        foreach my $c ( sort { $a <=> $b } keys %{ $matrix->{$r} } ) {
            print $matrix->{$r}->{$c};
        }
        say '';
    }
}
my $max_steps = $testing ? ( $part == 2 ? 5 : 4 ) : 100;
my $step = 0;
while ( $step < $max_steps ) {
    foreach my $r ( keys %{$curr} ) {    # sort needed?
        foreach my $c ( keys %{ $curr->{$r} } ) {

            # check surrounding lights
            my $lit = 0;
            foreach my $i ( -1, 0, 1 ) {
                foreach my $j ( -1, 0, 1 ) {
                    next
                        if ( $c + $j == $c and $r + $i == $r ); # skip current
                    if ( !defined( $curr->{ $r + $i }->{ $c + $j } )
                         or $curr->{ $r + $i }->{ $c + $j } == 0 )
                    {                                           #nop
                    } else {
                        $lit++;
                    }
                }
            }

            # decide what to do
            if ( $curr->{$r}->{$c} == 0 and $lit == 3 ) {
                $next->{$r}->{$c} = 1;
            } elsif ( $curr->{$r}->{$c} == 1 and !( $lit == 2 or $lit == 3 ) )
            {
                $next->{$r}->{$c} = 0;
            } else {
                $next->{$r}->{$c} = $curr->{$r}->{$c};
            }
            if ( $part == 2 ) {    # ensure corners lit
                $next->{0}->{0}                   = 1;
                $next->{0}->{ $row - 1 }          = 1;
                $next->{ $row - 1 }->{0}          = 1;
                $next->{ $row - 1 }->{ $row - 1 } = 1;
            }
        }
    }
    if ($testing) { say "Step $step:"; dump_grid($next); say ''; }

    $curr = dclone($next);
    $step++;
}

# count lit lights
my $count = 0;
foreach my $r ( keys %{$curr} ) {
    foreach my $c ( keys %{ $curr->{$r} } ) {
        $count++ if $curr->{$r}->{$c} == 1;
    }
}
printf( "Result part %d: %d\n", $part == 2 ? 2 : 1, $count );
