#!/usr/bin/env perl

use Test::More tests => 5;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;


eval { SVG::Sparkline->new( Whisker => { } ) };
like( $@, qr/Missing required 'values'/, '\'values\' is missing.' );

eval { SVG::Sparkline->new( Whisker => { values=>{} } ) };
like( $@, qr/Unrecognized type of/, '\'values\' data is a hash.' );

eval { SVG::Sparkline->new( Whisker => { values=>[] } ) };
like( $@, qr/No values specified/, 'Empty \'values\' data array.' );

eval { SVG::Sparkline->new( Whisker => { values=>'' } ) };
like( $@, qr/No values specified/, 'Empty \'values\' data string.' );

eval { SVG::Sparkline->new( Whisker => { values=>'+-*' } ) };
like( $@, qr/Unrecognized character/, 'Bad data string.' );

