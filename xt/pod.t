#!perl -T

use strict;
use warnings;

use Test::More;
eval "use Test::Pod"; ## no critic(ProhibitStringyEval)
plan skip_all => "Test::Pod required for testing POD" if $@;
all_pod_files_ok();
