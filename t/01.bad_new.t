#!/usr/bin/env perl

use Test::More tests => 19;
use Carp;

use strict;
use warnings;
use SVG::Sparkline;

eval { SVG::Sparkline->new(); };
like( $@, qr/No Sparkline type specified/, 'no parameters' );
eval { SVG::Sparkline->new( 'xyzzy' ); };
like( $@, qr/Unrecognized Sparkline type/, 'unrecognized type' );
eval { SVG::Sparkline->new( 'Whisker' ); };
like( $@, qr/Missing arguments hash/, 'Missing args' );
eval { SVG::Sparkline->new( 'Whisker', '' ); };
like( $@, qr/hash reference/, 'Not a hash reference' );

eval { SVG::Sparkline->new( Whisker => { values=>[1], height=>0 } ); };
like( $@, qr/positive numeric/, 'Bad height: 0' );
eval { SVG::Sparkline->new( Whisker => { values=>[1], height=>-2 } ); };
like( $@, qr/positive numeric/, 'Bad height: negative' );

eval { SVG::Sparkline->new( Whisker => { values=>[1], width=>0 } ); };
like( $@, qr/positive numeric/, 'Bad width: 0' );
eval { SVG::Sparkline->new( Whisker => { values=>[1], width=>-2 } ); };
like( $@, qr/positive numeric/, 'Bad width: negative' );

eval { SVG::Sparkline->new( Whisker => { values=>[1], xscale=>0 } ); };
like( $@, qr/positive numeric/, 'Bad xscale: 0' );
eval { SVG::Sparkline->new( Whisker => { values=>[1], xscale=>-2 } ); };
like( $@, qr/positive numeric/, 'Bad xscale: negative' );

eval { SVG::Sparkline->new( Whisker => { values=>[1], padx=>-2 } ); };
like( $@, qr/non-negative numeric/, 'Bad padx: negative' );
eval { SVG::Sparkline->new( Whisker => { values=>[1], pady=>-2 } ); };
like( $@, qr/non-negative numeric/, 'Bad pady: negative' );

eval { SVG::Sparkline->new( Whisker => { values => [1], color => '12345' } ); };
like( $@, qr/not a valid color/, 'bad color' );
eval { SVG::Sparkline->new( Whisker => { values => [1], bgcolor => '12345' } ); };
like( $@, qr/not a valid color/, 'bad bgcolor' );

eval { SVG::Sparkline->new( Whisker => { values => [1], mark => '12345' } ); };
like( $@, qr/array reference/, 'bad mark: not an array' );
eval { SVG::Sparkline->new( Whisker => { values => [1], mark => [1] } ); };
like( $@, qr/even number of/, 'bad mark: not pairs' );

eval {
    SVG::Sparkline->new( Whisker => { values => [1], mark => [ -1=>'red' ] } );
};
like( $@, qr/not a valid mark index/, 'bad mark index: -1' );
eval {
    SVG::Sparkline->new( Whisker => { values => [1], mark => [ middle=>'red' ] } );
};
like( $@, qr/not a valid mark index/, 'bad mark index: bad string' );
eval {
    SVG::Sparkline->new( Whisker => { values => [1], mark => [ 1=>'12345' ] } );
};
like( $@, qr/not a valid mark color/, 'bad mark color' );

