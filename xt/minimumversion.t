#!/usr/bin/perl

# Test that our declared minimum Perl version matches our syntax
use strict;
use warnings;

BEGIN
{
    $|  = 1;
    $^W = 1;
}

my @MODULES = ( 'Perl::MinimumVersion 1.20', 'Test::MinimumVersion 0.008', );

# Don't run tests during end-user installs
use Test::More;
plan( skip_all => 'Author tests not required for installation' )
    unless( $ENV{RELEASE_TESTING} or $ENV{AUTOMATED_TESTING} );

# Load the testing modules
foreach my $MODULE ( @MODULES )
{
    eval "use $MODULE";
    if( $@ )
    {
        $ENV{RELEASE_TESTING}
            ? die( "Failed to load required release-testing module $MODULE" )
            : plan( skip_all => "$MODULE not available for testing" );
    }
}

all_minimum_version_ok( '5.008' );

1;
