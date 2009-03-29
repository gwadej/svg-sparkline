#!/usr/bin/perl

use Test::More tests => 6;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;
my $expect = '<svg height="10" viewBox="0 -10 18 10" width="18" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M1,0v-10m3,10v-10m3,10m3,0v-10m3,10m3,0v-10m3,10" stroke="#000" stroke-width="1" /></svg>';

my $w1 = SVG::Sparkline->new( 'Whisker', { -inline=>1, y=>[1,1,0,1,0,1] } );
isa_ok( $w1, 'SVG::Sparkline', 'Positive only array' );
is( $w1->to_string, $expect, 'array: output correct' );

my $w2 = SVG::Sparkline->new( 'Whisker', { -inline=>1, y=>'110101' } );
isa_ok( $w2, 'SVG::Sparkline', 'Positive only binary string' );
is( $w1->to_string, $expect, 'binary string: output correct' );

my $w3 = SVG::Sparkline->new( 'Whisker', { -inline=>1, y=>'++0+0+' } );
isa_ok( $w3, 'SVG::Sparkline', 'Positive only tick string' );
is( $w1->to_string, $expect, 'tick string: output correct' );

