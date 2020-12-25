#!/usr/bin/perl 
# Advent of Code 2015 Day 12 - complete solution
# Problem link: http://adventofcode.com/2015/day/12
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d12
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################
use strict;
use warnings;
use JSON;
my $part2 = shift || 0;
my $sum = 0;

sub traverse {
    my ($in) = @_;
    if ( ref($in) eq 'ARRAY' ) {
        foreach my $el ( @{$in} ) {
            if ( ref($el) ) {
                traverse($el);
            }
            elsif ( $el =~ m/\d+/ ) {
                $sum += $el;
            }
        }
    }
    elsif ( ref($in) eq 'HASH' ) {

        # need to lookahead if we should even consider this hash
        my $redflag = 0;
        while ( my ( $k, $v ) = each %{$in} ) { $redflag = 1 if $v eq 'red' }

        # comment this next line for part 1 solution
        return if $redflag and $part2;
        foreach my $key ( keys %{$in} ) {
            if ( ref( $in->{$key} ) ) {
                traverse( $in->{$key} );
            }
            elsif ( $in->{$key} =~ m/\d+/ ) {
                $sum += $in->{$key};
            }
        }
    }
    else {    # should not occur according to problem text
        $sum += $in if ( $in =~ m/\d+/ );
    }
}

my $file = 'input.json';
open( my $fh, '<', "$file" ) or die "can't open $file: $!";
my $json_text = <$fh>;
my $data      = decode_json($json_text);

traverse($data);

print 'Part ', $part2 ? '2' : '1', " sum: $sum\n";

