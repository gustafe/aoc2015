#!/usr/bin/perl
# Advent of Code 2015 Day 11 - complete solution
# Problem link: http://adventofcode.com/2015/day/11
#   Discussion: http://gerikson.com/blog/comp/Advent-of-Code-2015.html#d11
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;

sub is_valid {    # used to fine-tune against example data
    my ($p) = @_;

    # we shouldn't generate these but might as well check
    return 0 if $p =~ m/[ilo]/;
    return 0 unless ( $p =~ m/(.)\1.*?(.)\2/g and $1 ne $2 );
    my $pwd = 0;
    my @p = split( //, $p );
    for ( my $i = 0 ; $i < scalar @p - 3 ; $i++ ) {
        if (     ord( $p[$i] ) + 1 == ord( $p[ $i + 1 ] )
             and ord( $p[$i] ) + 2 == ord( $p[ $i + 2 ] )
             and ord( $p[ $i + 1 ] ) + 1 == ord( $p[ $i + 2 ] ) )
        {
            $pwd = $p;
            next;
        }
    }
    return $pwd;
}

sub next_char {
    my ($c) = @_;
    my $next = ord($c) + 1;
    if ( $next == 105 or $next == 108 or $next == 111 ) { $next++ }
    if ( $next == ord('z') + 1 ) { $next = 97 }
    return chr($next);
}

my $in    = 'hxbxwxba';
my @pwd   = split( //, $in );
my $notch = 0
    ;  # see this as an odometer where a wheel turns over when this is engaged
my $valid = 0;
while ( !$valid ) {
    my $next = next_char( $pwd[$#pwd] );
    $pwd[$#pwd] = $next;
    if ( $next eq 'a' ) { $notch = $#pwd - 1 }

    # have we tripped the other wheels?
    while ( $notch > 0 ) {
        my $next = next_char( $pwd[$notch] );
        $pwd[$notch] = $next;
        if   ( $next eq 'a' ) { $notch-- }
        else                  { $notch = 0 }
    }

    # is this a candidate for further checks?
    if ( join( '', @pwd ) =~ m/(.)\1.*?(.)\2/g and $1 ne $2 ) {
        $valid = is_valid( join( '', @pwd ) );
    }
}
print "New password: $valid\n";

