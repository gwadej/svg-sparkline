#!/usr/bin/env perl

use Test::More tests => 7;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

{
    my $expect = '<svg height="10" viewBox="0 -5 18 10" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M1,0m3,0v-5m3,5v-5m3,5m3,0v5m3,-5v5m3,-5" stroke="#000" stroke-width="1" /><line stroke="green" stroke-width="1" x1="7" x2="7" y1="0" y2="-5" /></svg>';
    my $w = SVG::Sparkline->new( Whisker => { -nodecl=>1, values=>'0++0--', mark=>[2=>'green'] } );
    is( $w->to_string, $expect, 'whisker: positive mark' );
}

{
    my $expect = '<svg height="10" viewBox="0 -5 18 10" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M1,0m3,0v-5m3,5v-5m3,5m3,0v5m3,-5v5m3,-5" stroke="#000" stroke-width="1" /><line stroke="red" stroke-width="1" x1="13" x2="13" y1="0" y2="5" /></svg>';
    my $w = SVG::Sparkline->new( Whisker => { -nodecl=>1, values=>'0++0--', mark=>[4=>'red'] } );
    is( $w->to_string, $expect, 'whisker: negative mark' );
}

{
    my $expect = '<svg height="10" viewBox="0 -5 18 10" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M1,0m3,0v-5m3,5v-5m3,5m3,0v5m3,-5v5m3,-5" stroke="#000" stroke-width="1" /></svg>';
    my $w = SVG::Sparkline->new( Whisker => { -nodecl=>1, values=>'0++0--', mark=>[3=>'green'] } );
    is( $w->to_string, $expect, 'whisker: tie mark' );
}

{
    my $expect = '<svg height="10" viewBox="0 -5 18 10" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M1,0m3,0v-5m3,5v-5m3,5m3,0v5m3,-5v5m3,-5" stroke="#000" stroke-width="1" /><line stroke="green" stroke-width="1" x1="7" x2="7" y1="0" y2="-5" /><line stroke="red" stroke-width="1" x1="13" x2="13" y1="0" y2="5" /></svg>';
    my $w = SVG::Sparkline->new( Whisker => { -nodecl=>1, values=>'0++0--', mark=>[2=>'green', 4=>'red'] } );
    is( $w->to_string, $expect, 'whisker: two marks' );
}

{
    my $expect = '<svg height="10" viewBox="0 -5 18 10" width="18" xmlns="http://www.w3.org/2000/svg"><path d="M1,0v-5m3,5m3,0v-5m3,5m3,0v5m3,-5v5m3,-5" stroke="#000" stroke-width="1" /><line stroke="green" stroke-width="1" x1="1" x2="1" y1="0" y2="-5" /><line stroke="red" stroke-width="1" x1="16" x2="16" y1="0" y2="5" /></svg>';
    my $w = SVG::Sparkline->new( Whisker => { -nodecl=>1, values=>'+0+0--', mark=>[first=>'green', last=>'red'] } );
    is( $w->to_string, $expect, 'whisker: named marks' );
}

eval {
    SVG::Sparkline->new( Whisker => { -nodecl=>1, values=>'+0+0--', mark=>[high=>'green'] } );
};
like( $@, qr/not a valid mark/, 'whisker: high mark not allowed' );

eval {
    SVG::Sparkline->new( Whisker => { -nodecl=>1, values=>'+0+0--', mark=>[low=>'green'] } );
};
like( $@, qr/not a valid mark/, 'whisker: low mark not allowed' );
