#!/usr/bin/env perl

use Test::More tests => 3;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my $a1 = SVG::Sparkline->new( 'Area', { -nodecl=>1, x=>[0..10], y=>[10,5,-10,-5,3,8,12,20,18,10,5], width=>33 } );
isa_ok( $a1, 'SVG::Sparkline', 'Created a Area-type Sparkline.' );
is( $a1->to_string,
    '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="0,0 0,-6.45 3,-4.84 6,-0 9,-1.61 12,-4.19 15,-5.81 18,-7.1 21,-9.68 24,-9.03 27,-6.45 30,-4.84" /></svg>',
    'width & 11 points: output correct'
);

my $a2 = SVG::Sparkline->new( 'Area', { -nodecl=>1, x=>[0..10], y=>[10,5,-10,-5,3,8,12,20,18,10,5], color=>'#888', width=>33 } );
is( $a2->to_string,
    '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polygon fill="#888" points="0,0 0,-6.45 3,-4.84 6,-0 9,-1.61 12,-4.19 15,-5.81 18,-7.1 21,-9.68 24,-9.03 27,-6.45 30,-4.84" /></svg>',
    'color changed: output correct'
);

