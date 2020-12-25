#!/usr/bin/perl
# Advent of Code 2015 Day 8 - part 2
# Problem link: http://adventofcode.com/2015/day/8
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d8
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

my $file = 'input.txt';
open F, "<$file" or die "can't open file: $!";

my $rep = 0;
my $act = 0;
while (<F>) {
    chomp;
    s/\r//gm;
    if ( $_ =~ m/^\"(.*)\"$/ ) {
        my @content = split( //, $1 );
        $act += scalar @content;   # add the actual lengh of the representaion
        $rep += scalar @content;   # start with original length
        $act += 2;                 # add the original quote;
        $rep += 2;                 # add the quotes
        $rep += 4;                 # add the encoded quotes
        while (@content) {
            my $c = shift @content;
            if ( $c !~ /\\/ ) {    # not a backslash
                                   # nop
            } else {
                $rep++;            # add the encoded backslash
                $c = shift @content;
                if ( $c eq 'x' ) {    # hex ascii
                                      # nop
                } elsif ( $c eq '"' ) {    #literal quote
                    $rep += 1;
                } elsif ( $c eq '\\' ) {    # literal backslash
                    $rep++;
                }
            }
        }
    } else {
        die "can't parse string: $_\n";
    }
}
close F;

print "Representation: $rep\n";
print "Actual: $act\n";
print "Difference: ", $rep - $act, "\n";

