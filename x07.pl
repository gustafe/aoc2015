#! /usr/bin/env perl
# Advent of Code 2015 Day 7 - alternative complete solution
# Problem link: http://adventofcode.com/2015/day/7
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d07
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################
use 5.016;
use warnings;
use autodie;

#### INIT - load input data from file into array
my $testing = 0;
my @input;
my $file = $testing ? 'test.txt' : 'input.txt';
open( my $fh, '<', "$file" );
while (<$fh>) { chomp; s/\r//gm; push @input, $_; }

my @statements;
my %solutions;
my $part2 = shift || 0;
### CODE
while (@input) {
    my @line = split( /\s+/, shift @input );
    my $res = pop @line;
    pop @line;    # assignment arrow
    if ( $part2 and $res eq 'b' ) {
        @line = (956);
    }
    push @statements, [ $res, @line ];
}

sub value_of;

while ( !defined $solutions{'a'} ) {
    foreach my $item (@statements) {
        my @stmt   = @$item;
        my $sought = shift @stmt;

        if ( scalar @stmt == 1 ) {
            my $x = value_of( shift @stmt );
            $solutions{$sought} = $x if defined $x;
        }
        elsif ( scalar @stmt == 2 ) {
            my ( $op, $x ) = @stmt;
            die "unknown operator: $op " unless $op eq 'NOT';
            $x = value_of($x);
            $solutions{$sought} = ~$x if defined $x;
        }
        else {
            my ( $x, $op, $y ) = @stmt;
            die "unknown operator: $op"
              unless ( $op =~ m/AND|LSHIFT|RSHIFT|OR/ );
            $x = value_of($x);
            $y = value_of($y);
            next unless ( defined $x and defined $y );
            if ( $op eq 'AND' ) {
                $solutions{$sought} = $x & $y;
            }
            elsif ( $op eq 'OR' ) {
                $solutions{$sought} = $x | $y;
            }
            elsif ( $op eq 'LSHIFT' ) {
                $solutions{$sought} = $x << $y;
            }
            elsif ( $op eq 'RSHIFT' ) {
                $solutions{$sought} = $x >> $y;
            }
        }
    }
}

say $part2? 2 : 1, ". value of 'a': ", $solutions{'a'};

sub value_of {
    my ($in) = @_;
    if ( defined $solutions{$in} ) {
        return $solutions{$in};
    }
    elsif ( $in =~ m/\d+/ ) {
        return $in;
    }
    else {
        return undef;
    }
}

sub apply_op {
    my ( $x, $op, $y ) = @_;
    $x = value_of($x);
    $y = value_of($y);
    return undef unless ( defined $x and defined $y );
}

