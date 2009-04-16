#!/usr/bin/env perl

use Test::More tests => 15;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

# positive only
{
    my @yvalues = (72,73,74,80,75,77,70,73);
    my $points=qq{0,0 0,-2 1,-3 2,-4 3,-10 4,-5 5,-7 6,0 7,-3 7,0};
    my $l1 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[2=>'blue'] } );
    is( "$l1",
        qq{<svg height="12" viewBox="0 -11 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="blue" stroke-width="1" x1="2" x2="2" y1="0" y2="-4" /></svg>},
        'pos only: mark index'
    );

    my $l2 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[first=>'blue'] } );
    is( "$l2",
        qq{<svg height="12" viewBox="0 -11 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="blue" stroke-width="1" x1="0" x2="0" y1="0" y2="-2" /></svg>},
        'pos only: mark first'
    );

    my $l3 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[last=>'blue'] } );
    is( "$l3",
        qq{<svg height="12" viewBox="0 -11 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="blue" stroke-width="1" x1="7" x2="7" y1="0" y2="-3" /></svg>},
        'pos only: mark last'
    );

    my $l4 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[low=>'red'] } );
    is( "$l4",
        qq{<svg height="12" viewBox="0 -11 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="red" stroke-width="1" x1="6" x2="6" y1="0" y2="0" /></svg>},
        'pos only: mark low'
    );

    my $l5 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[high=>'green'] } );
    is( "$l5",
        qq{<svg height="12" viewBox="0 -11 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="green" stroke-width="1" x1="3" x2="3" y1="0" y2="-10" /></svg>},
        'pos only: mark high'
    );
}

# negative only
{
    my @yvalues = (-62,-63,-64,-70,-65,-67,-60,-63);
    my $points=qq{0,0 0,2 1,3 2,4 3,10 4,5 5,7 6,0 7,3 7,0};
    my $l1 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[2=>'blue'] } );
    is( "$l1",
        qq{<svg height="12" viewBox="0 -1 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="blue" stroke-width="1" x1="2" x2="2" y1="0" y2="4" /></svg>},
        'neg only: mark index'
    );

    my $l2 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[first=>'blue'] } );
    is( "$l2",
        qq{<svg height="12" viewBox="0 -1 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="blue" stroke-width="1" x1="0" x2="0" y1="0" y2="2" /></svg>},
        'neg only: mark first'
    );

    my $l3 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[last=>'blue'] } );
    is( "$l3",
        qq{<svg height="12" viewBox="0 -1 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="blue" stroke-width="1" x1="7" x2="7" y1="0" y2="3" /></svg>},
        'neg only: mark last'
    );

    my $l4 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[low=>'red'] } );
    is( "$l4",
        qq{<svg height="12" viewBox="0 -1 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="red" stroke-width="1" x1="3" x2="3" y1="0" y2="10" /></svg>},
        'neg only: mark low'
    );

    my $l5 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[high=>'green'] } );
    is( "$l5",
        qq{<svg height="12" viewBox="0 -1 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="green" stroke-width="1" x1="6" x2="6" y1="0" y2="0" /></svg>},
        'neg only: mark high'
    );
}

# postive and negative
{
    my @yvalues = (3,2,1,-5,0,-2,5,2);
    my $points=qq{0,0 0,-3 1,-2 2,-1 3,5 4,0 5,2 6,-5 7,-2 7,0};
    my $l1 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[2=>'blue'] } );
    is( "$l1",
        qq{<svg height="12" viewBox="0 -6 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="blue" stroke-width="1" x1="2" x2="2" y1="0" y2="-1" /></svg>},
        'pos/neg only: mark index'
    );

    my $l2 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[first=>'blue'] } );
    is( "$l2",
        qq{<svg height="12" viewBox="0 -6 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="blue" stroke-width="1" x1="0" x2="0" y1="0" y2="-3" /></svg>},
        'pos/neg only: mark first'
    );

    my $l3 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[last=>'blue'] } );
    is( "$l3",
        qq{<svg height="12" viewBox="0 -6 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="blue" stroke-width="1" x1="7" x2="7" y1="0" y2="-2" /></svg>},
        'pos/neg only: mark last'
    );

    my $l4 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[low=>'red'] } );
    is( "$l4",
        qq{<svg height="12" viewBox="0 -6 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="red" stroke-width="1" x1="3" x2="3" y1="0" y2="5" /></svg>},
        'pos/neg only: mark low'
    );

    my $l5 = SVG::Sparkline->new( Area => { -nodecl=>1, values=>\@yvalues, mark=>[high=>'green'] } );
    is( "$l5",
        qq{<svg height="12" viewBox="0 -6 8 12" width="8" xmlns="http://www.w3.org/2000/svg"><polygon fill="#000" points="$points" stroke="none" /><line fill="none" stroke="green" stroke-width="1" x1="6" x2="6" y1="0" y2="-5" /></svg>},
        'pos/neg only: mark high'
    );
}
