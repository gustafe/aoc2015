#!/usr/bin/perl
# Advent of Code 2015 Day 22 - complete solution
# Problem link: http://adventofcode.com/2015/day/22
#   Discussion: http://gerikson.com/blog/comp/adventofcode/Advent-of-Code-2015.html#d22
#      License: http://gerikson.com/files/AoC2015/UNLICENSE
###########################################################

use strict;
use warnings;
use feature qw/say/;
use List::Util qw/sum/;
use Data::Dumper;

my $testing = 0;
my $debug   = 0;
my $part    = 2;
my %spells = ( 'Magic Missile' => { cost => 53,  damage => 4 },
               Drain           => { cost => 73,  damage => 2, heal => 2 },
               Shield          => { cost => 113, effect => 6, armor => 7 },
               Poison          => { cost => 173, effect => 6, damage => 3 },
               Recharge        => { cost => 229, effect => 5, mana => 101 } );

my %player;
my %boss;
my %active;

sub apply_effect {
    my ($sp) = @_;
    say "  --> applying effect for spell: $sp" if $debug;
    if ( $sp eq 'Poison' ) {
        $boss{HP} -= $spells{$sp}->{damage};
        $active{$sp}--;
    } elsif ( $sp eq 'Shield' ) {
        $player{armor} = $spells{$sp}->{armor};
        $active{$sp}--;
    } elsif ( $sp eq 'Recharge' ) {
        $player{mana} += $spells{$sp}->{mana};
        $active{$sp}--;
    } else {
        die "what sorcery is this?! $sp\n";
    }
    say "  --> $sp has timer $active{$sp}" if $debug;
}

foreach my $run ( 1 .. 500_000 ) {    # may not be enough to find
                                      # solution in hard mode
    %player
        = $testing
        ? ( mana => 250, HP => 10, armor => 0 )
        : ( mana => 500, HP => 50, armor => 0 );
    %boss
        = $testing
        ? ( HP => 14, damage => 8 )
        : ( HP => 71, damage => 10 );
    %active = ( Recharge => 0, Shield => 0, Poison => 0 );
    my $cost = 0;
    my @seq  = ();
    my $turn = 1;

    say "RUN: $run" if $debug;
    while ( ( $player{HP} > 0 and $player{mana} > 0 ) and $boss{HP} > 0 ) {
        say "==> $turn" if $debug;

        # player always goes first

        say "-- Player turn --" if $debug;
        $player{HP}-- if $part == 2;    # hard mode
        say
"- Player has $player{HP} HP, $player{armor} armor, $player{mana} mana\n- Boss has $boss{HP} HP"
            if $debug;

        # are effects in play?
        foreach my $act ( keys %active ) {
            apply_effect($act) if $active{$act} > 0;
            $player{armor} = 0 if $active{Shield} <= 0;
        }

        # choose a random spell
        my $spell;
        do {
            $spell = ( keys %spells )[ rand keys %spells ];
        } until ( !exists $active{$spell} or $active{$spell} <= 0 );

        # all spells cost something
        $cost += $spells{$spell}->{cost};
        $player{mana} -= $spells{$spell}->{cost};
        push @seq, $spell;

        say "Player casts $spell for $spells{$spell}->{cost} mana" if $debug;
        if ( $spell eq 'Magic Missile' ) {
            $boss{HP} -= $spells{$spell}->{damage};
        } elsif ( $spell eq 'Drain' ) {
            $player{HP} += $spells{$spell}->{heal};
            $boss{HP} -= $spells{$spell}->{damage};
        } elsif ( $spell eq 'Shield' ) {
            $active{$spell} = $spells{$spell}->{effect};
            say "$spell activated, timer: $active{$spell}" if $debug;
            $player{armor} = 7;    # should not be cumulative
        } elsif ( $spell eq 'Poison' ) {
            $active{$spell} = $spells{$spell}->{effect};
            say "$spell activated, timer: $active{$spell}" if $debug;
        } elsif ( $spell eq 'Recharge' ) {
            $active{$spell} = $spells{$spell}->{effect};
            say "$spell activated, timer: $active{$spell}" if $debug;
        } else {
            die "what sorcery is this?! $spell\n";
        }
        last if ( $boss{HP} <= 0 );
        if ( $player{mana} < 0 ) { $player{HP} = -100; last; }

        # boss turn
        say "-- Boss turn --" if $debug;
        say
"- Player had $player{HP} HP, $player{armor} armor, $player{mana} mana\n- Boss has $boss{HP} HP"
            if $debug;

        foreach my $act ( keys %active ) {
            apply_effect($act) if $active{$act} > 0;
            $player{armor} = 0 if $active{Shield} <= 0;
        }
        last if ( $boss{HP} <= 0 );
        say "Boss attacks for $boss{damage}" if $debug;
        if ( $boss{damage} - $player{armor} < 0 ) {
            $player{HP}--;
        } else {
            $player{HP} -= ( $boss{damage} - $player{armor} );
        }

        # exit conditions
        last if ( $player{HP} <= 0 or $boss{HP} <= 0 );
        last if ( $player{mana} <= 0 );
        $turn++;
    }
    warn "==> $run\n" if $run % 10_000 == 0;
    say $cost, ' ', $player{HP} > $boss{HP} ? 'Win ' : 'Loss ',
        join( ', ', @seq ), ' ', sum( map { $spells{$_}->{cost} } @seq );
}
