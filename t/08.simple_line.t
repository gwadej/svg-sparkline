#!/usr/bin/env perl

use Test::More tests => 2;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my $expect = '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="0,-6.45 3,-4.84 6,-0 9,-1.61 12,-4.19 15,-5.81 18,-7.1 21,-9.68 24,-9.03 27,-6.45 30,-4.84" stroke="#000" stroke-width="1" /></svg>';
my $w1 = SVG::Sparkline->new( 'Line', { -nodecl=>1, x=>[0..10], y=>[10,5,-10,-5,3,8,12,20,18,10,5], width=>33 } );
isa_ok( $w1, 'SVG::Sparkline', 'Created a Line-type Sparkline.' );
is( $w1->to_string, $expect, 'width & 11 points: output correct' );
open( my $fh, '>', 'sparkline.svg' );
print $fh $w1->to_string;
close $fh;

