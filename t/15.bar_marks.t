#!/usr/bin/env perl

use Test::More tests => 10;
use Carp;
use SVG::Sparkline;

use strict;
use warnings;

# positive only
{
    my $b1 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[4,2,8,10,5], mark=>[1=>'blue'] } );
    is( $b1->to_string,
        '<svg height="10" viewBox="0 -10 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-4h3v2h3v-6h3v-2h3v5h3v5z" fill="#000" stroke="none" /><rect fill="blue" height="2" stroke="none" width="3" x="3" y="-2" /></svg>',
        'pos only: mark index'
    );

    my $b2 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[4,2,8,10,5], mark=>[first=>'blue'] } );
    is( $b2->to_string,
        '<svg height="10" viewBox="0 -10 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-4h3v2h3v-6h3v-2h3v5h3v5z" fill="#000" stroke="none" /><rect fill="blue" height="4" stroke="none" width="3" x="0" y="-4" /></svg>',
        'pos only: mark first'
    );

    my $b3 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[4,2,8,10,5], mark=>[last=>'red'] } );
    is( $b3->to_string,
        '<svg height="10" viewBox="0 -10 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-4h3v2h3v-6h3v-2h3v5h3v5z" fill="#000" stroke="none" /><rect fill="red" height="5" stroke="none" width="3" x="12" y="-5" /></svg>',
        'pos only: mark last'
    );

    my $b4 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[4,2,8,10,5], mark=>[low=>'red'] } );
    is( $b4->to_string,
        '<svg height="10" viewBox="0 -10 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-4h3v2h3v-6h3v-2h3v5h3v5z" fill="#000" stroke="none" /><rect fill="red" height="2" stroke="none" width="3" x="3" y="-2" /></svg>',
        'pos only: mark low'
    );

    my $b5 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[4,2,8,10,5], mark=>[high=>'green'] } );
    is( $b5->to_string,
        '<svg height="10" viewBox="0 -10 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v-4h3v2h3v-6h3v-2h3v5h3v5z" fill="#000" stroke="none" /><rect fill="green" height="10" stroke="none" width="3" x="9" y="-10" /></svg>',
        'pos only: mark high'
    );
}
# negative only
{
    my $b1 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[-4,-2,-8,-10,-5], mark=>[1=>'blue'] } );
    is( $b1->to_string,
        '<svg height="10" viewBox="0 0 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v4h3v-2h3v6h3v2h3v-5h3v-5z" fill="#000" stroke="none" /><rect fill="blue" height="2" stroke="none" width="3" x="3" y="0" /></svg>',
        'neg only: mark index'
    );

    my $b2 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[-4,-2,-8,-10,-5], mark=>[first=>'blue'] } );
    is( $b2->to_string,
        '<svg height="10" viewBox="0 0 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v4h3v-2h3v6h3v2h3v-5h3v-5z" fill="#000" stroke="none" /><rect fill="blue" height="4" stroke="none" width="3" x="0" y="0" /></svg>',
        'neg only: mark first'
    );

    my $b3 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[-4,-2,-8,-10,-5], mark=>[last=>'red'] } );
    is( $b3->to_string,
        '<svg height="10" viewBox="0 0 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v4h3v-2h3v6h3v2h3v-5h3v-5z" fill="#000" stroke="none" /><rect fill="red" height="5" stroke="none" width="3" x="12" y="0" /></svg>',
        'neg only: mark last'
    );

    my $b4 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[-4,-2,-8,-10,-5], mark=>[low=>'red'] } );
    is( $b4->to_string,
        '<svg height="10" viewBox="0 0 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v4h3v-2h3v6h3v2h3v-5h3v-5z" fill="#000" stroke="none" /><rect fill="red" height="10" stroke="none" width="3" x="9" y="0" /></svg>',
        'neg only: mark low'
    );

    my $b5 = SVG::Sparkline->new( Bar => { -nodecl=>1, values=>[-4,-2,-8,-10,-5], mark=>[high=>'green'] } );
    is( $b5->to_string,
        '<svg height="10" viewBox="0 0 15 10" width="15" xmlns="http://www.w3.org/2000/svg"><path d="M0,0v4h3v-2h3v6h3v2h3v-5h3v-5z" fill="#000" stroke="none" /><rect fill="green" height="2" stroke="none" width="3" x="3" y="0" /></svg>',
        'neg only: mark high'
    );
}

# pos and neg