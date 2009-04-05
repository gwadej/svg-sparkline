#!/usr/bin/env perl

use Test::More tests => 6;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my @yvalues = (10,5,-10,-5,3,8,12,20,18,10,5);

my $l1 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, width=>33 } );
isa_ok( $l1, 'SVG::Sparkline', 'Created a Line-type Sparkline.' );
is( $l1->to_string,
    '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="0,-6.67 3.2,-5 6.4,0 9.6,-1.67 12.8,-4.33 16,-6 19.2,-7.33 22.4,-10 25.6,-9.33 28.8,-6.67 32,-5" stroke="#000" stroke-width="1" /></svg>',
    'width & 11 points: output correct'
);

my $l2 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, thick=>0.5, width=>33 } );
is( $l2->to_string,
    '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="0,-6.67 3.2,-5 6.4,0 9.6,-1.67 12.8,-4.33 16,-6 19.2,-7.33 22.4,-10 25.6,-9.33 28.8,-6.67 32,-5" stroke="#000" stroke-width="0.5" /></svg>',
    'thickness changed: output correct'
);

my $l3 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, color=>'#888', width=>33 } );
is( $l3->to_string,
    '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="0,-6.67 3.2,-5 6.4,0 9.6,-1.67 12.8,-4.33 16,-6 19.2,-7.33 22.4,-10 25.6,-9.33 28.8,-6.67 32,-5" stroke="#888" stroke-width="1" /></svg>',
    'color changed: output correct'
);

my $i = 0;
my @values = map { [ $i++, $_ ] } @yvalues;
my $l4 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@values, width=>33 } );
is( $l4->to_string,
    '<svg height="10" viewBox="0 -10 33 10" width="33" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="0,-6.67 3.2,-5 6.4,0 9.6,-1.67 12.8,-4.33 16,-6 19.2,-7.33 22.4,-10 25.6,-9.33 28.8,-6.67 32,-5" stroke="#000" stroke-width="1" /></svg>',
    'width & 11 points: output correct'
);

my $l5 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues } );
is( $l5->to_string,
    '<svg height="10" viewBox="0 -10 11 10" width="11" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="0,-6.67 1,-5 2,0 3,-1.67 4,-4.33 5,-6 6,-7.33 7,-10 8,-9.33 9,-6.67 10,-5" stroke="#000" stroke-width="1" /></svg>',
    'width & 11 points: output correct'
);

