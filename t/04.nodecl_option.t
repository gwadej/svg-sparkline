#!/usr/bin/perl

use Test::More tests => 2;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

{
    my $w = SVG::Sparkline->new( Whisker => {values=>'++0++0--'} );
    like( "$w", qr/^<\?xml/, 'xml decl if missing -nodecl' );
}

{
    my $w = SVG::Sparkline->new( Whisker => {values=>'++0++0--', -nodecl=>1} );
    unlike( "$w", qr/^<\?xml/, 'no xml decl if -nodecl' );
}

