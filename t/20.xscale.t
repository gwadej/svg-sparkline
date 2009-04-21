#!/usr/bin/env perl

use Test::More tests => 6;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

my @yvalues = (10,5,-10,-5,3,8,12,20,18,10,5);

my $l = SVG::Sparkline->new( Line => { -nodecl=>1, xscale=>3, values=>\@yvalues } );
is( "$l",
    '<svg height="12" viewBox="0 -7.67 32 12" width="32" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="0,-3.33 3,-1.67 6,3.33 9,1.67 12,-1 15,-2.67 18,-4 21,-6.67 24,-6 27,-3.33 30,-1.67" stroke="#000" stroke-linecap="round" stroke-width="1" /></svg>',
    'Line: xscale=3'
);

my $a = SVG::Sparkline->new( Area => { -nodecl=>1, xscale=>3, values=>\@yvalues } );
is( "$a",
    '<svg height="12" viewBox="0 -7.67 32 12" width="32" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="0,0 0,-3.33 3,-1.67 6,3.33 9,1.67 12,-1 15,-2.67 18,-4 21,-6.67 24,-6 27,-3.33 30,-1.67 30,0" stroke="none" /></svg>',
    'Area: xscale=3'
);

my $b = SVG::Sparkline->new( Bar => { -nodecl=>1, xscale=>3, values=>[2,4,5,3,0,-2,-4,-3,-5,0,3,-3,5,2,0] } );
is( "$b",
    '<svg height="12" viewBox="0 -6 45 12" width="45" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h3v-2h3v-1h3v2h3v3h3v2h3v2h3v-1h3v2h3v-5h3v-3h3v6h3v-8h3v3h3v2h3z" fill="#000" stroke="none" /></svg>',
    'Bar: xscale=3'
);

my $l2 = SVG::Sparkline->new( Line => { -nodecl=>1, xscale=>5, values=>\@yvalues } );
is( "$l2",
    '<svg height="12" viewBox="0 -7.67 54 12" width="54" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="0,-3.33 5,-1.67 10,3.33 15,1.67 20,-1 25,-2.67 30,-4 35,-6.67 40,-6 45,-3.33 50,-1.67" stroke="#000" stroke-linecap="round" stroke-width="1" /></svg>',
    'Line: xscale=5'
);

my $a2 = SVG::Sparkline->new( Area => { -nodecl=>1, xscale=>5, values=>\@yvalues } );
is( "$a2",
    '<svg height="12" viewBox="0 -7.67 54 12" width="54" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="0,0 0,-3.33 5,-1.67 10,3.33 15,1.67 20,-1 25,-2.67 30,-4 35,-6.67 40,-6 45,-3.33 50,-1.67 50,0" stroke="none" /></svg>',
    'Area: xscale=5'
);

my $b2 = SVG::Sparkline->new( Bar => { -nodecl=>1, xscale=>5, values=>[2,4,5,3,0,-2,-4,-3,-5,0,3,-3,5,2,0] } );
is( "$b2",
    '<svg height="12" viewBox="0 -6 75 12" width="75" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h5v-2h5v-1h5v2h5v3h5v2h5v2h5v-1h5v2h5v-5h5v-3h5v6h5v-8h5v3h5v2h5z" fill="#000" stroke="none" /></svg>',
    'Bar: xscale=5'
);

