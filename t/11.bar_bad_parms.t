#!/usr/bin/env perl

use Test::More tests => 3;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;


eval { SVG::Sparkline->new( 'Bar', { y=>{} } ) };
like( $@, qr/Missing required 'y'/, '\'y\' data is a hash.' );

eval { SVG::Sparkline->new( 'Bar', { y=>[] } ) };
like( $@, qr/No values for 'y' specified/, 'Empty \'y\' data array.' );

eval { SVG::Sparkline->new( 'Bar', { y=>'' } ) };
like( $@, qr/Missing required 'y'/, 'Empty \'y\' data string.' );

