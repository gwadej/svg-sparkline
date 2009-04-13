#!/usr/bin/env perl

use Test::More tests => 16;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

# positive only
{
    my @yvalues = (72,73,74,80,75,77,70,73);
    my $points=qq{0,-2 1,-3 2,-4 3,-10 4,-5 5,-7 6,0 7,-3};
    my $l1 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[2=>'blue'] } );
    is( "$l1",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="2" cy="-4" fill="blue" r="1" stroke="none" /></svg>},
        'pos only: mark index'
    );

    my $l2 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[first=>'blue'] } );
    is( "$l2",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="0" cy="-2" fill="blue" r="1" stroke="none" /></svg>},
        'pos only: mark first'
    );

    my $l3 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[last=>'blue'] } );
    is( "$l3",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="7" cy="-3" fill="blue" r="1" stroke="none" /></svg>},
        'pos only: mark last'
    );

    my $l4 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[low=>'red'] } );
    is( "$l4",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="6" cy="0" fill="red" r="1" stroke="none" /></svg>},
        'pos only: mark low'
    );

    my $l5 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[high=>'green'] } );
    is( "$l5",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="3" cy="-10" fill="green" r="1" stroke="none" /></svg>},
        'pos only: mark high'
    );
}

# negative only
{
    my @yvalues = (-62,-63,-64,-70,-65,-67,-60,-63);
    my $points=qq{0,-8 1,-7 2,-6 3,0 4,-5 5,-3 6,-10 7,-7};
    my $l1 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[2=>'blue'] } );
    is( "$l1",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="2" cy="-6" fill="blue" r="1" stroke="none" /></svg>},
        'neg only: mark index'
    );

    my $l2 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[first=>'blue'] } );
    is( "$l2",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="0" cy="-8" fill="blue" r="1" stroke="none" /></svg>},
        'neg only: mark first'
    );

    my $l3 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[last=>'blue'] } );
    is( "$l3",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="7" cy="-7" fill="blue" r="1" stroke="none" /></svg>},
        'neg only: mark last'
    );

    my $l4 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[low=>'red'] } );
    is( "$l4",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="3" cy="0" fill="red" r="1" stroke="none" /></svg>},
        'neg only: mark low'
    );

    my $l5 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[high=>'green'] } );
    is( "$l5",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="6" cy="-10" fill="green" r="1" stroke="none" /></svg>},
        'neg only: mark high'
    );
}

# postive and negative
{
    my @yvalues = (3,2,1,-5,0,-2,5,2);
    my $points=qq{0,-8 1,-7 2,-6 3,0 4,-5 5,-3 6,-10 7,-7};
    my $l1 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[2=>'blue'] } );
    is( "$l1",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="2" cy="-6" fill="blue" r="1" stroke="none" /></svg>},
        'pos/neg only: mark index'
    );

    my $l2 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[first=>'blue'] } );
    is( "$l2",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="0" cy="-8" fill="blue" r="1" stroke="none" /></svg>},
        'pos/neg only: mark first'
    );

    my $l3 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[last=>'blue'] } );
    is( "$l3",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="7" cy="-7" fill="blue" r="1" stroke="none" /></svg>},
        'pos/neg only: mark last'
    );

    my $l4 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[low=>'red'] } );
    is( "$l4",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="3" cy="0" fill="red" r="1" stroke="none" /></svg>},
        'pos/neg only: mark low'
    );

    my $l5 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, mark=>[high=>'green'] } );
    is( "$l5",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="1" /><circle cx="6" cy="-10" fill="green" r="1" stroke="none" /></svg>},
        'pos/neg only: mark high'
    );
}

{
    my @yvalues = (72,73,74,80,75,77,70,73);
    my $points=qq{0,-2 1,-3 2,-4 3,-10 4,-5 5,-7 6,0 7,-3};
    my $l1 = SVG::Sparkline->new( Line => { -nodecl=>1, values=>\@yvalues, thick=>2, mark=>[2=>'blue'] } );
    is( "$l1",
        qq{<svg height="10" viewBox="0 -10 8 10" width="8" xmlns="http://www.w3.org/2000/svg"><polyline fill="none" points="$points" stroke="#000" stroke-width="2" /><circle cx="2" cy="-4" fill="blue" r="2" stroke="none" /></svg>},
        'Double size mark'
    );
}
