#!/usr/bin/env perl

use Test::More tests => 5;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;


eval { SVG::Sparkline->new( RangeArea => { } ) };
like( $@, qr/Missing required 'values'/, '\'values\' data is not supplied' );

eval { SVG::Sparkline->new( RangeArea => { values=>{} } ) };
like( $@, qr/'values' must be an array reference/, '\'values\' data is a hash.' );

eval { SVG::Sparkline->new( RangeArea => { values=>[] } ) };
like( $@, qr/No values for 'values' specified/, 'Empty \'values\' data array.' );

eval { SVG::Sparkline->new( RangeArea => { values=>'' } ) };
like( $@, qr/'values' must be an array reference/, 'Empty \'values\' data string.' );

eval { SVG::Sparkline->new( RangeArea => { values=>[ 1,2,3,4 ] } ) };
like( $@, qr/'values' must be an array of pairs/, 'Scalars in \'values\'' );

