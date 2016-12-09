#!/usr/bin/perl
# Advent of Code 2015 Day 25 - part 1 / part 2 / complete solution
# Problem link: http://adventofcode.com/2015/day/25
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d25
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
use feature qw/say/;
use List::Util qw/sum/;
use Data::Dumper;

sub intdiv {    # divide a / b, return quotient and remainder
                # source: http://www.perlmonks.org/index.pl?node_id=981275
    use integer;
    my ( $a, $b ) = @_;
    my $q = $a / $b;
    my $r = $a % $b;
    return ( $q, $r );
}

my $debug   = 0;
my $testing = 0;
my ( $target_row, $target_col );
my $file = 'input.txt';
open F, "<$file" or die "can't open file: $!\n";
while (<F>) {
    chomp;
    s/\r//gm;
    ( $target_row, $target_col ) = ( $_ =~ /^.*row (\d+), column (\d+)\.$/ );
}
close F;

my $start   = 20151125;
my $factor  = 252533;
my $divisor = 33554393;

sub new_code {
    my ($input) = @_;
    my ( $p, $q ) = intdiv( $input * $factor, $divisor );
    return $q;
}
if ($testing) {
    ( $target_row, $target_col ) = ( 6, 6 );
}

say "Target values: row=$target_row, col=$target_col" if $debug;
my @testdata;
while (<DATA>) {
    chomp;
    my @row = split( /\s+/, $_ );
    push @testdata, \@row;
}

my $prev = $start;
my $next;
my $row = 2;
while ( $row <= $target_row + $target_col - 1 ) {
    say "$row" if $debug;
    my $cur_r = $row;
    my $col   = 1;
    while ( $cur_r >= 1 ) {
        $next = new_code($prev);
        if ( $cur_r <= $target_row and $col <= $target_col and $testing ) {
            die
"$cur_r,$col: $next not equal to testing data $testdata[$cur_r][$col]\n"
                unless ( $next == $testdata[$cur_r][$col] );
        }
        say "Answer = $next"
            if ( $cur_r == $target_row and $col == $target_col );
        $col++;
        $cur_r--;
        $prev = $next;
    }
    $row++;
}

__DATA__
0     1         2         3         4         5         6
1  20151125  18749137  17289845  30943339  10071777  33511524
2  31916031  21629792  16929656   7726640  15514188   4041754
3  16080970   8057251   1601130   7981243  11661866  16474243
4  24592653  32451966  21345942   9380097  10600672  31527494
5     77061  17552253  28094349   6899651   9250759  31663883
6  33071741   6796745  25397450  24659492   1534922  27995004
