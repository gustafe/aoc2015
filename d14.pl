#! /usr/bin/env perl
# Advent of Code 2015 Day 14 - complete solution
# Problem link: http://adventofcode.com/2015/day/14
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d14
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################
use 5.016;
use warnings;
use autodie;
use List::Util qw/max/;

#### INIT - load input data from file into array
my $testing = 0;
my @input;
my $file = $testing ? 'test.txt' : 'input.txt';
open( my $fh, '<', "$file" );
while (<$fh>) { chomp; s/\r//gm; push @input, $_; }

### CODE
my %data;
my %points;

while (@input) {
    my $line = shift @input;
    my ( $id, $speed, $fly, $rest ) =
      ( $line =~ m/^(\S+) can fly (\d+) km\/s for (\d+) .* (\d+) seconds\.$/ );
    $data{$id} = { speed => $speed, fly => $fly, rest => $rest };
    $points{$id} =
      { distance => 0, points => 0, status => 'fly', time => $fly };
}

my $limit = $testing ? 1_000 : 2_503;

my $time = 1;

while ( $time <= $limit ) {    #check each second
    foreach my $d ( keys %points ) {
        my ( $fly_t, $rest_t, $speed ) =
          map { $data{$d}->{$_} } qw/fly rest speed/;
        if ( $points{$d}->{status} eq 'fly' ) {
            $points{$d}->{distance} += $speed;
        }
        $points{$d}->{time}--;
        if ( $points{$d}->{time} == 0 ) {    # switch status
            if ( $points{$d}->{status} eq 'fly' ) {
                $points{$d}->{status} = 'rest';
                $points{$d}->{time}   = $rest_t;
            }
            else {
                $points{$d}->{status} = 'fly';
                $points{$d}->{time}   = $fly_t;
            }
        }
    }

    my $max = 0;
    foreach my $d ( sort { $points{$b}->{distance} <=> $points{$a}->{distance} }
        keys %points )
    {
        $max = max( $max, $points{$d}->{distance} );
        $points{$d}->{points}++ if $points{$d}->{distance} == $max;
    }
    $time++;
}

my $win_distance =
  ( sort { $points{$b}->{distance} <=> $points{$a}->{distance} } keys %points )
  [0];
say
"1. winning the distance: $win_distance, with $points{$win_distance}->{distance} km";
my $win_points =
  ( sort { $points{$b}->{points} <=> $points{$a}->{points} } keys %points )[0];
say
  "2. winning the points: $win_points, with $points{$win_points}->{points} pts";

