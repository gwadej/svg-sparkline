#!/usr/bin/env perl

use Test::More tests => 5;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

eval { SVG::Sparkline->new( Line => { } ) };
like( $@, qr/Missing required 'values'/, 'values is not an array' );

eval { SVG::Sparkline->new( Line => { values=>''} ) };
like( $@, qr/'values' must be an array reference/, 'values is not an array' );

eval { SVG::Sparkline->new( Line => { values=>[] } ) };
like( $@, qr/No values for 'values' specified/, 'values is empty' );

eval { SVG::Sparkline->new( Line => { values=>[[0,1], [1,2], 3, [4,5]] } ) };
like( $@, qr/not a pair/, 'value is not an array ref' );

eval { SVG::Sparkline->new( Line => { values=>[[0,1], [1,2], [3], [4,5]] } ) };
like( $@, qr/not a pair/, 'value is not a pair' );

#eval { SVG::Sparkline->new( Line => { y=>[1] } ) };
#like( $@, qr/Missing required 'x'/, 'x is missing' );

#eval { SVG::Sparkline->new( Line => { y=>[1], x=>'' } ) };
#like( $@, qr/'x' must be an array reference/, 'x is not an array' );

#eval { SVG::Sparkline->new( Line => { y=>[1], x=>[] } ) };
#like( $@, qr/No values for 'x' specified/, 'x is empty' );

#eval { SVG::Sparkline->new( Line => { y=>[1], x=>[2,3] } ) };
#like( $@, qr/Count of/, 'counts do not match' );

#eval { SVG::Sparkline->new( Line => { y=>[1,2], x=>[2,3] } ) };
#like( $@, qr/Missing required 'width'/, 'width not specified' );

#eval { SVG::Sparkline->new( Line => { y=>[1,2], x=>[2,3], width=>0 } ) };
#like( $@, qr/Missing required 'width'/, 'width specified as 0' );

