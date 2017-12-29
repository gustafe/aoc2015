#!/usr/bin/perl
# Advent of Code 2015 Day 14 - complete solution with fancy scoreboard
# Problem link: http://adventofcode.com/2015/day/14
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d14
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################
use strict;
use warnings;

my $file = 'input.txt';
open F, "<$file" or die "can't open file: $!\n";

my %data; my %points;
while ( <F> ) {
    chomp;
    s/\r//gm;
    my ( $reindeer, $speed, $fly, $rest ) =
      ( $_ =~ m/^(\S+) can fly (\d+) km\/s for (\d+) .* (\d+) seconds\.$/ );
    $data{$reindeer} = { speed => $speed, fly => $fly, rest => $rest };
    # starting values
    $points{$reindeer} = { distance => 0, points => 0,
			   status => 'fly', time => $fly };
}

my $limit = ($file eq 'test.txt') ? 1_000 : 2_503;

my $time = 1;

while ( $time <= $limit ) { # check each second
    foreach my $deer ( keys %points ) {
	my ( $fly_time, $rest_time, $speed ) =
	  map { $data{$deer}->{$_} } qw/fly rest speed/;
	if ( $points{$deer}->{status} eq 'fly'  ) {
	    $points{$deer}->{distance} += $speed;
	}
	$points{$deer}->{time}--;
	if ( $points{$deer}->{time} == 0 ) { # switch status
	    if ( $points{$deer}->{status} eq 'fly' ) {
		$points{$deer}->{status} = 'rest';
		$points{$deer}->{time} = $rest_time;
	    } else {
		$points{$deer}->{status} = 'fly';
		$points{$deer}->{time} = $fly_time;
	    }
	}
    }

    # check distance, award points
    my $max = 0;
    foreach my $deer ( sort {$points{$b}->{distance}
			       <=> $points{$a}->{distance} } keys %points ) {
	$max = $points{$deer}->{distance} if $points{$deer}->{distance} > $max;
	$points{$deer}->{points}++ if $points{$deer}->{distance} == $max;
    }
    $time++;
}

# present results for 1 and 2  in a fancy way
my %categories = ( points => { desc => 'Points' },
		   distance => { desc => 'Distance' } );

foreach my $category ( sort keys %categories ) {
    my $rank = 1;
    printf("%s\n", $categories{$category}->{desc});
    print join('', '=' x length($categories{$category}->{desc})),"\n";
    foreach my $deer ( sort {$points{$b}->{$category}
			   <=> $points{$a}->{$category}} keys %points ) {
	printf("\#%d   %4s%s%s\n",
	       $rank,
	       $deer,
	       join('', ' ' x (14 - length($deer) - length($points{$deer}->{$category}))),
		   $points{$deer}->{$category});
	$rank++;
    }
    
    print "\n";
}

