#!/usr/bin/env perl

use Test::More tests => 8;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;
my $expect = '<svg height="10" viewBox="0 -5 18 10" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M1,0v-5m3,5v-5m3,5m3,0v-5m3,5m3,0v-5m3,5" stroke="#000" stroke-width="1" /></svg>';

my $w1 = SVG::Sparkline->new( 'Whisker', { -nodecl=>1, values=>[1,1,0,1,0,1] } );
isa_ok( $w1, 'SVG::Sparkline', 'pos array: right type' );
is( $w1->to_string, $expect, 'pos array: output correct' );

my $w2 = SVG::Sparkline->new( 'Whisker', { -nodecl=>1, values=>'++0+0+' } );
isa_ok( $w2, 'SVG::Sparkline', 'pos tickstr: right type' );
is( $w2->to_string, $expect, 'pos tickstr: output correct' );

$expect = '<svg height="10" viewBox="0 -5 18 10" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M1,0v-5m3,5v-5m3,5v5m3,-5v-5m3,5v5m3,-5v-5m3,5" stroke="#000" stroke-width="1" /></svg>';
my $w3 = SVG::Sparkline->new( 'Whisker', { -nodecl=>1, values=>'110101' } );
isa_ok( $w3, 'SVG::Sparkline', 'pos binstr: right type' );
is( $w3->to_string, $expect, 'pos binstr: output correct' );

my $w4 = SVG::Sparkline->new( 'Whisker', { -nodecl=>1, values=>[0,1,1,0,0,-1,-1,-1,1,1,-1,-1] } );
like( $w4->to_string, qr/d="M1,0m3,0v-5m3,5v-5m3,5m3,0m3,0v5m3,-5v5m3,-5v5m3,-5v-5m3,5v-5m3,5v5m3,-5v5m3,-5"/,
    'posneg array: correct output' );

my $w5 = SVG::Sparkline->new( 'Whisker', { -nodecl=>1, values=>'0++00---++--' } );
like( $w5->to_string, qr/d="M1,0m3,0v-5m3,5v-5m3,5m3,0m3,0v5m3,-5v5m3,-5v5m3,-5v-5m3,5v-5m3,5v5m3,-5v5m3,-5"/,
    'posneg tickstr: correct output' );

