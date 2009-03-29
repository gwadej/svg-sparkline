#!/usr/bin/env perl

use Test::More tests => 3;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;


eval { SVG::Sparkline->new( 'Whisker', { y=>{} } ) };
like( $@, qr/Unrecognized type of/, '\'y\' data is a hash.' );

eval { SVG::Sparkline->new( 'Whisker', { y=>[] } ) };
like( $@, qr/No values specified/, 'Empty \'y\' data array.' );

eval { SVG::Sparkline->new( 'Whisker', { y=>'' } ) };
like( $@, qr/No values specified/, 'Empty \'y\' data string.' );

