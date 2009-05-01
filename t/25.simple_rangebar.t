#!/usr/bin/env perl

use Test::More tests => 5;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my @values = (
    [2,4], [3,6], [1,3], [5,10], [0,6]
);
my $path = 'M2,0v-2h3v2h-3m3,-1v-3h3v3h-3m3,-4v-5h3v5h-3m3,5v-6h3v6h-3';
{
    my $rb = SVG::Sparkline->new( RangeBar => { -nodecl=>1, values=>\@values } );
    isa_ok( $rb, 'SVG::Sparkline', 'Created a RangeBar-type Sparkline.' );
    is( "$rb",
        qq[<svg height="12" viewBox="0 -11 15 12" width="55" xmlns="http://www.w3.org/2000/svg"><path d="$path" fill="#000" stroke="none" /></svg>],
        'pos only: output correct'
    );
    is( "$rb", $rb->to_string, 'Stringify works' );
}

{
    my $rb = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>\@values, width=>20 } );
    my $pathw = $path;
    $pathw = s/(h-?)3/${1}4/g;
    is( "$rb",
        qq[<svg height="12" viewBox="0 -11 60 12" width="60" xmlns="http://www.w3.org/2000/svg"><path d="$pathw" fill="#000" stroke="none" /></svg>],
        'pos only with width: output correct'
    );
}

{
    my $rb = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>\@values, color=>'#008' } );
    is( "$rb",
        qq[<svg height="12" viewBox="0 -11 45 12" width="45" xmlns="http://www.w3.org/2000/svg"><path d="$path" fill="#008" stroke="none" /></svg>],
        'pos only color: output correct'
    );
}

#my $b4 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[2,4,5,3,0,-2,-4,-3,-5,0,3,-3,5,2,0] } );
#is( "$b4",
    #'<svg height="12" viewBox="0 -6 45 12" width="45" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h3v-2h3v-1h3v2h3v3h3v2h3v2h3v-1h3v2h3v-5h3v-3h3v6h3v-8h3v3h3v2h3z" fill="#000" stroke="none" /></svg>',
    #'pos/neg: output correct'
#);

#my $b5 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[2,2,5,0,-2,-2,-5] } );
#is( "$b5",
    #'<svg height="12" viewBox="0 -6 21 12" width="21" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2h6v-3h3v5h3v2h6v3h3v-5z" fill="#000" stroke="none" /></svg>',
    #'dupes: output correct'
#);

#my $b6 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[1,2,3,4,3,2,1] } );
#is ( "$b6",
    #'<svg height="12" viewBox="0 -11 21 12" width="21" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-2.5h3v-2.5h3v-2.5h3v-2.5h3v2.5h3v2.5h3v2.5h3v2.5z" fill="#000" stroke="none" /></svg>',
    #'pos: output correct'
#);

#my $b7 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[-1,-2,-3,-4,-3,-2,-1] } );
#is ( "$b7",
    #'<svg height="12" viewBox="0 -1 21 12" width="21" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v2.5h3v2.5h3v2.5h3v2.5h3v-2.5h3v-2.5h3v-2.5h3v-2.5z" fill="#000" stroke="none" /></svg>',
    #'negs: output correct'
#);

