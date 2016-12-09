#!/usr/bin/perl
# Advent of Code 2015 Day 7 - complete solution
# Problem link: http://adventofcode.com/2015/day/7
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d7
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

my $file = 'input.txt';
open F, "<$file" or die "can't open $file: $!\n";

my @statements;
my %solutions;
while (<F>) {
    chomp;
    s/\r//gm;
    my ( $lhs, $res ) = ( $_ =~ m/^(.*) -> (\S+)$/ );
    push @statements, [ $res, $lhs ];
}

while ( !defined $solutions{'a'} ) {
    foreach my $stmt (@statements) {
        my $sought = $stmt->[0];
        if ( $stmt->[1] =~ m/^(\S+) (AND|OR|LSHIFT|RSHIFT) (\S+)$/ ) {
            my ( $a, $op, $b ) = ( $1, $2, $3 );

            if ( $a =~ m/\d+/ ) {
            } elsif ( $a =~ m/\S+/ ) {
                $a = $solutions{$a};
            } else {
                $a = undef;
            }

            if ( $b =~ m/\d+/ ) {
            } elsif ( $b =~ m/\S+/ ) {
                $b = $solutions{$b};
            } else {
                $b = undef;
            }
            if ( $op eq 'AND' ) {
                next unless ( defined $a and defined $b );
                $solutions{$sought} = $a & $b;
            } elsif ( $op eq 'OR' ) {
                next unless ( defined $a and defined $b );
                $solutions{$sought} = $a | $b;
            } elsif ( $op eq 'LSHIFT' ) {
                next unless ( defined $a and defined $b );
                $solutions{$sought} = $a << $b;
            } elsif ( $op eq 'RSHIFT' ) {
                next unless ( defined $a and defined $b );
                $solutions{$sought} = $a >> $b;
            }
        } elsif ( $stmt->[1] =~ m/^NOT (\S+)$/ ) {
            my $b = $1;
            if ( $b =~ m/\d+/ ) {
            } elsif ( $b =~ m/\S+/ ) {
                $b = $solutions{$b};
            } else {
                $b = undef;
            }
            $solutions{$sought} = ~$b if defined $b;
        } else {
            my $b = $stmt->[1];
            if ( $b =~ m/\d+/ ) {
            } elsif ( $b =~ m/\S+/ ) {
                $b = $solutions{$b};
            } else {
                $b = undef;
            }
            $solutions{$sought} = $b if defined $b;
        }
    }
}
print $solutions{'a'}, "\n";

