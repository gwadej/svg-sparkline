#!/usr/bin/env perl

use Test::More tests => 5;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

eval { SVG::Sparkline->new( Area => { } ) };
like( $@, qr/Missing required 'values'/, 'values is not an array' );

eval { SVG::Sparkline->new( Area => { values=>''} ) };
like( $@, qr/'values' must be an array reference/, 'values is not an array' );

eval { SVG::Sparkline->new( Area => { values=>[] } ) };
like( $@, qr/No values for 'values' specified/, 'values is empty' );

eval { SVG::Sparkline->new( Area => { values=>[[0,1], [1,2], 3, [4,5]] } ) };
like( $@, qr/not a pair/, 'value is not an array ref' );

eval { SVG::Sparkline->new( Area => { values=>[[0,1], [1,2], [3], [4,5]] } ) };
like( $@, qr/not a pair/, 'value is not a pair' );

