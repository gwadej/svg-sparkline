#!/usr/bin/env perl

use Test::More tests => 8;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my $b1 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[2,4,8,10,5,0,4,8,4,0,1,3,5,2,0] } );
isa_ok( $b1, 'SVG::Sparkline', 'Created a Area-type Sparkline.' );
is( $b1->to_string,
    '<svg height="10" viewBox="0 -10 45 10" width="45" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h3v-2h3v-4h3v-2h3v5h3v5h3v-4h3v-4h3v4h3v4h3v-1h3v-2h3v-2h3v3h3v2h3z" fill="#000" stroke="none" /></svg>',
    'pos only: output correct'
);

my $b2 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[2,4,8,10,5,0,4,8,4,0,1,3,5,2,0], width=>60 } );
is( $b2->to_string,
    '<svg height="10" viewBox="0 -10 60 10" width="60" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h4v-2h4v-4h4v-2h4v5h4v5h4v-4h4v-4h4v4h4v4h4v-1h4v-2h4v-2h4v3h4v2h4z" fill="#000" stroke="none" /></svg>',
    'pos only with width: output correct'
);

my $b3 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[2,4,8,10,5,0,4,8,4,0,1,3,5,2,0], color=>'#008' } );
is( $b3->to_string,
    '<svg height="10" viewBox="0 -10 45 10" width="45" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h3v-2h3v-4h3v-2h3v5h3v5h3v-4h3v-4h3v4h3v4h3v-1h3v-2h3v-2h3v3h3v2h3z" fill="#008" stroke="none" /></svg>',
    'pos only color: output correct'
);

my $b4 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[2,4,5,3,0,-2,-4,-3,-5,0,3,-3,5,2,0] } );
is( $b4->to_string,
    '<svg height="10" viewBox="0 -10 45 10" width="45" xmlns="http://www.w3.org/2000/svg"><path d="M0,-5v-2h3v-2h3v-1h3v2h3v3h3v2h3v2h3v-1h3v2h3v-5h3v-3h3v6h3v-8h3v3h3v2h3z" fill="#000" stroke="none" /></svg>',
    'pos/neg: output correct'
);

my $b5 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[2,2,5,0,-2,-2,-5] } );
is( $b5->to_string,
    '<svg height="10" viewBox="0 -10 21 10" width="21" xmlns="http://www.w3.org/2000/svg"><path d="M0,-5v-2h3h3v-3h3v5h3v2h3h3v3h3v-5z" fill="#000" stroke="none" /></svg>',
    'dupes: output correct'
);

my $b6 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[1,2,3,4,3,2,1] } );
is ( $b6->to_string,
    '<svg height="10" viewBox="0 -10 21 10" width="21" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2.5h3v-2.5h3v-2.5h3v-2.5h3v2.5h3v2.5h3v2.5h3v2.5z" fill="#000" stroke="none" /></svg>',
    'pos: output correct'
);

my $b7 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[-1,-2,-3,-4,-3,-2,-1] } );
is ( $b7->to_string,
    '<svg height="10" viewBox="0 -10 21 10" width="21" xmlns="http://www.w3.org/2000/svg"><path d="M0,-10v2.5h3v2.5h3v2.5h3v2.5h3v-2.5h3v-2.5h3v-2.5h3v-2.5z" fill="#000" stroke="none" /></svg>',
    'negs: output correct'
);

