#!/usr/bin/env perl

use Test::More tests => 9;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

eval { SVG::Sparkline->new( 'Line', { } ) };
like( $@, qr/Missing required 'y'/, 'y is not an array' );

eval { SVG::Sparkline->new( 'Line', { y=>''} ) };
like( $@, qr/'y' must be an array reference/, 'y is not an array' );

eval { SVG::Sparkline->new( 'Line', { y=>[] } ) };
like( $@, qr/No values for 'y' specified/, 'y is empty' );

eval { SVG::Sparkline->new( 'Line', { y=>[1] } ) };
like( $@, qr/Missing required 'x'/, 'x is missing' );

eval { SVG::Sparkline->new( 'Line', { y=>[1], x=>'' } ) };
like( $@, qr/'x' must be an array reference/, 'x is not an array' );

eval { SVG::Sparkline->new( 'Line', { y=>[1], x=>[] } ) };
like( $@, qr/No values for 'x' specified/, 'x is empty' );

eval { SVG::Sparkline->new( 'Line', { y=>[1], x=>[2,3] } ) };
like( $@, qr/Count of/, 'counts do not match' );

eval { SVG::Sparkline->new( 'Line', { y=>[1,2], x=>[2,3] } ) };
like( $@, qr/Missing required 'width'/, 'width not specified' );

eval { SVG::Sparkline->new( 'Line', { y=>[1,2], x=>[2,3], width=>0 } ) };
like( $@, qr/Missing required 'width'/, 'width specified as 0' );


