use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'SVG::Sparkline',
    license             => 'perl',
    dist_author         => 'G. Wade Johnson <wade@anomaly.org>',
    dist_version_from   => 'lib/SVG/Sparkline.pm',
    requires => {
        'Test::More' => 0,
        'Carp'       => 0,
        'SVG'        => 2.49,
    },
    add_to_cleanup      => [ 'SVG-Sparkline-*' ],
);

$builder->create_build_script();
