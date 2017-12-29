#! /usr/bin/env perl
# Advent of Code 2015 Day 13 - complete solution
# Problem link: http://adventofcode.com/2015/day/13
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d13
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################
use 5.016;
use warnings;
use autodie;
use List::Util qw/max/;
use Algorithm::Combinatorics qw(permutations);
#### INIT - load input data from file into array
my $testing = 0;
my @input;
my $file = $testing ? 'test.txt' : 'input.txt';
open( my $fh, '<', "$file" );
while (<$fh>) { chomp; s/\r//gm; push @input, $_; }

### CODE
my $part2 = shift || 0;
my $people;
my $feels;
while (@input) {
    my $line = shift @input;
    my ($p1, $op, $val, $p2 ) = ( $line =~ m/^(\S+) would (\S+) (\d+) .* (\S+)\.$/);
    $val = -$val if $op eq 'lose';
    $feels->{$p1}->{$p2} = $val;
    $people->{$p1}++;
    $people->{$p2}++;
}

if ($part2) {
    foreach my $p (keys %{$people}) {
	$people->{Gustaf}++;
	$feels->{Gustaf}->{$p} = 0;
	$feels->{$p}->{Gustaf} = 0;
    }
}
# Generate all permutations
my @list = keys %{$people};

my $arrangement = permutations(\@list);
my $max=0;
while ( my $arr = $arrangement->next ) {
    my $happiness = 0;
    my @arr = @{$arr}; # makes following code a bit easier to write
    for ( my $idx = 0; $idx <= $#arr; $idx++ ) {
	if ( $idx == 0 ) { # start of the list
	    $happiness += ($feels->{$arr[$idx]}->{$arr[$idx+1]} +
			   $feels->{$arr[$idx]}->{$arr[$#arr]} )
	} elsif ( $idx == $#arr ) { # end of the list
	    $happiness += ($feels->{$arr[$idx]}->{$arr[0]} +
			   $feels->{$arr[$idx]}->{$arr[$idx-1]} )
	} else {
	    $happiness += ( $feels->{$arr[$idx]}->{$arr[$idx+1]} +
			    $feels->{$arr[$idx]}->{$arr[$idx-1]} )
	}
    }
    #    print $happiness, ' ', join(' ', @arr), "\n";
    $max = max($max, $happiness);
}

say $part2?'2':'1',". happiness change: $max";
