#!/usr/bin/env perl

use Test::More tests => 4;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

my @yvalues = (10,5,-10,-5,3,8,12,20,18,10,5);

my $w = SVG::Sparkline->new( Whisker => { -nodecl=>1, -bgcolor=>'#fff', values=>[1,1,0,1,0,1] } );
is( $w->to_string,
     '<svg height="10" viewBox="0 -5 18 10" width="18" xmlns="http://www.w3.org/2000/svg"><rect fill="#fff" height="12" stroke="none" width="20" x="-1" y="-6" /><path d="M1,0v-5m3,5v-5m3,5m3,0v-5m3,5m3,0v-5m3,5" stroke="#000" stroke-width="1" /></svg>',
    'Whisker with background'
);

my $l = SVG::Sparkline->new( Line => { -nodecl=>1, -bgcolor=>'#fff', values=>\@yvalues } );
is( $l->to_string,
    '<svg height="10" viewBox="0 -10 11 10" width="11" xmlns="http://www.w3.org/2000/svg"><rect fill="#fff" height="12" stroke="none" width="13" x="-1" y="-11" /><polyline fill="none" points="0,-6.67 1,-5 2,0 3,-1.67 4,-4.33 5,-6 6,-7.33 7,-10 8,-9.33 9,-6.67 10,-5" stroke="#000" stroke-width="1" /></svg>',
    'Line with background'
);

my $a = SVG::Sparkline->new( Area => { -nodecl=>1, -bgcolor=>'#fff', values=>\@yvalues } );
is( $a->to_string,
    '<svg height="10" viewBox="0 -10 11 10" width="11" xmlns="http://www.w3.org/2000/svg"><rect fill="#fff" height="12" stroke="none" width="13" x="-1" y="-11" /><polygon fill="#000" points="0,-3.33 0,-6.67 1,-5 2,0 3,-1.67 4,-4.33 5,-6 6,-7.33 7,-10 8,-9.33 9,-6.67 10,-5 10,-3.33" /></svg>',
    'Area with background'
);

my $b = SVG::Sparkline->new( Bar => { -nodecl=>1, -bgcolor=>'#fff', values=>[2,4,5,3,0,-2,-4,-3,-5,0,3,-3,5,2,0] } );
is( $b->to_string,
    '<svg height="10" viewBox="0 -10 45 10" width="45" xmlns="http://www.w3.org/2000/svg"><rect fill="#fff" height="12" stroke="none" width="47" x="-1" y="-11" /><path d="M0,-5v-2h3v-2h3v-1h3v2h3v3h3v2h3v2h3v-1h3v2h3v-5h3v-3h3v6h3v-8h3v3h3v2h3z" fill="#000" stroke="none" /></svg>',
    'pos/neg: output correct'
);

