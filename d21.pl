#!/usr/bin/perl
# Advent of Code 2015 Day 21 - complete solution
# Problem link: http://adventofcode.com/2015/day/21
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d21
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

# part 1: pipe output through grep 'Win' | sort -n | head -1
# part 2: pipe output through grep 'Loss' | sort -rn | head -1

use strict;
use warnings;
use feature qw/say/;
use List::Util qw/sum/;

my %boss = ( HP => 109, damage => 8, armor => 2 );

my %weapons = ( Dagger     => { cost => 8,  damage => 4, defense => 0 },
                Shortsword => { cost => 10, damage => 5, defense => 0 },
                Warhammer  => { cost => 25, damage => 6, defense => 0 },
                Longsword  => { cost => 40, damage => 7, defense => 0 },
                Greataxe   => { cost => 74, damage => 8, defense => 0 } );
my %armors = ( Leather    => { cost => 13,  defense => 1, damage => 0 },
               Chainmail  => { cost => 31,  defense => 2, damage => 0 },
               Splintmail => { cost => 53,  defense => 3, damage => 0 },
               Bandedmail => { cost => 75,  defense => 4, damage => 0 },
               Platemail  => { cost => 102, defense => 5, damage => 0 },
               None       => { cost => 0,   defense => 0, damage => 0 } );
my %rings = ( 'Damage +1'  => { cost => 25,  damage  => 1, defense => 0 },
              'Damage +2'  => { cost => 50,  damage  => 2, defense => 0 },
              'Damage +3'  => { cost => 100, damage  => 3, defense => 0 },
              'Defense +1' => { cost => 20,  defense => 1, damage  => 0 },
              'Defense +2' => { cost => 40,  defense => 2, damage  => 0 },
              'Defense +3' => { cost => 80,  defense => 3, damage  => 0 },
              None         => { cost => 0,   defense => 0, damage  => 0 } );

my @loadouts;
my %combo;
foreach my $weapon ( sort keys %weapons ) {
    $combo{weapon} = $weapon;

    # add armor
    foreach my $armor ( sort ( keys %armors ) ) {
        $combo{armor} = $armor;

        # right hand
        foreach my $ring_rh ( sort ( keys %rings ) ) {
            $combo{RH} = $ring_rh;

            # left hand
            foreach my $ring_lh ( sort ( keys %rings ) ) {
                next if ( ( $ring_lh eq $ring_rh ) and $ring_lh ne 'None' );
                $combo{LH} = $ring_lh;

                $combo{cost} = sum( $weapons{ $combo{weapon} }->{cost},
                                    $armors{ $combo{armor} }->{cost},
                                    $rings{ $combo{RH} }->{cost},
                                    $rings{ $combo{LH} }->{cost} );
                $combo{defense} = sum( $weapons{ $combo{weapon} }->{defense},
                                       $armors{ $combo{armor} }->{defense},
                                       $rings{ $combo{RH} }->{defense},
                                       $rings{ $combo{LH} }->{defense} );
                $combo{damage} = sum( $weapons{ $combo{weapon} }->{damage},
                                      $armors{ $combo{armor} }->{damage},
                                      $rings{ $combo{RH} }->{damage},
                                      $rings{ $combo{LH} }->{damage} );
                push @loadouts,
                    { items => join( ',',
                                     map { $combo{$_} } qw/weapon armor RH LH/
                      ),
                      cost    => $combo{cost},
                      defense => $combo{defense},
                      damage  => $combo{damage} };
            }
        }
    }
}
foreach my $l (@loadouts) {

    # simulate a battle!
    my $player = 100;
    my $boss   = $boss{HP};
    while ( $player >= 0 and $boss >= 0 ) {

        # player attacks
        my $attack
            = $l->{damage} - $boss{armor} <= 0
            ? 1
            : $l->{damage} - $boss{armor};
        $boss -= $attack;

        # boss attacks
        my $defend
            = $boss{damage} - $l->{defense} <= 0
            ? 1
            : $boss{damage} - $l->{defense};
        $player -= $defend;
    }
    say join( ' ', $l->{cost}, $player < $boss ? 'Loss' : 'Win' );
}
