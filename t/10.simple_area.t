#!/usr/bin/env perl

use Test::More tests => 5;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my @yvalues = (10,5,-10,-5,3,8,12,20,18,10,5);

my $a1 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, width=>33 } );
isa_ok( $a1, 'SVG::Sparkline', 'Created a Area-type Sparkline.' );
is( $a1->to_string,
    '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="0,-3.33 0,-6.67 3.2,-5 6.4,0 9.6,-1.67 12.8,-4.33 16,-6 19.2,-7.33 22.4,-10 25.6,-9.33 28.8,-6.67 32,-5 32,-3.33" /></svg>',
    'width & 11 points: output correct'
);

my $a2 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, color=>'#888', width=>33 } );
is( $a2->to_string,
    '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polygon fill="#888" points="0,-3.33 0,-6.67 3.2,-5 6.4,0 9.6,-1.67 12.8,-4.33 16,-6 19.2,-7.33 22.4,-10 25.6,-9.33 28.8,-6.67 32,-5 32,-3.33" /></svg>',
    'color changed: output correct'
);

my $i = 0;
my @values = map { [ $i++, $_ ] } @yvalues;
my $a3 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@values, width=>33 } );
is( $a3->to_string,
    '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="0,-3.33 0,-6.67 3.2,-5 6.4,0 9.6,-1.67 12.8,-4.33 16,-6 19.2,-7.33 22.4,-10 25.6,-9.33 28.8,-6.67 32,-5 32,-3.33" /></svg>',
    'width & 11 points: output correct'
);

my $a5 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues } );
is( $a5->to_string,
    '<svg height="10" viewBox="0 -10 11 10" width="11" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="0,-3.33 0,-6.67 1,-5 2,0 3,-1.67 4,-4.33 5,-6 6,-7.33 7,-10 8,-9.33 9,-6.67 10,-5 10,-3.33" /></svg>',
    'no width: output correct'
);

