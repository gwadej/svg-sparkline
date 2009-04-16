#!/usr/bin/env perl

use Test::More tests => 6;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my @yvalues = (10,5,-10,-5,3,8,12,20,18,10,5);
my $points = '0,0 0,-3.33 3.2,-1.67 6.4,3.33 9.6,1.67 12.8,-1 16,-2.67 19.2,-4 22.4,-6.67 25.6,-6 28.8,-3.33 32,-1.67 32,0';
  
my $a1 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, width=>33 } );
isa_ok( $a1, 'SVG::Sparkline', 'Created a Area-type Sparkline.' );
is( "$a1",
    qq{<svg height="12" viewBox="0 -7.67 33 12" width="33" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>},
    'width & 11 points: output correct'
);
is( "$a1", $a1->to_string, 'Stringify works' );

my $a2 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, color=>'#888', width=>33 } );
is( "$a2",
    qq{<svg height="12" viewBox="0 -7.67 33 12" width="33" xmlns="http://www.w3.org/2000/svg"><polygon fill="#888" points="$points" stroke="none" /></svg>},
    'color changed: output correct'
);

my $i = 0;
my @values = map { [ $i++, $_ ] } @yvalues;
my $a3 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@values, width=>33 } );
is( "$a3",
    qq{<svg height="12" viewBox="0 -7.67 33 12" width="33" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>},
    'width & 11 points: output correct'
);

$points = '0,0 0,-3.33 1,-1.67 2,3.33 3,1.67 4,-1 5,-2.67 6,-4 7,-6.67 8,-6 9,-3.33 10,-1.67 10,0';
my $a5 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues } );
is( "$a5",
    qq{<svg height="12" viewBox="0 -7.67 11 12" width="11" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>},
    'no width: output correct'
);

