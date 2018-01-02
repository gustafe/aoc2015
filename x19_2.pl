#! /usr/bin/env perl
# Advent of Code 2015 Day 19 - part 2 alternative solution
# Problem link: http://adventofcode.com/2015/day/19
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d19
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use 5.016;
use warnings;
use autodie;

# useful modules
use List::Util qw/sum/;
use Data::Dumper;

#### INIT - load input data from file into array
my $testing = 0;
my @input;
my $file = $testing ? 'test.txt' : 'input.txt';
open( my $fh, '<', "$file" );
while (<$fh>) { chomp; s/\r//gm; push @input, $_; }

### CODE
# adapted from https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/cy4k8ca/ by Reddit user /u/askalski
my %rules;
my $string = reverse pop @input;
pop @input;

while (@input) {
    my $line = shift @input;
    if ( $line =~ m/^(\S+) \=\> (\S+)$/ ) {
        $rules{ reverse $2 } = reverse $1;
    }
}

my $count = 0;
while ( $string =~ s/(@{[ join "|", keys %rules ]})/$rules{$1}/ ) {
    $count++;
}

say "2. shortest number of steps: $count";
