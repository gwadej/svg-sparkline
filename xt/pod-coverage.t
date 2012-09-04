#!perl -T

use strict;
use warnings;

use Test::More;
eval "use Test::Pod::Coverage"; ## no critic(ProhibitStringyEval)
plan skip_all => "Test::Pod::Coverage required for testing POD coverage" if $@;
all_pod_coverage_ok();
