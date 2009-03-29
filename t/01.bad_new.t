#!/usr/bin/env perl

use Test::More tests => 6;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

eval { SVG::Sparkline->new(); };
like( $@, qr/No Sparkline type specified/, 'no parameters' );
eval { SVG::Sparkline->new( 'xyzzy' ); };
like( $@, qr/Unrecognized Sparkline type/, 'unrecognized type' );
eval { SVG::Sparkline->new( 'Whisker' ); };
like( $@, qr/Missing arguments hash/, 'Missing args' );
eval { SVG::Sparkline->new( 'Whisker', '' ); };
like( $@, qr/hash reference/, 'Not a hash reference' );
eval { SVG::Sparkline->new( 'Whisker', {} ); };
like( $@, qr/Missing required/, 'No "y" parameter' );
eval { SVG::Sparkline->new( 'Whisker', { y=>undef } ) };
like( $@, qr/Missing required/, 'Undefined \'y\' data.' );

