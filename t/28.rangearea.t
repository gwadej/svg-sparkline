#!/usr/bin/env perl

use Test::More tests => 13;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my @values = (
    [2,4], [3,6], [1,3], [5,10], [0,6]
);
my $points = '0,-2 2,-3 4,-1 6,-5 8,0 8,-6 6,-10 4,-3 2,-6 0,-4';
{
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values } );
    isa_ok( $ra, 'SVG::Sparkline', 'Created a RangeArea-type Sparkline.' );
    is( "$ra",
        qq[<svg height="12" viewBox="0 -11 9 12" width="9" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],
        'pos only: output correct'
    );
    is( "$ra", $ra->to_string, 'Stringify works' );
}
exit;
{
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values, width=>20 } );
    my $points = 'M0,-2v-2h4v2h-4m4,-1v-3h4v3h-4m4,2v-2h4v2h-4m4,-4v-5h4v5h-4m4,5v-6h4v6h-4';
    is( "$ra",
        qq[<svg height="12" viewBox="0 -11 20 12" width="20" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],

        'pos only with width: output correct'
    );
}

{
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values, color=>'#008' } );
    is( "$ra",
        qq[<svg height="12" viewBox="0 -11 15 12" width="15" xmlns="http://www.w3.org/2000/svg"><polygon fill="#008" points="$points" stroke="none" /></svg>],
        'pos only color: output correct'
    );
}

{
    my @values = (
        [2,4], [3,5], [1,2], [-3,1], [-5,-2], [-4,4]
    );
    my $points = 'M0,-2v-2h3v2h-3m3,-1v-2h3v2h-3m3,2v-1h3v1h-3m3,4v-4h3v4h-3m3,2v-3h3v3h-3m3,-1v-8h3v8h-3';
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values } );
    is( "$ra",
        qq[<svg height="12" viewBox="0 -6 18 12" width="18" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],
        'pos/neg: output correct'
    );
}

{
    my @values = (
        [-2,0], [-10,-5], [-6,-3], [-3,-1], [-5,-2]
    );
    my $points = 'M0,2v-2h3v2h-3m3,8v-5h3v5h-3m3,-4v-3h3v3h-3m3,-3v-2h3v2h-3m3,2v-3h3v3h-3';
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values } );
    is( "$ra",
        qq[<svg height="12" viewBox="0 -1 15 12" width="15" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],
        'neg: output correct'
    );
}

{
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values, height=>10, pady=>0 } );
    is( "$ra",
        qq[<svg height="10" viewBox="0 -10 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],
        'pady=0'
    );
}

{
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values, height=>20, pady=>5 } );
    is( "$ra",
        qq[<svg height="20" viewBox="0 -15 15 20" width="15" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],
        'pady=5'
    );
}

{
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values, padx=>2 } );
    is( "$ra",
        qq[<svg height="12" viewBox="-2 -11 19 12" width="19" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],
        'padx=2'
    );
}

{
    my $points = 'M0.5,-2v-2h3v2h-3m4,-1v-3h3v3h-3m4,2v-2h3v2h-3m4,-4v-5h3v5h-3m4,5v-6h3v6h-3';
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values, gap=>1 } );
    is( "$ra",
        qq[<svg height="12" viewBox="0 -11 20 12" width="20" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],
        'gap=1'
    );
}

{
    my $points = 'M1.5,-2v-2h3v2h-3m6,-1v-3h3v3h-3m6,2v-2h3v2h-3m6,-4v-5h3v5h-3m6,5v-6h3v6h-3';
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values, gap=>3 } );
    is( "$ra",
        qq[<svg height="12" viewBox="0 -11 30 12" width="30" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],
        'gap=3'
    );
}

{
    my $points = 'M0,-2v-2h4v2h-4m4,-1v-3h4v3h-4m4,2v-2h4v2h-4m4,-4v-5h4v5h-4m4,5v-6h4v6h-4';
    my $ra = SVG::Sparkline->new( RangeArea => { -nodecl=>1, values=>\@values, thick=>4 } );
    is( "$ra",
        qq[<svg height="12" viewBox="0 -11 20 12" width="20" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /></svg>],
        'thick=4'
    );
}

