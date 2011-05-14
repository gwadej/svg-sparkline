use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'SVG::Sparkline',
    AUTHOR              => 'G. Wade Johnson <wade@anomaly.org>',
    VERSION_FROM        => 'lib/SVG/Sparkline.pm',
    ABSTRACT_FROM       => 'lib/SVG/Sparkline.pm',
    LICENSE             => 'perl',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Carp'       => 0,
        'SVG'        => 2.49,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'SVG-Sparkline-*' },
    META_MERGE  => {
        recommends => {
#            'Test::Pod::Coverage' => 1.04,
        },
        build_requires => {
            'Test::More' => 0,  # For testing
        },
        resources => {
            license => 'http://dev.perl.org/licenses/',
            homepage => 'http://wiki.github.com/gwadej/svg-sparkline',
#            bugtracker => 'http://code.google.com/p/svg-sparkline/issues/list',
            repository => 'https://github.com/gwadej/svg-sparkline',
#            MailingList => 'http://groups.google.com/group/svg-sparkline',
        },
    },
);
