#! /usr/bin/env perl
# Advent of Code 2015 Day 16 - complete solution
# Problem link: http://adventofcode.com/2015/day/16
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d16
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

### CODE
my $part2 = shift || 0;
my %aunts;

while (@input) {
    my $line = shift @input;
    my ( $aunt, $props ) = ( $line =~ m/^Sue (\d+): (.*)$/ );
    foreach my $p ( split( /,/, $props ) ) {
        my ( $k, $v ) = ( $p =~ m/(\S+)\: (\d+)/ );
        $aunts{$aunt}->{$k} = $v;
    }
}

my %clues;
while (<DATA>) {
    chomp;
    my ( $key, $val ) = ( $_ =~ /^(\S+)\: (\d+)$/ );
    $clues{$key} = $val;
}
my %scores;
foreach my $aunt ( keys %aunts ) {
    my $score      = 0;
    my %properties = %{ $aunts{$aunt} };
    foreach my $clue ( keys %clues ) {
        if ( exists $properties{$clue} ) {
            if ( $part2 and ( $clue eq 'cats' or $clue eq 'trees' ) ) {
                $score++ if $properties{$clue} > $clues{$clue};
            }
            elsif ( $part2
                and ( $clue eq 'goldfish' or $clue eq 'pomeranians' ) )
            {
                $score++ if $properties{$clue} < $clues{$clue};
            }
            else {
                $score++ if $properties{$clue} == $clues{$clue};
            }
        }
    }
    $scores{$aunt} = $score;

    #    print "$score $aunt\n";
}

my $winner = ( sort { $scores{$b} <=> $scores{$a} } keys %scores )[0];

say $part2? '2' : '1', ". ", $part2 ? 'real' : '',
  " Aunt Sue is nr $winner with score $scores{$winner}";

__DATA__
children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1
