#!/usr/bin/perl
# Advent of Code 2015 Day 15 - complete solution
# Problem link: http://adventofcode.com/2015/day/15
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d15
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################
use strict;
use warnings;

my %data;
my $part2 = shift || 0;
my $file = 'input.txt';
open F, "<$file" or die "can't open file: $!\n";
while (<F>) {
    chomp;
    s/\r//gm;
    my ( $ingr, $cap, $dur, $flv, $tex, $cal ) =
      ( $_ =~
          m/^(\S+): .* (-?\d+),.* (-?\d+),.* (-?\d+),.* (-?\d+),.* (-?\d+)$/ );

    # each property gets an arrayref representing the ingredients
    push @{ $data{'cap'} }, $cap;
    push @{ $data{'dur'} }, $dur;
    push @{ $data{'flv'} }, $flv;
    push @{ $data{'tex'} }, $tex;
    push @{ $data{'cal'} }, $cal;
}

my @proportions;
foreach my $a ( 1 .. 100 ) {
    foreach my $b ( 1 .. ( 100 - $a ) ) {
        foreach my $c ( 1 .. ( 100 - ( $a + $b ) ) ) {
            foreach my $d ( 1 .. ( 100 - ( $a + $b + $c ) ) ) {
                next unless ( $a + $b + $c + $d ) == 100;
                push @proportions, [ $a, $b, $c, $d ];
            }
        }
    }
}
my %scores;
foreach my $proportion (@proportions) {
    my $cookie_score  = 1;
    my $calorie_count = 0;
    foreach my $property ( keys %data ) {
        my $property_score = 0;
        for ( my $idx = 0 ; $idx <= $#{$proportion} ; $idx++ ) {
            my $val = $proportion->[$idx] * ( $data{$property}->[$idx] );
            if ( $property eq 'cal' ) {
                $calorie_count += $val;
            }
            else {
                $property_score += $val;
            }
        }
        if ( $property_score < 1 ) { $property_score = 0 }
        $cookie_score *= $property_score unless $property eq 'cal';
    }
    if ($part2) {
        next unless $calorie_count == 500;
    }
    $scores{ join( ',', @$proportion ) } =
      { score => $cookie_score, cals => $calorie_count };
}

my $win =
  ( sort { $scores{$b}->{score} <=> $scores{$a}->{score} } keys %scores )[0];
print $part2? '2' : '1', ". winning score: ", $scores{$win}->{score}, "\n";

