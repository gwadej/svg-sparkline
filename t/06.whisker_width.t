#!/usr/bin/env perl

use Test::More tests => 8;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

{
    my $w = SVG::Sparkline->new( 'Whisker', { -nodecl=>1, y=>'++0+0+', width=>18 } );
    like( $w->to_string, qr/d="M1,0v-10m3,10v-10m3,10m3,0v-10m3,10m3,0v-10m3,10"/, 'Width=18' );
    like( $w->to_string, qr/stroke-width="1"/, 'Width=18: stroke' );
}

{
    my $w = SVG::Sparkline->new( 'Whisker', { -nodecl=>1, y=>'++0+0+', width=>9 } );
    like( $w->to_string, qr/d="M0.5,0v-10m1.5,10v-10m1.5,10m1.5,0v-10m1.5,10m1.5,0v-10m1.5,10"/, 'Width=9' );
    like( $w->to_string, qr/stroke-width="0.5"/, 'Width=9: stroke' );
}

{
    my $w = SVG::Sparkline->new( 'Whisker', { -nodecl=>1, y=>'++0+0+', width=>36 } );
    like( $w->to_string, qr/d="M2,0v-10m6,10v-10m6,10m6,0v-10m6,10m6,0v-10m6,10"/, 'Width=36' );
    like( $w->to_string, qr/stroke-width="2"/, 'Width=36: stroke' );
}

{
    my $w = SVG::Sparkline->new( 'Whisker', { -nodecl=>1, y=>'++0+0+', width=>10 } );
    like( $w->to_string, qr/d="M0.56,0v-10m1.68,10v-10m1.68,10m1.68,0v-10m1.68,10m1.68,0v-10m1.68,10"/, 'Width=10' );
    like( $w->to_string, qr/stroke-width="0.56"/, 'Width=10: stroke' );
}

