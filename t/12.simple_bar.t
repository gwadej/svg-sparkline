#!/usr/bin/env perl

use Test::More tests => 5;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my $a1 = SVG::Sparkline->new( 'Bar', { -nodecl=>1, values=>[2,4,8,10,5,0,4,8,4,0,1,3,5,2,0] } );
isa_ok( $a1, 'SVG::Sparkline', 'Created a Area-type Sparkline.' );
is( $a1->to_string,
    '<svg height="10" viewBox="0 -10 45 10" width="45" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h3v-2h3v-4h3v-2h3v5h3v5h3v-4h3v-4h3v4h3v4h3v-1h3v-2h3v-2h3v3h3v2h3z" fill="#000" stroke="none" /></svg>',
    'pos only: output correct'
);

my $a2 = SVG::Sparkline->new( 'Bar', { -nodecl=>1, values=>[2,4,8,10,5,0,4,8,4,0,1,3,5,2,0], width=>60 } );
is( $a2->to_string,
    '<svg height="10" viewBox="0 -10 60 10" width="60" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h4v-2h4v-4h4v-2h4v5h4v5h4v-4h4v-4h4v4h4v4h4v-1h4v-2h4v-2h4v3h4v2h4z" fill="#000" stroke="none" /></svg>',
    'pos only with width: output correct'
);

my $a3 = SVG::Sparkline->new( 'Bar', { -nodecl=>1, values=>[2,4,8,10,5,0,4,8,4,0,1,3,5,2,0], color=>'#008' } );
is( $a3->to_string,
    '<svg height="10" viewBox="0 -10 45 10" width="45" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h3v-2h3v-4h3v-2h3v5h3v5h3v-4h3v-4h3v4h3v4h3v-1h3v-2h3v-2h3v3h3v2h3z" fill="#008" stroke="none" /></svg>',
    'pos only: output correct'
);

my $a4 = SVG::Sparkline->new( 'Bar', { -nodecl=>1, values=>[2,4,5,3,0,-2,-4,-3,-5,0,3,-3,5,2,0] } );
is( $a4->to_string,
    '<svg height="10" viewBox="0 -10 45 10" width="45" xmlns="http://www.w3.org/2000/svg"><path d="M0,-5v-2h3v-2h3v-1h3v2h3v3h3v2h3v2h3v-1h3v2h3v-5h3v-3h3v6h3v-8h3v3h3v2h3z" fill="#000" stroke="none" /></svg>',
    'pos/neg: output correct'
);

