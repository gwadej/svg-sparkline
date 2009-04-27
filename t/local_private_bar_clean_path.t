#!/usr/bin/env perl

use Test::More tests => 4;
use Carp;

use strict;
use warnings;
use SVG::Sparkline::Bar;

is( SVG::Sparkline::Bar::_clean_path( 'M0,0v1h2v-1h2v1h3v-1z' ),
    'M0,0v1h2v-1h2v1h3v-1z',
    'Simple path, no changes'
);

is( SVG::Sparkline::Bar::_clean_path( 'M0,0v1h2h3v-1h2v1h3v-1z' ),
    'M0,0v1h5v-1h2v1h3v-1z',
    'Double h, consolidated'
);

is( SVG::Sparkline::Bar::_clean_path( 'M0,0v1h2h1h2v-1h2v1h3v-1z' ),
    'M0,0v1h5v-1h2v1h3v-1z',
    'Triple h, consolidated'
);

is( SVG::Sparkline::Bar::_clean_path( 'M0,0v1h3v-1h2v1h3v-1h0z' ),
    'M0,0v1h3v-1h2v1h3v-1z',
    'Zero h, Removed'
);

