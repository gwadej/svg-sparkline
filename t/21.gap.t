#!/usr/bin/env perl

use Test::More tests => 1;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

my $w = SVG::Sparkline->new( Whisker => { -nodecl=>1, values=>'++--+-+-', gap=>4 } );
is( "$w",
     '<svg height="12" viewBox="0 -6 40 12" width="40" xmlns="http://www.w3.org/2000/svg"><path d="M2,0v-5m5,5v-5m5,5v5m5,-5v5m5,-5v-5m5,5v5m5,-5v-5m5,5v5m5,-5" stroke="#000" stroke-width="1" /></svg>',
    'Whisker: gap of 4'
);

