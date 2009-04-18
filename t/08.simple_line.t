#!/usr/bin/env perl

use Test::More tests => 7;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my @yvalues = (10,5,-10,-5,3,8,12,20,18,10,5);
my $points = '0,-3.33 3.2,-1.67 6.4,3.33 9.6,1.67 12.8,-1 16,-2.67 19.2,-4 22.4,-6.67 25.6,-6 28.8,-3.33 32,-1.67';

my $l1 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, width=>33 } );
isa_ok( $l1, 'SVG::Sparkline', 'Created a Line-type Sparkline.' );
is( "$l1",
    qq{<svg height="12" viewBox="0 -7.67 33 12" width="33" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-linecap="round" stroke-width="1" /></svg>},
    'width & 11 points: output correct'
);
is( "$l1", $l1->to_string, 'Stringify works' );

my $l2 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, thick=>0.5, width=>33 } );
is( "$l2",
    qq{<svg height="12" viewBox="0 -7.67 33 12" width="33" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-linecap="round" stroke-width="0.5" /></svg>},
    'thickness changed: output correct'
);

my $l3 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, color=>'#888', width=>33 } );
is( "$l3",
    qq{<svg height="12" viewBox="0 -7.67 33 12" width="33" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#888" stroke-linecap="round" stroke-width="1" /></svg>},
    'color changed: output correct'
);

my $i = 0;
my @values = map { [ $i++, $_ ] } @yvalues;
my $l4 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@values, width=>33 } );
is( "$l4",
    qq{<svg height="12" viewBox="0 -7.67 33 12" width="33" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-linecap="round" stroke-width="1" /></svg>},
    'width & 11 points: output correct'
);

$points = '0,-3.33 1,-1.67 2,3.33 3,1.67 4,-1 5,-2.67 6,-4 7,-6.67 8,-6 9,-3.33 10,-1.67';
my $l5 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues } );
is( "$l5",
    qq{<svg height="12" viewBox="0 -7.67 11 12" width="11" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-linecap="round" stroke-width="1" /></svg>},
    'width & 11 points: output correct'
);

