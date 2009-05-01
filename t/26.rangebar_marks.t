#!/usr/bin/env perl

use Test::More tests => 3;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

my @values = (
    [2,4], [3,6], [1,3], [5,10], [0,6]
);
my $path = 'M0,-2v-2h3v2h-3m3,-1v-3h3v3h-3m3,2v-2h3v2h-3m3,-4v-5h3v5h-3m3,5v-6h3v6h-3';
{
    my $mark = '<rect fill="blue" height="2" stroke="none" width="3" x="6" y="-1" />';
    my $rb = SVG::Sparkline->new( RangeBar => { -nodecl=>1, values=>\@values, mark=>[2=>'blue'] } );
    is( "$rb",
        qq[<svg height="12" viewBox="0 -11 15 12" width="15" xmlns="http://www.w3.org/2000/svg"><path d="$path" fill="#000" stroke="none" />$mark</svg>],
        'index mark'
    );
}

{
    my $mark = '<rect fill="blue" height="2" stroke="none" width="3" x="0" y="-2" />';
    my $rb = SVG::Sparkline->new( RangeBar => { -nodecl=>1, values=>\@values, mark=>[first=>'blue'] } );
    is( "$rb",
        qq[<svg height="12" viewBox="0 -11 15 12" width="15" xmlns="http://www.w3.org/2000/svg"><path d="$path" fill="#000" stroke="none" />$mark</svg>],
        'first mark'
    );
}

{
    my $mark = '<rect fill="blue" height="6" stroke="none" width="3" x="12" y="0" />';
    my $rb = SVG::Sparkline->new( RangeBar => { -nodecl=>1, values=>\@values, mark=>[last=>'blue'] } );
    is( "$rb",
        qq[<svg height="12" viewBox="0 -11 15 12" width="15" xmlns="http://www.w3.org/2000/svg"><path d="$path" fill="#000" stroke="none" />$mark</svg>],
        'last mark'
    );
}
